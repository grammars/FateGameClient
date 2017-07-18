package ui.view
{
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JTitle;
	import com.anstu.jui.define.JuiConst;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ui.skin.font.DefaultFont;
	import ui.skin.pane.FrameBackPaneSkin;
	import ui.skin.pane.FrameFrontPaneSkin;
	import ui.skin.pushButton.PaneCloseBtnSkin;

	public class BaseFrame extends BasePane
	{
		private var backPaneMarginLeft:int = 13;
		private var backPaneMarginRight:int = 13;
		private var backPaneMarginTop:int = 40;
		private var backPaneMarginBottom:int = 10;
		private var backPane:JPanel;
		private var frontPane:JPanel;
		/** 关闭按钮 */
		protected var closeBtn:JPushButton;
		/** 画布区 */
		protected var canvas:Sprite;
		/** 标题 */
		protected var title:JTitle;
		
		public function BaseFrame()
		{
			super();
			initialize();
		}
		
		/** 初始化 */
		protected function initialize():void
		{
			this.bgAlpha = 0;
			backPane = new JPanel();
			FrameBackPaneSkin.instance.apply(backPane);
			backPane.move(backPaneMarginLeft, backPaneMarginTop);
			this.addChild(backPane);
			
			frontPane = new JPanel();
			FrameFrontPaneSkin.instance.apply(frontPane);
			this.addChild(frontPane);
			
			title = new JTitle();
			var fmt:JTextFormat = DefaultFont.create();
			fmt.size = 16;
			fmt.bold = true;
			fmt.letterSpacing = 5;
			title.textFormat = fmt;
			title.width = this._width;
			title.height = 46;
			title.align = JuiConst.CENTER;
			title.valign = JuiConst.MIDDLE;
			title.gradBeg = 0xfdf6ad;
			title.gradEnd = 0xcf7017;
			title.useStroke = true;
			//title.drawRect(0xffffff, 0.3);
			this.addChild(title);
			
			closeBtn = new JPushButton("", __closeBtn);
			PaneCloseBtnSkin.instance.apply(closeBtn);
			putCloseBtnPos();
			this.addChild(closeBtn);
			
			canvas = new Sprite();
			canvas.x = backPaneMarginLeft;
			canvas.y = backPaneMarginTop;
			this.addChild(canvas);
			
			canDrag(true);
			canBringTop(true);
		}
		
		override public function show():void
		{
			putCentre();
			super.show();
		}
		
		override public function putDefaultPos(event:Event=null):void
		{
			putCentre();
		}
		
		private function putCloseBtnPos():void
		{
			if(closeBtn) { closeBtn.move(_width-40, 8); }
		}
		
		private function __closeBtn(e:MouseEvent):void
		{
			hide();
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			var bpw:int = w - backPaneMarginLeft - backPaneMarginRight;
			if(bpw <= 0) { bpw = 1; }
			if(backPane) { backPane.width = bpw; }
			if(frontPane) { frontPane.width = w; }
			putCloseBtnPos();
			if(title) { title.width = w; }
		}
		
		override public function set height(h:Number):void
		{
			super.height = h;
			var bph:int = h - backPaneMarginTop - backPaneMarginBottom;
			if(bph <= 0) { bph = 1; }
			if(backPane) { backPane.height = bph; }
			if(frontPane) { frontPane.height = h; }
		}
		
		/** 设置标题 */
		public function setTitle(content:String):void
		{
			title.text = content;
		}
		
		/** 是否支持窗体拖拽 */
		public function canDrag(value:Boolean):void
		{
			if(value==true)
			{
				title.addEventListener(MouseEvent.MOUSE_DOWN, __frameDragBeg);
				title.addEventListener(MouseEvent.MOUSE_UP, __frameDragEnd);
			}
			else
			{
				title.removeEventListener(MouseEvent.MOUSE_DOWN, __frameDragBeg);
				title.removeEventListener(MouseEvent.MOUSE_UP, __frameDragEnd);
			}
		}
		
		/** 窗体开始拖拽 */
		protected function __frameDragBeg(e:MouseEvent):void
		{
			this.startDrag();
		}
		
		/** 窗体结束拖拽 */
		protected function __frameDragEnd(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		/** 窗体点击到最前面 */
		public function canBringTop(value:Boolean):void
		{
			if(value==true)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, __bringTop);
			}
			else
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, __bringTop);
			}
		}
		
		/** 带到当前层最前面 */
		protected function __bringTop(e:MouseEvent):void
		{
			this.layer.addChild(this);
		}
	}
}