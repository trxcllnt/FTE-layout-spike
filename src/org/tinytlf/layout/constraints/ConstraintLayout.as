package org.tinytlf.layout.constraints
{
	import flash.geom.Point;
	import flash.text.engine.*;
	
	import org.tinytlf.layout.*;
	import org.tinytlf.layout.alignment.*;
	import org.tinytlf.layout.progression.*;
	import org.tinytlf.layout.properties.*;
	import org.tinytlf.util.*;
	
	public class ConstraintLayout implements IConstraintLayout
	{
		public function layout(block:TextBlock,
										  constraints:Array,
										  layout:LayoutProperties = null):Array
		{
			if(!constraints || !constraints.length)
				return constraints || [];
			
			layout ||= LayoutProperties.empty;
			
			var y:Number = p.getProgression(layout, null);
			const hLimits:Point = new Point(a.getStart(layout, null), a.getStart(layout, {}));
			
			const totalSpace:Number = a.getSize(layout, null);
			var availableSpace:Number = totalSpace;
			
			var tallestLine:TextLine;
			
			constraints.forEach(function(constraint:IConstraint, ... args):void{
				const line:TextLine = constraint.textLine;
				const props:LayoutProperties = TinytlfUtil.getLP(constraint.contentElement.userData);
				
				// If there's not enough space, update the y value.
				if(availableSpace < line.width)
				{
					hLimits.x = a.getStart(layout, null);
					hLimits.y = a.getStart(layout, {});
					
					y = p.getProgression(layout, tallestLine);
					tallestLine = null;
					availableSpace = totalSpace;
				}
				
				switch(props.float)
				{
					case TextFloat.RIGHT:
						hLimits.y -= line.width - props.paddingRight;
						line.x = hLimits.y;
						hLimits.y -= props.paddingLeft;
						break;
					case TextFloat.LEFT:
					default:
						line.x = hLimits.x + props.paddingLeft;
						hLimits.x += line.width + props.paddingLeft - props.paddingRight;
						break;
				}
				
				line.y = y;
				
				if(!tallestLine || line.totalHeight > tallestLine.totalHeight)
					tallestLine = line;
				
				availableSpace -= (line.width + props.paddingLeft - props.paddingRight);
			});
			
			return a.sort(constraints);
		}
		
		protected var a:IBlockAligner;
		
		public function set alignment(value:IBlockAligner):void
		{
			a = value;
		}
		
		protected var p:IBlockProgression = new TTBProgression();
		
		public function set progression(value:IBlockProgression):void
		{
		}
	}
}