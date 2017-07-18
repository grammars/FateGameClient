package mouse
{
	import central.Centre;
	
	import com.anstu.jload.JLoadEvent;
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.BitmapData;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	
	import gamekit.FateGameKit;
	import gamekit.utils.StrUtils;

	public class CursorPack
	{
		/** 图标文件序列长度，000.png/001.png/002.png */
		private static const INDEX_FIX_LEN:int = 3;
		/** 图标文件格式 */
		private static const FILE_TYPE:String = ".png";
		
		public var name:String;
		public var frameCount:uint;
		public var frameRate:uint;
		
		private var loaded:Boolean = false;
		public function get available():Boolean { return loaded; }
		
		private var bmds:Vector.<BitmapData> = new Vector.<BitmapData>();
		
		public function CursorPack(name:String, frameCount:uint, frameRate:uint=1)
		{
			this.name = name;
			this.frameCount = frameCount;
			this.frameRate = frameRate;
		}
		
		public function load():void
		{
			var jl:JLoader = new JLoader(1);
			for(var i:int = 0; i < frameCount; i++)
			{
				var task:JLoadTask = new JLoadTask(JLoadTask.TYPE_DISPLAY_CONTENT, createAddr(i), FateGameKit.SAME_DOMAIN);
				task.onComplete = __picLoaded;
				jl.add(task);
			}
			jl.addEventListener(JLoadEvent.FINISH, __picAllLoaded);
			jl.start();
		}
		
		private function createAddr(index:int):String
		{
			var addr:String = Centre.RES_ROOT + "mouse" + Centre.FS + name + Centre.FS;
			addr += StrUtils.uintFixLen(index, INDEX_FIX_LEN) + FILE_TYPE;
			//trace("鼠标地址：" + addr);
			return addr;
		}
		
		private function __picLoaded(task:JLoadTask):void
		{
			bmds.push( task.result.getBmp().bitmapData );
		}
		
		private function __picAllLoaded(e:JLoadEvent):void
		{
			var jl:JLoader = e.target as JLoader;
			jl.removeEventListener(JLoadEvent.FINISH, __picAllLoaded);
			
			var mcd:MouseCursorData = new MouseCursorData();
			mcd.frameRate = this.frameRate;
			mcd.data = bmds;
			Mouse.registerCursor(name, mcd);
			
			loaded = true;
			
			Centre.MOUSE.freshCursor();
		}
	}
}