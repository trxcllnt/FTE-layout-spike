package org.tinytlf.layout.alignment
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.LayoutProperties;
	
	public class LeftAligner extends AlignerBase
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
			
			var x:Number = layout.paddingLeft;
			
			if(!thisItem || TextLine(thisItem).previousLine == null)
				x += layout.textIndent;
			
			return x;
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
//				return c1.textLine.x - c2.textLine.x;
//			});
//		}
//	
//		override public function findClosestConstraint(constraints:Vector.<IConstraint>, startValue:Number):IConstraint
//		{
//			var closestConstraint:IConstraint;
//			constraints.some(function(constraint:IConstraint, ... args):Boolean{
//				return (constraint.getXDifference(startValue) >= 0) ? Boolean(closestConstraint = constraint) : false;
//			});
//			
//			return closestConstraint;
//		}
//	
//		override public function findClosestValue(constraints:Vector.<IConstraint>,
//												  constraintIntersect:Number,
//												  fromStart:Number):Number
//		{
//			var constraint:IConstraint;
//			var x:Number = fromStart;
//			
//			while(constraint = findClosestConstraint(constraints, x))
//			{
//				if(constraint.intersectsX(x))
//				{
//					x = constraint.getXAtY(constraintIntersect, x);
//				}
//				else
//				{
//					break;
//				}
//			}
//			
//			return x;
//		}
//	
//		override public function getConstraintDifference(constraint:IConstraint, currentValue:Number):Number
//		{
//			return constraint.getXDifference(currentValue);
//		}
//	
//		override public function isValueWithinBounds(startValue:Number, totalValue:Number):Boolean
//		{
//			return startValue < totalValue;
//		}
	}
}