package org.tinytlf.layout
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.alignment.IBlockAligner;
	import org.tinytlf.layout.constraints.IConstraint;
	import org.tinytlf.layout.progression.IBlockProgression;
	
	public interface IBlockRenderer
	{
		function set alignment(value:IBlockAligner):void;
		
		function set progression(value:IBlockProgression):void;
		
		function render(block:TextBlock,
						layout:LayoutProperties = null,
						existingLines:Array = null,
						constraints:Array = null):Array/*<TextLine>*/;
	}
}