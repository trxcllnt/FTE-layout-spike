package
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.text.engine.*;
	
	import org.tinytlf.layout.*;
	import org.tinytlf.layout.alignment.*;
	import org.tinytlf.layout.progression.*;
	
	[SWF(width="500", height="500")]
	public class Editor extends Sprite
	{
		[Embed(source="assets/Sansation_Light.ttf", fontFamily="Sansation")]
		private var sansation:Class;
		[Embed(source="assets/Interstate Regular.ttf", fontFamily="Interstate")]
		private var interstate:Class;
		[Embed(source="assets/helvetica regular.ttf", fontFamily="Helvetica")]
		private var helvetica:Class;
		
		private const container:Sprite = new Sprite();
		private const block:TextBlock = new TextBlock();
		private const layout:LayoutProperties = new LayoutProperties({width: 500});
		private var lines:Array;
		
		public function Editor()
		{
			super();
			
			const fd:FontDescription = new FontDescription("Helvetica");
			fd.fontLookup = FontLookup.EMBEDDED_CFF;
			const ef:ElementFormat = new ElementFormat(fd, 16);
			var s:String = 'ENIAC (pronounced /ˈɛni.æk/), short for Electronic ' +
				'Numerical Integrator And Computer, was the first ' +
				'general-purpose electronic computer. It was a Turing-complete, ' +
				'digital computer capable of being reprogrammed to solve a full ' +
				'range of computing problems.';
			
			const text:TextElement = new TextElement(s, ef);
			block.content = text;
			block.textJustifier = new SpaceJustifier('en', LineJustification.ALL_BUT_LAST);
			
			addChild(container);
			var g:Graphics = container.graphics;
			g.lineStyle(1);
			g.drawRect(0, 0, stage.stageWidth - 1, stage.stageHeight - 51);
			g.endFill();
			container.y = 50;
			container.addEventListener(MouseEvent.CLICK, function(e:*):void{
				s = s.substr(0, s.length - 1);
				text.text = s;
				render();
			});
			
			render();
		}
		
		private function render():void
		{
			const lineRenderer:IBlockRenderer = new StandardBlockRenderer(new LeftAligner(), new TTBProgression());
			const lineLayout:IBlockLayout = new StandardBlockLayout(new LeftAligner(), new TTBProgression());
			
			while(container.numChildren)
				container.removeChildAt(0);
			
			lines = lineLayout.layout(lineRenderer.render(block, layout, lines), layout)
				.map(function(line:TextLine, ... args):TextLine{
				return container.addChild(line) as TextLine;
			});
		}
	}
}