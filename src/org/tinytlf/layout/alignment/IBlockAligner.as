package org.tinytlf.layout.alignment
{
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.LayoutProperties;
	
	public interface IBlockAligner
	{
		function getSize(layout:LayoutProperties, previousItem:*):Number;
		function getStart(layout:LayoutProperties, thisItem:*):Number;
		function sort(items:Array):Array;
	}
}