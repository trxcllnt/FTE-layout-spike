package org.tinytlf.layout.block.alignment
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.properties.LayoutProperties;
	import org.tinytlf.util.TinytlfUtil;
	
	public class LeftAlignment extends AlignmentBase implements IBlockAlignment
	{
		override public function edgeStartValue(block:TextBlock):Number
		{
			return 0;
		}
		
		override public function sortConstraints(constraints:Vector.<IConstraint>):Vector.<IConstraint>
		{
			return constraints.sort(function(c1:IConstraint, c2:IConstraint):int{
				return c1.textLine.x - c2.textLine.x;
			});
		}
		
		override public function findClosestConstraint(constraints:Vector.<IConstraint>, startValue:Number):IConstraint
		{
			var closestConstraint:IConstraint;
			constraints.some(function(constraint:IConstraint, ... args):Boolean{
				return (constraint.getXDifference(startValue) >= 0) ? Boolean(closestConstraint = constraint) : false;
			});
			
			return closestConstraint;
		}
		
		override public function findClosestValue(constraints:Vector.<IConstraint>,
												  constraintIntersect:Number,
												  fromStart:Number):Number
		{
			var constraint:IConstraint;
			var x:Number = fromStart;
			
			while(constraint = findClosestConstraint(constraints, x))
			{
				if(constraint.intersectsX(x))
				{
					x = constraint.getXAtY(constraintIntersect, x);
				}
				else
				{
					break;
				}
			}
			
			return x;
		}
		
		override public function getConstraintDifference(constraint:IConstraint, currentValue:Number):Number
		{
			return constraint.getXDifference(currentValue);
		}
		
		override public function isValueWithinBounds(startValue:Number, totalValue:Number):Boolean
		{
			return startValue < totalValue;
		}
	}
}