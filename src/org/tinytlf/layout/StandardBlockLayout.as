package org.tinytlf.layout
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.alignment.*;
	import org.tinytlf.layout.constraints.*;
	import org.tinytlf.layout.progression.*;
	import org.tinytlf.layout.properties.*;
	
	public class StandardBlockLayout implements IBlockLayout
	{
		public function StandardBlockLayout(aligner:IBlockAligner = null, progression:IBlockProgression = null)
		{
			a = aligner;
			p = progression;
		}
		
		public function layout(lines:Array,
							   layout:LayoutProperties = null,
							   constraints:Array = null):Array/*<TextLine>*/
		{
			layout ||= new LayoutProperties({width: 100});
			
			lines.forEach(function(line:TextLine, ... args):void{
				line.y = p.getProgression(layout, line.previousLine) + line.ascent;
				line.x = a.getStart(layout, line);
			});
			
			return lines;
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