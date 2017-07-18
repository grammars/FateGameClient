package ui.ctrls
{
	import com.anstu.jui.controls.JInputText;
	
	public class CrystalInput extends JInputText
	{
		public function CrystalInput(text:String="", w:int=80, h:int=25, size:int=14)
		{
			super(text);
			this.setSize(w, h);
			this.useFrame = true;
			this.useStroke = true;
			this.frameLineColor = Editor.FL_COLOR;
			this.frameFillColor = Editor.FF_COLOR;
			this.textFormat.size = size;
			this.textFormat.color = Editor.FONT_COLOR;
		}
	}
}