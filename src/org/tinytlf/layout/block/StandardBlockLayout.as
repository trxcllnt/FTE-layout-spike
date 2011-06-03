package org.tinytlf.layout.block
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.block.alignment.IBlockAlignment;
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.block.progression.IBlockProgression;
	import org.tinytlf.layout.properties.*;
	import org.tinytlf.util.TinytlfUtil;
	
	public class StandardBlockLayout implements IBlockLayout
	{
		public function layout(lines:Vector.<TextLine>,
							   constraints:Vector.<IConstraint> = null):Vector.<TextLine>
		{
			lines.forEach(function(line:TextLine, ... args):void{
				line.y = getY(line, line.previousLine);
				line.x = getX(line, line.previousLine);
			});
			
			return lines;
		}
		
		// TODO: Convert this method to use the new alignment interface.
		protected function getX(line:TextLine, previousLine:TextLine = null):Number
		{
			var props:LayoutProperties = TinytlfUtil.getLP(line);
			
			var x:Number = Math.max(a.edgeStartValue(line.textBlock) - line.width, 0);
			var indent:Number = 0;
			
			if(line.previousLine == null)
				indent += props.textIndent;
			
			switch(props.textAlign)
			{
				case TextAlign.LEFT:
				case TextAlign.JUSTIFY:
					x += props.paddingLeft + indent;
					break;
				case TextAlign.CENTER:
					x = (props.width - line.width) * .5 + indent;
					break;
				case TextAlign.RIGHT:
					x = props.width - line.width - props.paddingRight;
					break;
			}
			
			return x;
		}
		
		protected function getY(line:TextLine, previousLine:TextLine = null):Number
		{
			return p.incrementValue(line,
									previousLine ?
									(previousLine.y + previousLine.descent - line.descent) :
									0);
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