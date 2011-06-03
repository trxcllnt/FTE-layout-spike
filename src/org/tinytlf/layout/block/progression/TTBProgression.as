package org.tinytlf.layout.block.progression
{
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.properties.LayoutProperties;
	import org.tinytlf.util.TinytlfUtil;
	
	public class TTBProgression implements IBlockProgression
	{
		public function incrementValue(line:TextLine, currentValue:Number):Number
		{
			var props:LayoutProperties = TinytlfUtil.getLP(line);
			
			return currentValue + line.ascent + line.descent + props.leading;
		}
	}
}