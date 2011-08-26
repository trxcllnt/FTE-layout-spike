package org.tinytlf.layout.alignment
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.LayoutProperties;
	import org.tinytlf.layout.constraints.IConstraint;
	import org.tinytlf.util.TinytlfUtil;
	
	public class AlignerBase implements IBlockAligner
	{
		public function getSize(layout:LayoutProperties, previousItem:*):Number
		{
			return 0;
			
//			Left, middle, and right alignment
//			var width:Number = layout.width;
//			
//			if(line == null)
//				width -= layout.textIndent;
//			
//			width -= layout.paddingLeft;
//			width -= layout.paddingRight;
//			
//			return width;
		}
		
		public function getStart(layout:LayoutProperties, thisItem:*):Number
		{
//			Left alignment
//			var x:Number = layout.paddingLeft;
//			if(line.previousLine == null)
//				x += layout.textIndent;
//			return x;
//			
//			Right alignment
//			return layout.width - line.width - layout.paddingRight;
//			
//			Center alignment
//			return (layout.width - line.width) * 0.5;
			
			return 0;
		}
		
		public function sort(items:Array):Array
		{
			return items.concat();
		}
	}
}