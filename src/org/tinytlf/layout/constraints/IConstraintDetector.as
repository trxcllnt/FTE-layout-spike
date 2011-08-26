package org.tinytlf.layout.constraints
{
	import flash.text.engine.TextLine;

	public interface IConstraintDetector
	{
		function detectConstraints(lines:Array/*<TextLine>*/):Array/*<IConstraint>*/;
	}
}