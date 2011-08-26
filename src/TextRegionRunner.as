package
{
	import flash.display.*;
	import flash.text.engine.*;
	
	import org.swiftsuspenders.*;
	import org.tinytlf.*;
	import org.tinytlf.conversion.*;
	
	[SWF(width="500", height="500")]
	public class TextRegionRunner extends Sprite
	{
		[Embed(source="assets/Sansation_Light.ttf", fontFamily="Sansation")]
		private var sansation:Class;
		[Embed(source="assets/helvetica regular.ttf", fontFamily="Helvetica")]
		private var helvetica:Class;
		
		public function TextRegionRunner()
		{
			super();
			
//			const str:String = 'ENIAC (pronounced /ˈɛni.æk/), short for Electronic ' +
//				'Numerical Integrator And Computer, was the first ' +
//				'general-purpose electronic computer. It was a Turing-complete, ' +
//				'digital computer capable of being reprogrammed to solve a full ' +
//				'range of computing problems.';
//			
//			const rect:TextRect = new TextRect();
//			rect.textBlock = new TextBlock(new TextElement(str, new ElementFormat(null, 30)));
//			rect.width = 500;
//			addChild(rect);
//			rect.render();
		}
	}
}