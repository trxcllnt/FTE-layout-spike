package org.tinytlf.layout.block
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.block.alignment.IBlockAlignment;
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.block.progression.IBlockProgression;
	import org.tinytlf.layout.properties.LayoutProperties;
	import org.tinytlf.util.*;
	import org.tinytlf.util.fte.*;
	
	public class StandardBlockRenderer implements IBlockRenderer
	{
		public function render(block:TextBlock,
							   existingLines:Vector.<TextLine> = null,
							   constraints:Vector.<IConstraint> = null):Vector.<TextLine>
		{
			var lines:Vector.<TextLine> = new <TextLine>[];
			var line:TextLine = block.firstLine;
			
			var contiguousValidLines:Boolean = true;
			
			while(line)
			{
				if(line.validity != TextLineValidity.VALID)
					contiguousValidLines = false;
				
				if(contiguousValidLines)
					lines.push(line);
				else
					TextLineUtil.checkIn(line);
				
				line = line.nextLine;
			}
			
			if(TextBlockUtil.isInvalid(block))
			{
				// This will be true if the block has been partially rendered.
				// Dunno if this case is ever true. Guess we'll see.
				var incompleteBlockRender:Boolean = (
					block.firstLine &&
					(block.firstInvalidLine == null ||
					block.textLineCreationResult != TextLineCreationResult.COMPLETE)
					);
				
				if(incompleteBlockRender)
					line = block.lastLine;
				else if(block.firstInvalidLine)
					line = block.firstInvalidLine.previousLine;
				else
					line = null;
				
				lines = lines.concat(createLines(block, line));
			}
			
			return lines.concat();
		}
		
		private function createLines(block:TextBlock, previousLine:TextLine):Vector.<TextLine>
		{
			var textLines:Vector.<TextLine> = new <TextLine>[];
			
			var line:TextLine = previousLine;
			
			while(true)
			{
				line = createTextLine(block, line, a.getTotalSize(block, line));
				
				if(line == null)
					break;
				
				textLines.push(line);
			}
			
			return textLines;
		}
		
		protected function createTextLine(block:TextBlock, previousLine:TextLine, width:Number):TextLine
		{
			var orphan:TextLine = TextLineUtil.checkOut();
			return orphan ?
				block.recreateTextLine(orphan, previousLine, width, 0.0, true) :
				block.createTextLine(previousLine, width, 0.0, true);
		}
		
		protected var a:IBlockAlignment;
		public function set alignment(value:IBlockAlignment):void
		{
			a = value;
		}
		
		protected var p:IBlockProgression;
		public function set progression(value:IBlockProgression):void
		{
			p = value;
		}
	}
}