package com.anstu.jui.components
{
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.events.JBaseEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[Event(name="resize", type="flash.events.Event")]
	[Event(name="JBaseEvent.DRAW", type="com.anstu.jui.events.JBaseEvent")]
	public class JComponent extends Sprite
	{
		protected var _type:String = "";
		/** 控件类型 */
		public function get type():String { return _type; }
		
		public function JComponent()
		{
			super();
			init();
		}
		
		//=====Set/Get==Beg========================================
		
		protected var _tag:String = "";
		/** 控件标签 */
		public function set tag(value:String):void
		{
			_tag = value;
		}
		public function get tag():String { return _tag; }
		
		protected var _enabled:Boolean = true;
		/** 是否可用 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			mouseEnabled = mouseChildren = _enabled;
			tabEnabled = value;
			alpha = _enabled ? 1.0 : 0.5;
		}
		public function get enabled():Boolean { return _enabled; }
		
		override public function set x(value:Number):void
		{
			super.x = Math.round(value);
		}
		
		override public function set y(value:Number):void
		{
			super.y = Math.round(value);
		}
		
		protected var _width:Number = 0;
		override public function set width(w:Number):void
		{
			_width = w;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get width():Number { return _width; }
		
		protected var _height:Number = 25;
		override public function set height(h:Number):void
		{
			_height = h;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		override public function get height():Number { return _height; }
		
		//=====Set/Get==End========================================
		
		/** 初始化 */
		protected function init():void
		{
			addChildren();
			invalidate();
		}
		
		/** 添加部件 */
		protected function addChildren():void
		{
			//TODO
		}
		
		/** 使失效，申请重绘  */
		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		/** 移动控件坐标 */
		public function move(xpos:Number, ypos:Number):void
		{
			x = Math.round(xpos);
			y = Math.round(ypos);
		}
		
		/** 设置尺寸 */
		public function setSize(w:Number, h:Number):void
		{
			_width = w;
			_height = h;
			dispatchEvent(new Event(Event.RESIZE));
			invalidate();
		}
		
		/** 请求重绘 */
		public function repaint():void
		{
			invalidate();
		}
		
		/** 绘制 */
		public function draw():void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			dispatchEvent(new JBaseEvent(JBaseEvent.DRAW));
			
			drawFrame();
		}
		
		/** 重绘帧事件 */
		protected function onInvalidate(event:Event):void
		{
			draw();
		}
		
		/** 试图从父容器中移除 */
		public function removeFromParent():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
		
		/** 呈现框架 [Deprecated] */
		public function showFrame(value:Boolean):void
		{
			useFrame = true;
		}
		
		protected var _useFrame:Boolean = false;
		/** 是否使用框架 */
		public function set useFrame(b:Boolean):void
		{
			if(_useFrame != b)
			{
				_useFrame = b;
				invalidate();
			}
		}
		public function get useFrame():Boolean { return _useFrame; }
		
		protected var _frameLineThick:Number = 1;
		/** 框架线粗细 */
		public function set frameLineThick(value:Number):void
		{
			_frameLineThick = value;
			invalidate();
		}
		public function get frameLineThick():Number { return _frameLineThick; }
		
		protected var _frameLineColor:uint = 0xff0000;
		/** 框架线颜色 */
		public function set frameLineColor(value:uint):void
		{
			_frameLineColor = value;
			invalidate();
		}
		public function get frameLineColor():uint { return _frameLineColor; }
		
		protected var _frameLineAlpha:Number = 1.0;
		/** 框架线透明度 */
		public function set frameLineAlpha(value:Number):void
		{
			_frameLineAlpha = value;
			invalidate();
		}
		public function get frameLineAlpha():Number { return _frameLineAlpha; }
		
		protected var _frameFillColor:uint = 0xb2b200;
		/** 框架填充颜色 */
		public function set frameFillColor(value:uint):void
		{
			_frameFillColor = value;
			invalidate();
		}
		public function get frameFillColor():uint { return _frameFillColor; }
		
		protected var _frameFillAlpha:Number = 0.5;
		/** 框架填充透明度 */
		public function set frameFillAlpha(value:Number):void
		{
			_frameFillAlpha = value;
			invalidate();
		}
		public function get frameFillAlpha():Number { return _frameFillAlpha; }
		
		protected var _frameRound:Number = 3;
		/** 框架圆角 */
		public function set frameRound(value:Number):void
		{
			_frameRound = value;
			invalidate();
		}
		public function get frameRound():Number { return _frameRound; }
		
		/** 绘制框架 */
		protected function drawFrame():void
		{
			this.graphics.clear();
			if(_useFrame)
			{
				this.graphics.lineStyle(_frameLineThick, _frameLineColor, _frameLineAlpha);
				this.graphics.beginFill(_frameFillColor, _frameFillAlpha);
				if(_frameRound > 0)
				{
					this.graphics.drawRoundRect(0, 0, _width, _height, _frameRound, _frameRound);
				}
				else
				{
					this.graphics.drawRect(0, 0, _width, _height);
				}
				this.graphics.endFill();
			}
		}
		
		protected var visualController:JCheckBox;
		/** 设置控制可视组件 */
		public function setVisualController(value:JCheckBox):void
		{
			if(this.visualController)
			{
				this.visualController.removeEventListener(Event.CHANGE, __visualControllerChanged);
			}
			this.visualController = value;
			if(this.visualController)
			{
				this.visualController.addEventListener(Event.CHANGE, __visualControllerChanged);
			}
			syncVisualForController();
		}
		/** __visualControllerChanged */
		private function __visualControllerChanged(e:Event):void
		{
			syncVisualForController();
		}
		/** syncVisualForController */
		public function syncVisualForController():void
		{
			if(this.visualController)
			{
				this.visible = this.visualController.selected;
			}
		}
		
	}
}