package org.tinytlf.layout.block
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.properties.LayoutProperties;
	import org.tinytlf.util.TinytlfUtil;
	
	public class BlockConstraintRenderer extends StandardBlockRenderer implements IBlockRenderer
	{
		override public function render(block:TextBlock,
										existingLines:Vector.<TextLine> = null,
										constraints:Vector.<IConstraint> = null):Vector.<TextLine>
		{
			if(!existingLines || !existingLines.length)
				throw new Error('no lines wtf.');
			
			if(!constraints || !constraints.length)
				return existingLines;
			
			const props:LayoutProperties = TinytlfUtil.getLP(block);
			
			var line:TextLine = existingLines[0];
			var y:Number = line.y - line.ascent;
			line = line.previousLine;
			var lines:Vector.<TextLine> = new <TextLine>[];
			
			while(true)
			{
				lines.push.apply(null, renderLinesAt(y,
													 constraints.filter(function(constraint:IConstraint, ...args):Boolean{
					return constraint.intersectsY(y);
				}),
													 block,
													 line));
				
				if(lines.length)
				{
					line = lines[lines.length - 1];
					y = p.incrementValue(line, y);
				}
				else
				{
					var constraint:IConstraint = a.findClosestConstraint(constraints.concat(), a.edgeStartValue(block));
					y += constraint.textLine.totalHeight + 1;
					continue;
				}
				
				if(block.textLineCreationResult == TextLineCreationResult.COMPLETE)
					break;
			}
			
			return lines;
		}
		
		private function renderLinesAt(y:Number,
									   relevantConstraints:Vector.<IConstraint>,
									   block:TextBlock,
									   previousLine:TextLine):Array
		{
			var lines:Array = [];
			var line:TextLine = previousLine;
			
			var x:Number = a.findClosestValue(relevantConstraints.concat(), y, a.edgeStartValue(block));
			
			var constraint:IConstraint = a.findClosestConstraint(relevantConstraints.concat(), x);
			
			var totalWidth:Number = a.getTotalSize(block, previousLine);
			
			var segmentWidth:Number = totalWidth;
			
			while(a.isValueWithinBounds(x, totalWidth))
			{
				if(constraint)
				{
					segmentWidth = a.getConstraintDifference(constraint, x);
				}
				else
				{
					segmentWidth = totalWidth - x;
				}
				
				line = createTextLine(block, line, segmentWidth);
				
				if(line == null)
				{
					break;
				}
				
				lines.push(line);
				
				x = a.findClosestValue(relevantConstraints.concat(), y, x + segmentWidth);
			}
			
			return lines;
		}
	}
}