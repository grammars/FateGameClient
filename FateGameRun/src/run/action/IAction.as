package run.action
{
	import central.Game;

	public class IAction
	{	
		public static const TEST_BING:int = 100;
		public static const TEST_GUAN:int = 200;
		public static const TEST_KING:int = 300;
		public static const TEST_GOD:int = 500;	
		/** 行为类型{默认} */
		public static const NULL:int = 0;
		/** 行为类型{行走} */
		public static const GO:int = 1;
		
		/** id自动生成计数 */
		private static var ID_COUNT:int = 0;
		
		public var id:int = 0;
		public var type:int = 0;
		private var block:Boolean = false;
		public function get isBlock():Boolean { return block; }
		private var over:Boolean = false;
		public function get isOver():Boolean { return over; };
		
		public function IAction(block:Boolean=false)
		{
			this.block = block;
			this.id = ID_COUNT++;
		}
		
		/** 开始这个行为 */
		public function start():void
		{
			
		}
		
		/** 停止这个行为[如果是并发行为的话往往需要进行stop处理] */
		public function stop():void
		{
			
		}
		
		/** 已经完成 */
		protected function done():void
		{
			over = true;
			Game.action.removeAction(this.id);
			if(block)
			{
				Game.action.nextInSeq();
			}
		}
		
		/** 我畏惧这些行为，如果有这些行为，请取消我 */
		public function fearTypes():Array
		{
			return null;
		}
		
		/** 如果有这些行为，请杀死他们 */
		public function killTypes():Array
		{
			return null;
		}
		
	}
}