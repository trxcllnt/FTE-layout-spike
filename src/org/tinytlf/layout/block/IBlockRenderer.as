package org.tinytlf.layout.block
{
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.block.alignment.IBlockAlignment;
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.block.progression.IBlockProgression;
	
	public interface IBlockRenderer
	{
		function set alignment(value:IBlockAlignment):void;
		
		function set progression(value:IBlockProgression):void;
		
		function render(block:TextBlock,
						existingLines:Vector.<TextLine> = null,
						constraints:Vector.<IConstraint> = null):Vector.<TextLine>;
	}
}