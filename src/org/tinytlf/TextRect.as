package org.tinytlf
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.engine.*;
	
	import org.tinytlf.conversion.*;
	import org.tinytlf.layout.*;
	import org.tinytlf.layout.alignment.*;
	import org.tinytlf.layout.progression.*;
	import org.tinytlf.util.*;
	
	[Event(name="overflow", type="flash.events.Event")]
	public class TextRect extends Sprite
	{
		private var block:TextBlock;
		public function get textBlock():TextBlock
		{
			return block;
		}
		
		public function set textBlock(value:TextBlock):void
		{
			clear();
			block = value;
		}
		
		private var progression:IBlockProgression = new TTBProgression();
		private var aligner:IBlockAligner = new LeftAligner();
		private var renderer:IBlockRenderer = new StandardBlockRenderer(aligner, progression);
		private var layout:IBlockLayout = new StandardBlockLayout(aligner, progression);
		
		public function render():void
		{
			if(!textBlock)
				return;
			
			while(numChildren)
				removeChildAt(0);
			
			const properties:LayoutProperties = new LayoutProperties({width: width});
			
			th = 0;
			tw = 0;
			
			// Make the the magic happen. Cache the results so we can reuse the lines.
			lines = layout.layout(renderer.render(textBlock, properties, lines), properties)
				.map(function(line:TextLine, ... args):TextLine{
				tw = Math.max(line.width, tw);
				return addChild(line) as TextLine;
			});
			
			const size:Number = progression.getTotalSize(properties, lines);
			th = size;
			
			if(h == h && size > height)
			{
				dispatchEvent(new Event('overflow'));
			}
		}
		
		private function clear():void
		{
			TextBlockUtil.checkIn(textBlock);
			block = null;
		}
		
		/*
		 * TextRegion linked list impl.
		 */
		private var prev:TextRect;
		
		public function get previousRegion():TextRect
		{
			return prev;
		}
		
		public function set previousRegion(value:TextRect):void
		{
			prev = value;
		}
		
		private var next:TextRect;
		
		public function get nextRegion():TextRect
		{
			return next;
		}
		
		public function set nextRegion(value:TextRect):void
		{
			next = value;
		}
		
		/*
		 * Text manipulation and metrics methods.
		 */
		private var lines:Array = [];
		
		public function get textLines():Array
		{
			return lines.concat();
		}
		
		public function get textHeight():Number
		{
			return th;
		}
		
		private var tw:Number = 0;
		
		public function get textWidth():Number
		{
			return tw;
		}
		
		public function indexToLine(index:int):TextLine
		{
			return lines.filter(function(l:TextLine, ... args):Boolean{
				return (index >= l.textBlockBeginIndex && (index - l.textBlockBeginIndex) < l.atomCount);
			})[0] as TextLine;
		}
		
		public function indexToElement(index:int):ContentElement
		{
			if(!block)
				return null;
			
			return ContentElementUtil.getLeaf(block.content, index);
		}
		
		/*
		 * Sprite overrides.
		 */
		
		private var w:Number = NaN;
		
		override public function get width():Number
		{
			return w || 0;
		}
		
		override public function set width(value:Number):void
		{
			w = value;
		}
		
		private var h:Number = NaN;
		
		override public function get height():Number
		{
			return h || 0;
		}
		
		override public function set height(value:Number):void
		{
			h = value;
		}
		
		private var th:Number = 0;
	}
}