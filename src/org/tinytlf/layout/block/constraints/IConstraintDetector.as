package org.tinytlf.layout.block.constraints
{
	import flash.text.engine.TextLine;

	public interface IConstraintDetector
	{
		function detectConstraints(lines:Vector.<TextLine>):Vector.<IConstraint>;
	}
}