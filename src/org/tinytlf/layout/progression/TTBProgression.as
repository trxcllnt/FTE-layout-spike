package org.tinytlf.layout.progression
{
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.LayoutProperties;
	import org.tinytlf.util.TinytlfUtil;
	
	public class TTBProgression implements IBlockProgression
	{
		public function getProgression(layout:LayoutProperties, previousLine:TextLine):Number
		{
			layout ||= new LayoutProperties({width: 100});
			
			if(!previousLine)
				return layout.paddingTop;
			
			return previousLine.y + previousLine.descent + layout.leading;
		}
		
		public function getTotalSize(layout:LayoutProperties, lines:Array):Number
		{
			var h:Number = layout.paddingTop;
			
			lines.forEach(function(line:TextLine, i:int, a:Array):void{
				h += line.totalHeight;
				
				if(i < a.length - 1)
					h += layout.leading;
			});
			
			return h + layout.paddingBottom;
		}
	}
}