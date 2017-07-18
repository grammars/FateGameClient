package mouse
{
	import central.Centre;

	public class Cursor
	{
		/** 默认光标 */
		public static const DEFAULT:Cursor = new Cursor("default", 2, 4);
		/** 战斗光标 */
		public static const FIGHT:Cursor = new Cursor("fight", 1, 1);
		/** 聊天光标 */
		public static const CHAT:Cursor = new Cursor("chat", 1, 1);
		/** 拾取光标 */
		public static const PICK:Cursor = new Cursor("pick", 1, 1);
		
		public var name:String;
		public var frameCount:uint;
		public var frameRate:uint;
		
		public function Cursor(name:String, frameCount:uint, frameRate:uint)
		{
			this.name = name;
			this.frameCount = frameCount;
			this.frameRate = frameRate;
		}
		
		public function show():void
		{
			Centre.MOUSE.loadCursor(name, frameCount, frameRate);
			Centre.MOUSE.changeCursor(name);
		}
		
	}
}