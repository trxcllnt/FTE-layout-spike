package org.tinytlf.layout.constraints
{
	import flash.text.engine.TextBlock;
	
	import org.tinytlf.layout.LayoutProperties;
	import org.tinytlf.layout.alignment.IBlockAligner;
	import org.tinytlf.layout.progression.IBlockProgression;
	
	public interface IConstraintLayout
	{
		function set alignment(value:IBlockAligner):void;
		
		function set progression(value:IBlockProgression):void;
		
		function layout(block:TextBlock,
						constraints:Array,
						layout:LayoutProperties = null):Array
	}
}