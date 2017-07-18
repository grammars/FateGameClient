package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ScreenMouseEvent;
	import flash.system.Capabilities;
	
	import org.aswing.AsWingManager;
	import org.aswing.JFrame;
	import org.aswing.UIManager;
	import org.aswing.event.AWEvent;
	import org.aswing.event.FrameEvent;
	import org.aswing.event.ResizedEvent;
	import org.aswing.geom.IntDimension;
	import org.aswing.skinbuilder.orange.OrangeLookAndFeel;
	
	import view.MainWnd;
	
	public class FateMap extends Sprite
	{
		private var frame:JFrame;
		
		private static const LABEL_SPERATE:String = "";
		private static const LABEL_RELEASE:String = "打开";
		private static const LABEL_EXIT:String = "退出";
		
		private static const OPER_SPERATE:int = 0;
		private static const OPER_RELEASE:int = 101;
		private static const OPER_EXIT:int = 102;
		
		[Embed(source="icons/icon_16.png")]
		private var icon16:Class;
		
		private var mainWnd:NativeWindow;
		
		public function FateMap()
		{
			const WND_W:int = 800;
			const WND_H:int = 600;
			
			this.stage.nativeWindow.close();
			
			var option:NativeWindowInitOptions = new NativeWindowInitOptions();
			option.systemChrome = NativeWindowSystemChrome.NONE;
			option.transparent = true;
			option.type = NativeWindowType.UTILITY;
			
			mainWnd = new NativeWindow(option);
			mainWnd.stage.scaleMode = StageScaleMode.NO_SCALE;
			mainWnd.stage.align = StageAlign.TOP_LEFT;
			mainWnd.width = Capabilities.screenResolutionX;
			mainWnd.height = Capabilities.screenResolutionY;
			//mainWnd.alwaysInFront = true;
			mainWnd.x = 0;
			mainWnd.y = 0;
			mainWnd.activate();
			
			stage.nativeWindow.x = 0;
			stage.nativeWindow.y = 0;
			stage.nativeWindow.width = Capabilities.screenResolutionX;
			stage.nativeWindow.height = Capabilities.screenResolutionY;
			AsWingManager.initAsStandard(mainWnd.stage);
			var laf:OrangeLookAndFeel = new OrangeLookAndFeel();
			UIManager.setLookAndFeel(laf);
			frame = new JFrame(null, "FateMap");
			frame.setSizeWH(WND_W, WND_H);
			frame.setMinimumSize(new IntDimension(400, 300));
			const INIT_X:int = (Capabilities.screenResolutionX-WND_W)/2;
			const INIT_Y:int = (Capabilities.screenResolutionY-WND_H)/2;
			frame.setLocationXY(INIT_X, INIT_Y);
			frame.show();
			frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
			frame.addEventListener(FrameEvent.FRAME_CLOSING, __frameClosing);
			addToTray();
			//
			Global.setMainFrm(frame);
			Global.setStage(mainWnd.stage);
			Global.setMainWnd(mainWnd);
			//
			MainWnd.me().install(frame);
		}
		
		/** 添加到托盘 */
		private function addToTray():void
		{
			NativeApplication.nativeApplication.icon.bitmaps = [new icon16()];
			if(NativeApplication.supportsSystemTrayIcon)
			{
				var sti:SystemTrayIcon = SystemTrayIcon(NativeApplication.nativeApplication.icon);
				var menu:NativeMenu = new NativeMenu();
				var labels:Array = [LABEL_RELEASE, LABEL_SPERATE, LABEL_EXIT];
				var opers:Array = [OPER_RELEASE, OPER_SPERATE, OPER_EXIT];
				for(var i:int = 0; i < labels.length; i++)
				{
					var menuItem:NativeMenuItem = new NativeMenuItem(labels[i], opers[i]==OPER_SPERATE);
					menuItem.data = opers[i];
					menuItem.addEventListener(Event.SELECT, __menuItemClick);
					menu.addItem(menuItem);
				}
				sti.menu = menu;
				sti.addEventListener(ScreenMouseEvent.CLICK, __trayClick);
			}
		}
		
		/** 从系统托盘恢复到任务栏 */
		private function releaseFromTray():void
		{
			mainWnd.visible = true;
			mainWnd.orderToFront();
			mainWnd.activate();
			frame.setVisible(true);
		}
		
		/** 托盘图标被单击 */
		private function __trayClick(event:ScreenMouseEvent):void
		{
			releaseFromTray();
		}
		
		/** 托盘菜单选项被点中 */
		private function __menuItemClick(event:Event):void
		{
			var menu:NativeMenuItem = event.target as NativeMenuItem;
			switch(menu.data)
			{
			case OPER_RELEASE:
				releaseFromTray();
				break;
			case OPER_EXIT:
				shutdown();
				break;
			}
		}
		
		/** 退出程序的菜单事件 */
		private function shutdown():void
		{
			mainWnd.close();
		}
		
		/** 窗口试图关闭 */
		private function __frameClosing(event:FrameEvent):void
		{
			frame.setVisible(false);
		}
		
	}
}