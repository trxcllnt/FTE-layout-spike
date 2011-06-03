package org.tinytlf.layout.block
{
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.properties.LayoutProperties;
	import org.tinytlf.util.TinytlfUtil;
	
	public class BlockConstraintLayout extends StandardBlockLayout implements IBlockLayout
	{
		override public function layout(lines:Vector.<TextLine>,
										constraints:Vector.<IConstraint> = null):Vector.<TextLine>
		{
			if(!lines || lines.length == 0)
				throw new Error('no lines. wtf.');
			
			if(!constraints || constraints.length == 0)
				return lines;
			
			var props:LayoutProperties;
			var prevLine:TextLine;
			
			//Layout the Ys first (this is required to flow the X around floats);
			lines.forEach(function(line:TextLine, ... args):void{
				props = TinytlfUtil.getLP(line);
				line.y = getYAdjustedByConstraints(line, prevLine, constraints, props.width);
				prevLine = line;
			});
			
			var x:Number = 0;
			
			lines.forEach(function(line:TextLine, ... args):void{
				props = TinytlfUtil.getLP(line);
				
				x = getXAdjustedByConstraints(
					line.y - line.ascent,
					constraints.filter(function(constraint:IConstraint, ... args):Boolean{
					return constraint.intersectsY(line.y - line.ascent);
				}),
					props.width,
					line.textBlock);
				
				x += props.paddingLeft;
				line.x = x;
			});
			
			return lines;
		}
		
		protected function getYAdjustedByConstraints(line:TextLine,
													 previousLine:TextLine,
													 constraints:Vector.<IConstraint>,
													 totalWidth:Number):Number
		{
			var y:Number = getY(line, previousLine);
			
			var relevantConstraints:Vector.<IConstraint> = 
				constraints.filter(function(constraint:IConstraint, ... args):Boolean{
				return constraint.intersectsY(y - line.ascent);
			});
			
			if(relevantConstraints.length == 0)
				return y;
			
			var x:Number = a.edgeStartValue(line.textBlock);
			
			var constraint:IConstraint = a.findClosestConstraint(relevantConstraints, x);
			
			while(constraint)
			{
				if(a.findClosestValue(relevantConstraints, y - line.ascent, x) < totalWidth)
				{
					break;
				}
				
				y += constraint.textLine.totalHeight + 1;
				
				relevantConstraints = constraints.filter(function(constraint:IConstraint, ... args):Boolean{
					return constraint.intersectsY(y - line.ascent);
				});
				
				constraint = a.findClosestConstraint(relevantConstraints, a.edgeStartValue(line.textBlock));
			}
			
			return y;
		}
		
		protected function getXAdjustedByConstraints(yValue:Number,
													 relevantConstraints:Vector.<IConstraint>,
													 totalWidth:Number,
													 block:TextBlock):Number
		{
			var x:Number = a.findClosestValue(relevantConstraints.concat(), yValue, a.edgeStartValue(block));
			var constraint:IConstraint = a.findClosestConstraint(relevantConstraints.concat(), x);
			
			while(a.isValueWithinBounds(x, totalWidth))
			{
				if(constraint)
				{
					if(x == constraint.getXAtY(yValue, x))
					{
						break;
					}
					
					x = constraint.getXAtY(yValue, x);
				}
				else
				{
					break;
				}
				
				constraint = a.findClosestConstraint(relevantConstraints.concat(), x);
			}
			
			return x;
		}
	}
}