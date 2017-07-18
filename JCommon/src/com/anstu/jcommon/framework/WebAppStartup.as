package com.anstu.jcommon.framework
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class WebAppStartup
	{
		private var docSp:Sprite;
		private var callback:Function;
		
		/** Constructor  
		 * @param docSp:Sprite 文档类实例
		 * @param callback:Function 完成后回调函数 */
		public function WebAppStartup(docSp:Sprite, callback:Function)
		{
			this.docSp = docSp;
			this.callback = callback;
			
			if(docSp.stage)
			{
				resizeListaner(null);
			}
			else
			{
				docSp.addEventListener(Event.ADDED_TO_STAGE, resizeListaner);
			}
		}
		
		private function resizeListaner(event:Event):void
		{
			if(event != null)
			{
				docSp.removeEventListener(Event.ADDED_TO_STAGE, resizeListaner);
			}
			//限制 flash 的尺寸不进行拉伸, 否则不会触发 resize 事件
			docSp.stage.align = StageAlign.TOP_LEFT;
			docSp.stage.scaleMode = StageScaleMode.NO_SCALE;
			if(docSp.stage.stageWidth == 0 || docSp.stage.stageHeight == 0)
			{
				docSp.stage.addEventListener(Event.RESIZE, resizeHandler);
			}
			else
			{
				inited();
			}
		}
		
		private function resizeHandler(event:Event):void
		{
			if(docSp.stage.stageWidth > 0 && docSp.stage.stageHeight > 0)
			{
				docSp.stage.removeEventListener(Event.RESIZE, resizeHandler);
				inited();
			}
		}
		
		private function inited():void
		{
			callback.call();
		}
		
	}
}