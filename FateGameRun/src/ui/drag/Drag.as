package ui.drag
{
	import central.Centre;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gamekit.layer.Layer;
	
	public class Drag
	{
		private static var instance:Drag;
		public static function getInstance():Drag
		{
			if(instance == null) { instance = new Drag(); }
			return instance;
		}
		
		private var dragging:Boolean = false;
		/** 是否正在拖拽 */
		public function isDragging():Boolean { return dragging; }
		
		private var action:String = null;
		/** 当前拖拽行为 */
		public function getAction():String { return action; }
		
		public function isDoing(action:String):Boolean
		{ 
			return (this.action == action); 
		}
		
		private var data:Object = null;
		/** 当前拖拽行为附带的数据 */
		public function getData():Object { return data; }
		
		/** 代理图像 */
		private var pImg:DisplayObject;
		
		public function Drag()
		{
			
		}
		
		/** start的Quick版本 */
		public function startQ(source:DisplayObject, action:String, data:Object):void
		{
			var bmd:BitmapData = new BitmapData(source.width, source.height, true, 0x0);
			bmd.draw(source);
			var bmp:Bitmap = new Bitmap(bmd);
			start(bmp, action, data);
		}
		
		/** 开始拖拽
		 * @param pImg:DisplayObject 代理图像
		 * @param action:String 拖拽行为
		 * @param data:Object 数据 */
		public function start(pImg:DisplayObject, action:String, data:Object):void
		{
			finish();
			this.pImg = pImg;
			this.action = action;
			this.data = data;
			dragging = true;
			Layer.ui.addChild(pImg);
			Centre.stage.addEventListener(Event.ENTER_FRAME, __following);
			Centre.stage.addEventListener(MouseEvent.MOUSE_UP, __stageMouseUp);
		}
		
		public function finish():void
		{
			dragging = false;
			if(pImg && pImg.parent) { pImg.parent.removeChild(pImg); }
			Centre.stage.removeEventListener(Event.ENTER_FRAME, __following);
			Centre.stage.removeEventListener(MouseEvent.MOUSE_UP, __stageMouseUp);
		}
		
		private function __following(e:Event):void
		{
			if(pImg)
			{
				pImg.x = Centre.mouseX - pImg.width/2;
				pImg.y = Centre.mouseY - pImg.height/2;
			}
		}
		
		private function __stageMouseUp(e:MouseEvent):void
		{
			finish();
		}
		
		public function dispose():void
		{
			this.action = null;
			this.data = null;
		}
	}
}