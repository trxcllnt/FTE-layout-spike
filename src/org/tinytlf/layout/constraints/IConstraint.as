package org.tinytlf.layout.constraints
{
	import flash.display.DisplayObject;
	import flash.text.engine.ContentElement;
	import flash.text.engine.TextLine;

	public interface IConstraint
	{
		function get contentElement():ContentElement;
		function get textLine():TextLine;
		function get graphic():DisplayObject;
		
		function intersectsX(xValue:Number):Boolean;
		function intersectsY(yValue:Number):Boolean;
		
		function getXAtY(yValue:Number, fromXValue:Number):Number;
		function getYAtX(xValue:Number, fromYValue:Number):Number;
		
		function getXDifference(fromXValue:Number):Number;
		function getYDifference(fromYValue:Number):Number;
	}
}