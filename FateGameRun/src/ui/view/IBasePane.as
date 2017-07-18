package ui.view
{
	import flash.events.Event;

	public interface IBasePane
	{
		/** 显示面板 */
		function show():void;
		/** 隐藏面板 */
		function hide():void;
		/** 摆放默认位置 */
		function putDefaultPos(event:Event=null):void
	}
}