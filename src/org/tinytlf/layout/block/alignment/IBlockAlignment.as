package org.tinytlf.layout.block.alignment
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.block.constraints.IConstraint;

	public interface IBlockAlignment
	{
		function edgeStartValue(block:TextBlock):Number;
		
		function sortConstraints(constraints:Vector.<IConstraint>):Vector.<IConstraint>;
		
		function findClosestConstraint(constraints:Vector.<IConstraint>, startValue:Number):IConstraint;
		
		function findClosestValue(constraints:Vector.<IConstraint>, constraintIntersect:Number, fromStart:Number):Number;
		
		function getConstraintDifference(constraint:IConstraint, currentValue:Number):Number;
		
		function getTotalSize(block:TextBlock, previousLine:TextLine):Number;
		
		function isValueWithinBounds(value:Number, boundary:Number):Boolean;
	}
}