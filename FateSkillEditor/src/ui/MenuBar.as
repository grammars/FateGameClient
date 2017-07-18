package ui
{
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import ui.ctrls.BFrame;
	import ui.ctrls.CrystalBtn;
	
	public class MenuBar extends BFrame
	{
		private static var _instance:MenuBar;
		public static function get instance():MenuBar
		{
			if(_instance == null) { _instance = new MenuBar(); }
			return _instance;
		}
		
		private static const BTN_W:int = 76;
		private static const BTN_H:int = 30;
		private static const BTN_GAP:int = 2;
		
		override public function get W():int
		{
			return Editor.stage.stageWidth;
		}
		
		override public function get H():int
		{
			return BTN_H + 2*MARGIN;
		}
		
		public function MenuBar()
		{
			super();
		}
		
		override protected function createParts():void
		{
			super.createParts();
			
			createItemBtn("新建落点", __newLocate);
			createItemBtn("新建路径", __newRoute);
			createItemBtn("·画笔模式·", __draw);
			createItemBtn("·橡皮擦模式·", __erase);
			createItemBtn("·中心点模式·", __centre);
			createItemBtn("导入参考图", __importPic);
			createItemBtn("输出落点", __outputLocate);
			createItemBtn("输出路径", __outputRoute);
			createSeparator();
			createItemBtn("设置", __config);
			createItemBtn("帮助", __help);
		}
		
		private var btnNum:int = 0;
		private function createItemBtn(caption:String, cb:Function):JPushButton
		{
			var btn:JPushButton = new CrystalBtn(caption, cb, BTN_W, BTN_H);
			btn.move(nextX(), MARGIN);
			this.addChild(btn);
			btnNum++;
			return btn;
		}
		
		private var separatorNum:int = 0;
		private function createSeparator():void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(Editor.FL_COLOR, 1);
			shape.graphics.drawRoundRect(0,0,BTN_GAP,BTN_H,2);
			shape.graphics.endFill();
			shape.x = nextX();
			shape.y = MARGIN;
			this.addChild(shape);
			separatorNum++;
		}
		
		private function nextX():int { return MARGIN+(BTN_W+BTN_GAP)*btnNum + BTN_GAP*2*separatorNum; }
		
		
		private function __newLocate(e:MouseEvent):void
		{
			//新建落点
			Editor.clear();
		}
		
		private function __newRoute(e:MouseEvent):void
		{
			//新建路径
			Editor.clear();
		}
		
		private function __draw(e:MouseEvent):void
		{
			//画笔模式
			Editor.oper = Editor.OPER_DRAW;
		}
		
		private function __erase(e:MouseEvent):void
		{
			//橡皮擦模式
			Editor.oper = Editor.OPER_ERASE;;
		}
		
		private function __centre(e:MouseEvent):void
		{
			//设置中心模式
			Editor.oper = Editor.OPER_CENTRE;;
		}
		
		private function __importPic(e:MouseEvent):void
		{
			//导入参考图 
			var file:File = new File();
			file.addEventListener(Event.SELECT, __picSelect);
			file.browseForOpen("导入参考图");
		}
		
		private function __picSelect(e:Event):void
		{
			var file:File = e.target as File;
			if(file.extension == "jpg" || file.extension == "png" || file.extension == "bmp"
			|| file.extension == "jpeg" || file.extension == "gif")
			{
				Editor.loader.load(new URLRequest(file.nativePath));
				Editor.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __picLoaded);
				Editor.root.addChildAt(Editor.loaderFrame, 0);
			}
		}
		
		private function __picLoaded(e:Event):void
		{
			const LW:int = Editor.loader.width;
			const LH:int = Editor.loader.height;
			Editor.loaderFrame.x = (GridsCanvas.WIDTH-LW)/2;
			Editor.loaderFrame.y = (GridsCanvas.HEIGHT-LH)/2 + _instance.H;
			
			const G:Graphics = Editor.loaderFrame.graphics;
			G.clear();
			G.lineStyle(2, 0x2b2b2b, 1);
			G.drawRect(0, 0, LW, LH);
			G.moveTo(0, LH/2);
			G.lineTo(LW, LH/2);
			G.moveTo(LW/2, 0);
			G.lineTo(LW/2, LH);
			G.endFill();
		}
		
		private function __outputLocate(e:MouseEvent):void
		{
			//输出
			Editor.output.text = Editor.exportLocate();
		}
		
		private function __outputRoute(e:MouseEvent):void
		{
			//输出
			Editor.output.text = Editor.exportRoute();
		}
		
		private function __config(e:MouseEvent):void
		{
			//设置
			ConfigPop.instance.show();
		}
		
		private function __help(e:MouseEvent):void
		{
			//帮助
			Alert.instance.warn("帮助你妹啊，自己想办法解决？什么？你想不出办法？给我滚！！！犊子", "乐于助人小帮手");
			//Alert.instance.warn("非洲难民特供活动现在已开启，是否立即进入？\r就算你立即进入也来不及了，我就是告诉你一下而已\r口可口可，你来打我啊");
		}
		
	}
}