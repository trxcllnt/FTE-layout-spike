package
{
	import flash.display.*;
	import flash.text.engine.*;
	
	import org.tinytlf.layout.*;
	import org.tinytlf.layout.block.*;
	import org.tinytlf.layout.block.alignment.*;
	import org.tinytlf.layout.block.constraints.*;
	import org.tinytlf.layout.block.progression.*;
	import org.tinytlf.layout.properties.*;
	import org.tinytlf.util.fte.*;
	
	[SWF(width="500", height="500")]
	public class Main extends Sprite
	{
		private const child:Sprite = new Sprite();
		
		public function Main()
		{
			addChild(child);
			var g:Graphics = child.graphics;
			g.lineStyle(1);
			g.drawRect(0, 0, stage.stageWidth - 1, stage.stageHeight - 51);
			g.endFill();
			child.y = 50;
			
			var element:GroupElement = new GroupElement(
				new <ContentElement>[createFloat(TextFloat.LEFT, 0x00FF00),
									 createFloat(TextFloat.LEFT, 0x00FF00),
									 createFloat(TextFloat.RIGHT, 0x0000FF),
									 createFloat(TextFloat.LEFT, 0x00FF00),
									 createFloat(TextFloat.LEFT, 0x00FF00),
									 
									 createFloat(TextFloat.RIGHT, 0x0000FF),
									 createFloat(TextFloat.RIGHT, 0x0000FF),
									 createFloat(TextFloat.LEFT, 0x00FF00),
									 createFloat(TextFloat.RIGHT, 0x0000FF),
									 createFloat(TextFloat.RIGHT, 0x0000FF),
									 
									 createFloat(TextFloat.RIGHT, 0x0000FF),
									 createFloat(TextFloat.LEFT, 0x00FF00),
									 
									 new TextElement('ENIAC (pronounced /ˈɛni.æk/), short for Electronic ' +
													 'Numerical Integrator And Computer,[1][2] was the first ' +
													 'general-purpose electronic computer. It was a Turing-complete, ' +
													 'digital computer capable of being reprogrammed to solve a full ' +
													 'range of computing problems.[3]',
													 new ElementFormat(null, 22)),
				], new ElementFormat());
			
			var block:TextBlock = new TextBlock(element);
			block.textJustifier = new SpaceJustifier('en', LineJustification.ALL_BUT_LAST);
			block.userData = new LayoutProperties({width: 500, textIndent: 20});
			
			var lineRenderer:IBlockRenderer = new StandardBlockRenderer();
			var lineLayout:IBlockLayout = new StandardBlockLayout();
			var detector:IConstraintDetector = new ConstraintDetector();
			var constraintLayout:IConstraintLayout = new ConstraintLayout();
			var lineConstraintRenderer:IBlockRenderer = new BlockConstraintRenderer();
			var lineConstraintLayout:IBlockLayout = new BlockConstraintLayout();
			
			lineRenderer.progression =
				lineLayout.progression =
				lineConstraintRenderer.progression =
				lineConstraintLayout.progression = new TTBProgression();
			
			var alignment:IBlockAlignment = new LeftAlignment();
			
			lineRenderer.alignment =
				lineLayout.alignment =
				lineConstraintRenderer.alignment =
				lineConstraintLayout.alignment = alignment;
			
			var lines:Vector.<TextLine>;
			var constraints:Vector.<IConstraint>;
			
			// 1. Break all the lines normally.
			lines = lineRenderer.render(block);
			
			// 2. Layout all the lines normally.
			lines = lineLayout.layout(lines.concat());
			
			// 3. Detect the constraints.
			constraints = detector.detectConstraints(lines.concat());
			
			// 4. Layout the constraints first.
			constraints = constraintLayout.layoutConstraints(block, constraints.concat());
			
			// 5. Sort the constraints by alignment.
			constraints = alignment.sortConstraints(constraints.concat());
			
			var constraintLines:Vector.<TextLine> = new <TextLine>[];
			
			// 6. Filter out TextLines that the constraints are in.
			lines = lines.filter(function(line:TextLine, ... args):Boolean{
				return !constraints.some(function(constraint:IConstraint, ... args):Boolean{
					if(constraint.textLine == line)
					{
						constraintLines.push(line);
						return true;
					}
					
					return false;
				});
			});
			
			// 7. Filter out control lines.
			lines = lines.filter(function(line:TextLine, ... args):Boolean{
				return !(line.getAtomGraphic(0) is Shape && line.atomCount <= 2);
			});
			
			// 8. Break the lines around the constraints.
			lines = lineConstraintRenderer.render(block, lines.concat(), constraints.concat());
			
			// 9. Filter out control lines again.
			lines = lines.filter(function(line:TextLine, ... args):Boolean{
				return !(line.getAtomGraphic(0) is Shape && line.atomCount <= 2);
			});
			
			// 10. Layout the newly broken lines around the laid out constraints.
			lines = lineConstraintLayout.layout(lines.concat(), constraints.concat());
			
			// 11. Add the lines to the display list
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
