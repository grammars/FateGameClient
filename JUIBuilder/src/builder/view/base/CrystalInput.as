package builder.view.base
{
	import builder.Builder;
	
	import com.anstu.jui.controls.JInputText;
	
	public class CrystalInput extends JInputText
	{
		public function CrystalInput(text:String="", w:int=80, h:int=25, size:int=14)
		{
			super(text);
			this.setSize(w, h);
			this.useFrame = true;
			this.useStroke = true;
			this.frameLineColor = Builder.DARK_GREY;
			this.frameFillColor = Builder.MILK_WHITE;
			this.textFormat.size = size;
			this.textFormat.color = Builder.LAKE_BLUE;
		}
	}
}