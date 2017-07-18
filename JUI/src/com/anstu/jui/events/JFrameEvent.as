package com.anstu.jui.events
{
	import com.anstu.jui.controls.JFrame;

	public class JFrameEvent extends JBaseEvent
	{
		/** 窗口被激活 */
		public static const ACTIVE:String = "JFrameEvent.ACTIVE";
		
		public var frame:JFrame;
		
		public function JFrameEvent(type:String, frame:JFrame, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.frame = frame;
		}
		
	}
}