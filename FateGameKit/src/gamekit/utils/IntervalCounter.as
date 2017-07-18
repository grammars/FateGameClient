package gamekit.utils
{
	public class IntervalCounter
	{
		private var _interval:int = 1;
		public function set interval(value:int):void
		{
			_interval = value;
			counter = 0;
		}
		public function get interval():int { return _interval;  }
		
		private var counter:int = 0;
		
		/** interval:间隔  interval<=0 则 永不触发<br>
		 * interval=1 [每1次触发1次]; interval=2 [每2次触发1次];<br>
		 * triggerNow:是否立即触发第一次 */
		public function IntervalCounter(interval:int=0)
		{
			this.interval = interval;
		}
		
		public function trigger():Boolean
		{
			if(interval <= 0) return false;
			counter++;
			if(counter >= interval)
			{
				counter = 0;
				return true;
			}
			return false;
		}
		
	}
}