package org.tinytlf.layout
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.alignment.*;
	import org.tinytlf.layout.constraints.IConstraint;
	import org.tinytlf.layout.progression.IBlockProgression;
	import org.tinytlf.util.*;
	
	public class StandardBlockRenderer implements IBlockRenderer
	{
		public function StandardBlockRenderer(aligner:IBlockAligner = null, progression:IBlockProgression = null)
		{
			a = aligner;
			p = progression;
		}
		
		public function render(block:TextBlock,
							   layout:LayoutProperties = null,
							   existingLines:Array = null,
							   constraints:Array = null):Array/*<TextLine>*/
		{
			layout ||= LayoutProperties.empty;
			
			var lines:Array = getValidLines(block);
			var line:TextLine;
			
			if(TextBlockUtil.isInvalid(block))
			{
				if(block.firstInvalidLine)
					line = block.firstInvalidLine.previousLine;
				else if(block.textLineCreationResult != TextLineCreationResult.COMPLETE)
					line = block.lastLine;
				
				lines = lines.concat(createLines(block, line, layout));
			}
			
			return lines.concat();
		}
		
		protected function getValidLines(block:TextBlock):Array/*<TextLine>*/
		{
			const lines:Array = [];
			var line:TextLine = block.firstLine;
			var valid:Boolean = true;
			
			while(line)
			{
				if(line.validity != TextLineValidity.VALID)
					valid = false;
				
				if(valid)
					lines.push(line);
				else
					TextLineUtil.checkIn(line);
				
				line = line.nextLine;
			}
			
			return lines;
		}
		
		private function createLines(block:TextBlock, pLine:TextLine, layout:LayoutProperties):Array/*<TextLine>*/
		{
			const lines:Array = [];
			
			var line:TextLine = pLine;
			
			while(true)
			{
				line = createTextLine(block, line, a.getSize(layout, line));
				
				if(line == null)
					break;
				
				lines.push(line);
			}
			
			return lines;
		}
		
		protected function createTextLine(block:TextBlock, previousLine:TextLine, width:Number):TextLine
		{
			var orphan:TextLine = TextLineUtil.checkOut();
			return orphan ?
				block.recreateTextLine(orphan, previousLine, width, 0.0, true) :
				block.createTextLine(previousLine, width, 0.0, true);
		}
		
		protected var a:IBlockAligner;
		
		public function set alignment(value:IBlockAligner):void
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