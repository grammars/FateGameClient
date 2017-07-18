package builder.view.base
{
	import builder.Builder;
	
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JFrame;
	import com.anstu.jui.controls.JTitle;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JFrameSkin;
	
	import flash.display.Sprite;
	
	public class Popup extends JFrame
	{
		private var title:JTitle = new JTitle();
		
		public function Popup()
		{
			super();
			
			new JFrameSkin().apply(this);
			title.width = _width;
			title.height = 28;
			title.align = JuiConst.CENTER;
			title.valign = JuiConst.MIDDLE;
			var fmt:JTextFormat = new JTextFormat(null, 14, null,true);
			title.textFormat = fmt;
			title.gradBeg = Builder.LAKE_BLUE;
			title.gradEnd = Builder.MILK_WHITE;
			title.useStroke = true;
			this.addChild(title);
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			title.width = w;
		}
		
		override public function set height(h:Number):void
		{
			super.height = h;
		}
		
		/** 设置标题 */
		public function setTitle(content:String):void
		{
			this.title.text = content;
		}
		
		public function show():void
		{
			this.x = (Builder.stage.stageWidth-this.width)/2;
			this.y = (Builder.stage.stageHeight-this.height)/2;
			Builder.root.addChild(this);
		}
		
		public function hide():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
		
	}
}