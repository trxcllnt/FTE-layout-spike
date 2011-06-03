package org.tinytlf.layout.block.alignment
{
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.util.TinytlfUtil;
	
	public class RightAlignment extends AlignmentBase implements IBlockAlignment
	{
		override public function edgeStartValue(block:TextBlock):Number
		{
			return TinytlfUtil.getLP(block).width;
		}
		
		override public function sortConstraints(constraints:Vector.<IConstraint>):Vector.<IConstraint>
		{
			return constraints.sort(function(c1:IConstraint, c2:IConstraint):int{
				return c2.textLine.x - c1.textLine.x;
			});
		}
		
		override public function findClosestConstraint(constraints:Vector.<IConstraint>, startValue:Number):IConstraint
		{
			return null;
		}
		
		override public function findClosestValue(constraints:Vector.<IConstraint>, constraintIntersect:Number, fromStart:Number):Number
		{
			return 0;
		}
		
		override public function getConstraintDifference(constraint:IConstraint, currentValue:Number):Number
		{
			return 0;
		}
		
		override public function isValueWithinBounds(value:Number, boundary:Number):Boolean
		{
			return false;
		}
	}
}