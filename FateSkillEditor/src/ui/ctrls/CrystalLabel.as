package ui.ctrls
{
	
	import com.anstu.jui.controls.JLabel;
	
	public class CrystalLabel extends JLabel
	{
		public function CrystalLabel(text:String="", w:int=80, h:int=25, size:int=14)
		{
			super(text);
			this.useStroke = true;
			this.textFormat.color = Editor.FONT_COLOR;
			this.textFormat.size = size;
			this.autoWrap = true;
			this.setSize(w, h);
		}
	}
}