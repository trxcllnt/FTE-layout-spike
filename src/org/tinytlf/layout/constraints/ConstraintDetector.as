package org.tinytlf.layout.constraints
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.text.engine.TextLine;
	
	public class ConstraintDetector implements IConstraintDetector
	{
		public function detectConstraints(lines:Array):Array
		{
			const constraints:Array = [];
			
			lines.forEach(function(line:TextLine, ... args):void{
				
				if(!line.hasGraphicElement)
					return;
				
				// Iterate over each atom index searching for graphics.
				(new Array(line.atomCount)).forEach(function(g:*, i:int, ...args):void{
					
					if((g = line.getAtomGraphic(i)) == null || g is Shape)
						return;
					
					constraints.push(new Constraint(i, line));
				});
			});
			
			return constraints;
		}
	}
}
import flash.display.*;
import flash.text.engine.*;

import org.tinytlf.layout.constraints.IConstraint;
import org.tinytlf.util.TextLineUtil;

internal class Constraint implements IConstraint
{
	public function Constraint(index:int, line:TextLine)
	{
		g = line.getAtomGraphic(index);
		element = TextLineUtil.getElementAtAtomIndex(line, index);
		this.line = line;
	}
	
	private var g:DisplayObject;
	
	public function get graphic():DisplayObject
	{
		return g;
	}
	
	private var element:ContentElement;
	
	public function get contentElement():ContentElement
	{
		return element;
	}
	
	private var line:TextLine;
	
	public function get textLine():TextLine
	{
		return line;
	}
	
	public function intersectsX(xValue:Number):Boolean
	{
		return xValue >= line.x && xValue <= (line.x + line.width);
	}
	
	public function intersectsY(yValue:Number):Boolean
	{
		return yValue >= line.y && yValue <= (line.y + line.totalHeight);
	}
	
	public function getXAtY(yValue:Number, fromXValue:Number):Number
	{
		if(!intersectsY(yValue))
			return 0;
		
		//For now assume float:left;
		if(intersectsX(fromXValue))
			return line.x + line.width + 1;
		
		return fromXValue;
	}
	
	public function getYAtX(xValue:Number, fromYValue:Number):Number
	{
		//no implementation for now.
		return fromYValue;
	}
	
	public function getXDifference(fromXValue:Number):Number
	{
		if(fromXValue < line.x)
			return line.x - fromXValue;
		
		if(fromXValue > (line.x + line.width))
			return (line.x + line.width) - fromXValue;
		
		return 0;
	}
	
	public function getYDifference(fromYValue:Number):Number
	{
		return 0;
	}
}