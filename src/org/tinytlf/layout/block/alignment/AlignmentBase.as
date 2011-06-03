package org.tinytlf.layout.block.alignment
{
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.properties.LayoutProperties;
	import org.tinytlf.util.TinytlfUtil;
	
	public class AlignmentBase implements IBlockAlignment
	{
		public function AlignmentBase()
		{
		}
		
		public function edgeStartValue(block:TextBlock):Number
		{
			return 0;
		}
		
		public function sortConstraints(constraints:Vector.<IConstraint>):Vector.<IConstraint>
		{
			return null;
		}
		
		public function findClosestConstraint(constraints:Vector.<IConstraint>, startValue:Number):IConstraint
		{
			return null;
		}
		
		public function findClosestValue(constraints:Vector.<IConstraint>, constraintIntersect:Number, fromStart:Number):Number
		{
			return 0;
		}
		
		public function getConstraintDifference(constraint:IConstraint, currentValue:Number):Number
		{
			return 0;
		}
		
		public function getTotalSize(block:TextBlock, previousLine:TextLine):Number
		{
			var props:LayoutProperties = TinytlfUtil.getLP(block);
			var width:Number = props.width;
			
			if(previousLine == null)
				width -= props.textIndent;
			
			width -= props.paddingLeft;
			width -= props.paddingRight;
			
			return width;
		}
		
		public function isValueWithinBounds(value:Number, boundary:Number):Boolean
		{
			return false;
		}
	}
}