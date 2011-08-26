package org.tinytlf.layout.progression
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.LayoutProperties;
	
	public interface IBlockProgression
	{
		function getProgression(layout:LayoutProperties, previousLine:TextLine):Number;
		function getTotalSize(layout:LayoutProperties, lines:Array):Number;
	}
}