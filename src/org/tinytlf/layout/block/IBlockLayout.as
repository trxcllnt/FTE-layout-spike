package org.tinytlf.layout.block
{
	import flash.text.engine.TextLine;
	
	import org.tinytlf.layout.block.alignment.IBlockAlignment;
	import org.tinytlf.layout.block.constraints.IConstraint;
	import org.tinytlf.layout.block.progression.IBlockProgression;
	
	public interface IBlockLayout
	{
		function set alignment(value:IBlockAlignment):void;
		
		function set progression(value:IBlockProgression):void;
		
		function layout(lines:Vector.<TextLine>,
						constraints:Vector.<IConstraint> = null):Vector.<TextLine>
	}
}