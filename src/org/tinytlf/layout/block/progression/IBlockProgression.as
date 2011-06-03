package org.tinytlf.layout.block.progression
{
	import flash.text.engine.*;
	
	import org.tinytlf.layout.block.constraints.*;
	
	public interface IBlockProgression
	{
		function incrementValue(line:TextLine, currentValue:Number):Number;
	}
}