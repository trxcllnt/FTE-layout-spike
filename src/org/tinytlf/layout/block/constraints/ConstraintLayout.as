package org.tinytlf.layout.block.constraints
{
	import flash.geom.Rectangle;
	import flash.text.engine.*;
	
	import org.tinytlf.layout.properties.*;
	import org.tinytlf.util.TinytlfUtil;

	public class ConstraintLayout implements IConstraintLayout
	{
		public function layoutConstraints(block:TextBlock, constraints:Vector.<IConstraint>):Vector.<IConstraint>
		{
			if(!constraints || !constraints.length)
				return constraints || new Vector.<IConstraint>();
			
			var blockProps:LayoutProperties = TinytlfUtil.getLP(block);
			var totalWidth:Number = blockProps.width - blockProps.paddingLeft - blockProps.paddingRight;
			
			var y:Number = blockProps.paddingTop;
			var nextLeft:Number = blockProps.paddingLeft;
			var nextRight:Number = blockProps.width - blockProps.paddingRight;
			var totalSpace:Number = totalWidth;
			var maxHeight:Number = 0;
			
			constraints.forEach(function(constraint:IConstraint, ...args):void{
				var line:TextLine = constraint.textLine;
				
				var props:LayoutProperties = TinytlfUtil.getLP(constraint.contentElement.userData);
				
				if(totalSpace < line.width)
				{
					nextLeft = blockProps.paddingLeft;
					nextRight = blockProps.width - blockProps.paddingRight;
					y += maxHeight;
					maxHeight = 0;
					totalSpace = totalWidth;
				}
				
				switch(props.float)
				{
					case TextFloat.RIGHT:
						nextRight -= line.width;
						line.x = nextRight;
						break;
					case TextFloat.LEFT:
					default:
						line.x = nextLeft;
						nextLeft += line.width;
						break;
				}
				
				line.y = y;
				maxHeight = Math.max(line.totalHeight, maxHeight);
				totalSpace -= line.width;
			});
			
			return constraints;
		}
	}
}