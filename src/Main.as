package
{
	import flash.display.*;
	import flash.text.engine.*;
	
	import org.tinytlf.layout.*;
	import org.tinytlf.layout.alignment.*;
	import org.tinytlf.layout.constraints.*;
	import org.tinytlf.layout.progression.*;
	import org.tinytlf.layout.properties.*;
	import org.tinytlf.util.*;
	
	[SWF(width="500", height="500")]
	public class Main extends Sprite
	{
		[Embed(source="assets/Sansation_Light.ttf", fontFamily="Sansation")]
		private var sansation:Class;
		[Embed(source="assets/Interstate Regular.ttf", fontFamily="Interstate")]
		private var interstate:Class;
		[Embed(source="assets/helvetica regular.ttf", fontFamily="Helvetica")]
		private var helvetica:Class;
		
		private const child:Sprite = new Sprite();
		
		public function Main()
		{
			addChild(child);
			var g:Graphics = child.graphics;
			g.lineStyle(1);
			g.drawRect(0, 0, stage.stageWidth - 1, stage.stageHeight - 51);
			g.endFill();
			child.y = 50;
			
			const fd:FontDescription = new FontDescription("Helvetica");
			fd.fontLookup = FontLookup.EMBEDDED_CFF;
			const ef:ElementFormat = new ElementFormat(fd, 16);
			
			const element:GroupElement = new GroupElement(
				new <ContentElement>[
//				createFloat(TextFloat.LEFT, 0xCCCCCC),
//				createFloat(TextFloat.LEFT, 0x00FF00),
//				createFloat(TextFloat.RIGHT, 0x999999),
//				createFloat(TextFloat.LEFT, 0x00FF00),
//				createFloat(TextFloat.LEFT, 0x00FF00),
//				
//				createFloat(TextFloat.RIGHT, 0x0000FF),
//				createFloat(TextFloat.RIGHT, 0x0000FF),
//				createFloat(TextFloat.LEFT, 0x00FF00),
//				createFloat(TextFloat.RIGHT, 0x0000FF),
//				createFloat(TextFloat.RIGHT, 0x0000FF),
//				
//				createFloat(TextFloat.RIGHT, 0x0000FF),
//				createFloat(TextFloat.LEFT, 0x00FF00),
				
				new TextElement('ENIAC (pronounced /ˈɛni.æk/), short for Electronic ' +
								'Numerical Integrator And Computer, was the first ' +
								'general-purpose electronic computer. It was a Turing-complete, ' +
								'digital computer capable of being reprogrammed to solve a full ' +
								'range of computing problems.', ef.clone())],
				new ElementFormat());
			
			const block:TextBlock = new TextBlock(element);
			block.textJustifier = new SpaceJustifier('en', LineJustification.ALL_BUT_LAST);
			const layout:LayoutProperties = new LayoutProperties({width: 500});
			
			// Testing
//			block.createTextLine(block.createTextLine(null, 100), 100);
//			trace(block.firstLine);
//			trace(block.firstInvalidLine);
//			trace(block.lastLine);
//			trace(block.textLineCreationResult);
//			return;
			
			const lineRenderer:IBlockRenderer = new StandardBlockRenderer();
			const lineLayout:IBlockLayout = new StandardBlockLayout();
			const detector:IConstraintDetector = new ConstraintDetector();
			const constraintLayout:IConstraintLayout = new ConstraintLayout();
//			const lineConstraintRenderer:IBlockRenderer = new BlockConstraintRenderer();
//			const lineConstraintLayout:IBlockLayout = new BlockConstraintLayout();
			
			lineRenderer.progression =
				lineLayout.progression =
				constraintLayout.progression =
//				lineConstraintRenderer.progression =
//				lineConstraintLayout.progression = 
				new TTBProgression();
			
			constraintLayout.alignment = new ConstraintAligner();
			
			const alignment:IBlockAligner = new LeftAligner();
			
			lineRenderer.alignment =
				lineLayout.alignment =
//				lineConstraintRenderer.alignment =
//				lineConstraintLayout.alignment = 
				new LeftAligner();
			
			var lines:Array;
			var constraints:Array;
			
			// 1. Break all the lines normally.
			lines = lineRenderer.render(block, layout);
			
			// 2. Layout all the lines normally.
			lines = lineLayout.layout(lines.concat(), layout);
			
			// 3. Detect the constraints.
			constraints = detector.detectConstraints(lines.concat());
			
			// 4. Layout the constraints first. They should return in sorted order.
			constraints = constraintLayout.layout(block, constraints.concat(), layout);
			
			const constraintLines:Array = [];
			
			// 5. Filter out TextLines that hold constraints or control characters.
			lines = lines.filter(function(line:TextLine, ... args):Boolean{
				
				const isConstraintLine:Boolean = constraints.some(function(constraint:IConstraint, ... args):Boolean{
					if(constraint.textLine == line)
						constraintLines.push(line);
					return constraint.textLine == line;
				});
				
				const isControlLine:Boolean = (line.getAtomGraphic(0) is Shape && line.atomCount <= 2);
				
				return !(isConstraintLine || isControlLine);
			});
			
			// 6. Break the lines around the constraints.
//			lines = lineConstraintRenderer.render(block, layout, lines.concat(), constraints.concat());
			
			// 7. Filter out control lines again.
//			lines = lines.filter(function(line:TextLine, ... args):Boolean{
//				return !(line.getAtomGraphic(0) is Shape && line.atomCount <= 2);
//			});
			
			// 8. Layout the newly broken lines around the laid out constraints.
//			lines = lineConstraintLayout.layout(lines.concat(), constraints.concat());
			
			// 9. Add the lines to the display list.
			var i:int = 0, n:int = 0;
			
			for(i = 0, n = constraintLines.length; i < n; ++i)
			{
				child.addChild(constraintLines[i]);
			}
			
			for(i = 0, n = lines.length; i < n; ++i)
			{
				child.addChild(lines[i]);
			}
		}
		
		private function createFloat(float:String, color:uint):ContentElement
		{
			var lBreakGraphic:GraphicElement = new GraphicElement(new Shape(), 0, 0, new ElementFormat());
			lBreakGraphic.userData = 'lineBreak';
			
			var width:Number = float == TextFloat.LEFT ? 75 : 100;
			var height:Number = 100;
			
			var graphic:GraphicElement = new GraphicElement(
				new TextGraphic(color, width, height), width - 1, height - 1,
				new ElementFormat(null, 12, 0, 1, 'auto', TextBaseline.IDEOGRAPHIC_TOP));
			graphic.userData = {float: float};
			
			return ContentElementUtil.lineBreakBeforeAndAfter(graphic, null, 'lineBreak');
		}
	}
}
import flash.display.*;

internal class TextGraphic extends Sprite
{
	public function TextGraphic(color:uint, width:Number, height:Number)
	{
		var g:Graphics = graphics;
		
		g.lineStyle(1);
		g.beginFill(color, 0.75);
		g.drawRect(0, 0, width - 1, height - 1);
		g.endFill();
	}
}
