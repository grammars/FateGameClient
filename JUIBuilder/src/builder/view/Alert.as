package builder.view
{
	import builder.Builder;
	import builder.view.base.Popup;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.events.MouseEvent;
	
	public class Alert extends Popup
	{
		private static var _instance:Alert;
		public static function get instance():Alert
		{
			if(_instance == null) { _instance = new Alert(); }
			return _instance;
		}
		
		private var txt:JLabel;
		private var sureBtn:JPushButton;
		private var cancelBtn:JPushButton;
		
		private var yesFunc:Function;
		
		public function Alert()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			setSize(320, 200);
			this.maximizeBtn.enabled = false;
			txt = new JLabel("内容");
			txt.align = JuiConst.CENTER;
			txt.valign = JuiConst.MIDDLE;
			txt.strokeColor = Builder.DARK_GREY;
			txt.textFormat = Builder.defaultFont();
			txt.textFormat.indent = 28;
			txt.textFormat.leading = 3;
			txt.textFormat.size = 12;
			txt.useStroke = true;
			txt.autoWrap = true;
			txt.useHtml = true;
			//txt.useFrame = true;
			//txt.textField.border = true;
			txt.setSize(_width-20, _height);
			txt.move(10, 0);
			this.addChild(txt);
			
			var btnSkin:JPushButtonSkin = new JPushButtonSkin();
			btnSkin.labelFormat = Builder.defaultFont();
			
			sureBtn = new JPushButton("确定", __sureBtn);
			sureBtn.setSize(80, 30);
			sureBtn.move(60, 140);
			btnSkin.apply(sureBtn);
			this.addChild(sureBtn);
			cancelBtn = new JPushButton("取消", __cancelBtn);
			cancelBtn.setSize(80, 30);
			cancelBtn.move(180, 140);
			btnSkin.apply(cancelBtn);
			this.addChild(cancelBtn);
		}
		
		private function __sureBtn(e:MouseEvent):void
		{
			if(yesFunc != null)
			{
				yesFunc.apply(null);
			}
			yesFunc = null;
			hide();
		}
		
		private function __cancelBtn(e:MouseEvent):void
		{
			yesFunc = null;
			hide();
		}
		
		public function warn(content:String, title:String="警告"):void
		{
			sureBtn.visible = cancelBtn.visible = false;
			txt.text = content;
			txt.draw();
			this.setTitle(title);
			show();
		}
		
		public function sure(yesFunc:Function, content:String="是否要继续", title:String="确定"):void
		{
			sureBtn.visible = cancelBtn.visible = true;
			this.yesFunc = yesFunc;
			txt.text = content;
			txt.draw();
			this.setTitle(title);
			show();
		}
		
	}
}