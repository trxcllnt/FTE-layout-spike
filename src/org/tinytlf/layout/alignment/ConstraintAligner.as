package org.tinytlf.layout.alignment
{
	import org.tinytlf.layout.*;
	import org.tinytlf.layout.constraints.IConstraint;
	import org.tinytlf.layout.properties.TextFloat;
	
	public class ConstraintAligner extends AlignerBase
	{
		override public function getSize(layout:LayoutProperties, previousItem:*):Number
		{
			layout ||= LayoutProperties.empty;
			return layout.width - layout.paddingLeft - layout.paddingRight;
		}
		
		override public function getStart(layout:LayoutProperties, thisItem:*):Number
		{
			return thisItem ? layout.width - layout.paddingRight : layout.paddingLeft;
		}
		
		override public function sort(items:Array):Array
		{
			items = items.concat();
			items.sort(function(c1:IConstraint, c2:IConstraint):int{
				return c1.textLine.x - c2.textLine.x;
			});
			return items;
		}
	}
}