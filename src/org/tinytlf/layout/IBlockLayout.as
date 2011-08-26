package org.tinytlf.layout
{
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.alignment.IBlockAligner;
	import org.tinytlf.layout.constraints.IConstraint;
	import org.tinytlf.layout.progression.IBlockProgression;
	
	public interface IBlockLayout
	{
		function set alignment(value:IBlockAligner):void;
		
		function set progression(value:IBlockProgression):void;
		
		function layout(lines:Array,
						layout:LayoutProperties = null,
						constraints:Array = null):Array/*<TextLine>*/;
	}
}