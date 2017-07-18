package ui.parts
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	public class DClick
	{
		/** 单击判定期限 */
		public var singleMs:int = 300;
		
		/** 传入参数e:MouseEvent */
		public var hDoubleClick:Function = null;
		/** 传入参数e:MouseEvent */
		public var hClick:Function = null;
		
		private var meetTid:uint = 0;
		
		public function DClick(target:InteractiveObject)
		{
			target.doubleClickEnabled = true;
			target.addEventListener(MouseEvent.DOUBLE_CLICK, __doubleClick);
			target.addEventListener(MouseEvent.CLICK, __click);
		}
		
		public function setup(hClick:Function=null, hDoubleClick:Function=null, singleMs:int=300):void
		{
			this.hClick = hClick;
			this.hDoubleClick = hDoubleClick;
			this.singleMs = singleMs;
		}
		
		public function unsetup():void
		{
			this.hClick = null;
			this.hDoubleClick = null;
		}
		
		private function __doubleClick(e:MouseEvent):void
		{
			if(hDoubleClick != null) { hDoubleClick(e); }
			clearTimeout(meetTid);
		}
		
		private function __click(e:MouseEvent):void
		{
			clearTimeout(meetTid);
			meetTid = setTimeout(meetClick, singleMs, e);
		}
		
		private function meetClick(e:MouseEvent):void
		{
			if(hClick != null) { hClick(e); }
		}
		
	}
}