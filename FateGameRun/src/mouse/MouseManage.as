package mouse
{
	import central.AbstractManage;
	
	import com.anstu.jcommon.log.Log;
	
	import flash.ui.Mouse;
	
	public class MouseManage extends AbstractManage
	{
		private var cursor:String = "";
		private var cursorDic:Object = new Object();
		
		public function MouseManage()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			Log.print("MouseManage::startup()");
			super.startup();
			
			Cursor.DEFAULT.show();
			
			startupComplete();
		}
		
		/** 载入并注册光标,仅适合32*32（含）以下的尺寸,但不会生效 */
		public function loadCursor(name:String, frameCount:uint, frameRate:uint=1):void
		{
			if(!cursorDic[name])
			{
				var cp:CursorPack = new CursorPack(name, frameCount, frameRate);
				cp.load();
				cursorDic[name] = cp;
			}
		}
		
		/** 改变光标 */
		public function changeCursor(name:String):void
		{
			this.cursor = name;
			var cp:CursorPack = cursorDic[name];
			if(cp && cp.available)
			{
				Mouse.cursor = this.cursor;
			}
		}
		
		/** 光标文件加载完毕之后需要刷新光标 */
		public function freshCursor():void
		{
			changeCursor(cursor);
		}
		
		/** 显示光标 */
		public function show():void
		{
			Mouse.show();
		}
		
		/** 隐藏光标 */
		public function hide():void
		{
			Mouse.hide();
		}
		
	}
}