package ui.view.utils
{
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	
	import flash.display.Sprite;
	
	import ui.skin.font.DefaultFont;

	public class ViewUtils
	{
		public function ViewUtils()
		{
		}
		
		/** clear the children in content */
		public static function clearContent(sp:Sprite):void
		{
			const cn:int = sp.numChildren;
			for(var i:int = 0; i < cn; i++)
			{
				sp.removeChildAt(0);
			}
		}
		
		public static function htmlLabel(htmlText:String, stroke:Boolean=false, w:Object=null, h:Object=null, align:String=JuiConst.LEFT, letterSpacing:int=0):JLabel
		{
			var label:JLabel = new JLabel(htmlText);
			label.textFormat = DefaultFont.create();
			label.textFormat.letterSpacing = letterSpacing;
			label.useHtml = true;
			if(w)
			{
				label.width = int(w);
			}
			if(h)
			{
				label.height = int(h);
			}
			else
			{
				label.usePack = true;
			}
			label.useStroke = stroke;
			label.draw();
			return label;
		}
		
		public static function label(text:String, stroke:Boolean=false, color:uint=0xfefe00, size:int=12, bold:Boolean=false, w:Object=null, h:Object=null, align:String=JuiConst.LEFT, letterSpacing:int=0):JLabel
		{
			var label:JLabel = new JLabel(text);
			label.textFormat = DefaultFont.create();
			label.textFormat.letterSpacing = letterSpacing;
			label.textFormat.color = color;
			label.textFormat.size = size;
			label.textFormat.bold = bold;
			if(w)
			{
				label.width = int(w);
			}
			if(h)
			{
				label.height = int(h);
			}
			else
			{
				label.usePack = true;
			}
			label.useStroke = stroke;
			label.draw();
			return label;
		}
		
	}
}