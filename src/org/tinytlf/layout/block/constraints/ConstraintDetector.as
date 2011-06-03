package org.tinytlf.layout.block.constraints
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.text.engine.TextLine;
	
	public class ConstraintDetector implements IConstraintDetector
	{
		public function detectConstraints(lines:Vector.<TextLine>):Vector.<IConstraint>
		{
			var line:TextLine;
			var constraints:Vector.<IConstraint> = new <IConstraint>[];
			
			lines.forEach(function(line:TextLine, ... args):void{
				
				if(!line.hasGraphicElement)
					return;
				
				var graphic:DisplayObject;
				
				(new Array(line.atomCount)).forEach(function(e:*, i:int, len:int):void{
					
					if((graphic = line.getAtomGraphic(i)) == null || graphic is Shape)
						return;
					
					constraints.push(new Constraint(i, line));
				});
			});
			
			return constraints;
		}
	}
}
import flash.display.DisplayObject;
import flash.geom.Rectangle;
import flash.text.engine.ContentElement;
import flash.text.engine.TextLine;

import org.tinytlf.layout.block.constraints.IConstraint;
import org.tinytlf.util.fte.TextLineUtil;

internal class Constraint implements IConstraint
{
	public function Constraint(index:int, line:TextLine)
	{
		var graphic:DisplayObject = line.getAtomGraphic(index);
		
		element = TextLineUtil.getElementAtAtomIndex(line, index);
		this.line = line;
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