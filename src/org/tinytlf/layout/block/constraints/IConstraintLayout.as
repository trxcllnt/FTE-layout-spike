package org.tinytlf.layout.block.constraints
{
	import flash.text.engine.TextBlock;

	public interface IConstraintLayout
	{
		function layoutConstraints(block:TextBlock, constraints:Vector.<IConstraint>):Vector.<IConstraint>;
	}
}