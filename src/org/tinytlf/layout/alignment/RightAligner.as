package org.tinytlf.layout.alignment
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.*;
	
	public class RightAligner extends AlignerBase
	{
		override public function getSize(layout:LayoutProperties, previousItem:*):Number
		{
			layout ||= LayoutProperties.empty;
			
			var width:Number = layout.width;
			
			if(previousItem == null)
				width -= layout.textIndent;
			
			width -= layout.paddingLeft;
			width -= layout.paddingRight;
			
			return width;
		}
		
		override public function getStart(layout:LayoutProperties, thisItem:*):Number
		{
			layout ||= LayoutProperties.empty;
			
			return layout.width - TextLine(thisItem).width - layout.paddingRight;
		}
		
		override public function sort(items:Array):Array
		{
			items = items.concat();
			items.sort(function(l1:TextLine, l2:TextLine):int{
				return l1.y - l2.y;
			});
			return items;
		}
	
//		override public function sortConstraints(constraints:Vector.<IConstraint>):Vector.<IConstraint>
//		{
//			return constraints.sort(function(c1:IConstraint, c2:IConstraint):int{
//				return c2.textLine.x - c1.textLine.x;
//			});
//		}
//		
//		override public function findClosestConstraint(constraints:Vector.<IConstraint>, startValue:Number):IConstraint
//		{
//			return null;
//		}
//		
//		override public function findClosestValue(constraints:Vector.<IConstraint>, constraintIntersect:Number, fromStart:Number):Number
//		{
//			return 0;
//		}
//		
//		override public function getConstraintDifference(constraint:IConstraint, currentValue:Number):Number
//		{
//			return 0;
//		}
//		
//		override public function isValueWithinBounds(value:Number, boundary:Number):Boolean
//		{
//			return false;
//		}
	}
}