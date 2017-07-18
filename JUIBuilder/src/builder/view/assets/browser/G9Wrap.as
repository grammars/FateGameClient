package builder.view.assets.browser
{
	import builder.view.StatusBar;
	import builder.view.assets.oper.AddG9BmdSure;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class G9Wrap extends Sprite
	{
		private var content:DisplayObject;
		
		private var left:int = 1;
//		public function setLeft(value:int):void
//		{
//			left = value;
//		}
		public function getLeft():int { return left; }
		
		private var right:int = 2;
//		public function setRight(value:int):void
//		{
//			right = value;
//		}
		public function getRight():int { return right; }
		
		private var top:int = 1;
//		public function setTop(value:int):void
//		{
//			top = value;
//		}
		public function getTop():int { return top; }
		
		private var bottom:int = 2;
//		public function setBottom(value:int):void
//		{
//			bottom = value;
//		}
		public function getBottom():int { return bottom; }
		
		public function setParams(pLeft:int, pRight:int, pTop:int, pBottom:int):void
		{
			left = pLeft;
			right = pRight;
			top = pTop;
			bottom = pBottom;
			
			if(!this.content) { return; }
			
			if(left < 0) { left = 1; }
			if(left >= this.content.width-1) { left = 1; }
			if(right < left) { right = left + 1; }
			if(right > this.content.width-1) { right = left + 1; }
			
			if(top < 0) { top = 1; }
			if(top >= this.content.height-1) { top = 1; }
			if(bottom < top) { bottom = top + 1; }
			if(bottom > this.content.height-1) { bottom = top + 1; }
			
			lva.x = left;
			lvb.x = right;
			lha.y = top;
			lhb.y = bottom;
			
			AddG9BmdSure.instance.g9Changed();
		}
		
		private var lha:Line = new Line();
		private var lhb:Line = new Line();
		private var lva:Line = new Line();
		private var lvb:Line = new Line();
		
		public function G9Wrap()
		{
			super();
			
			lha.addEventListener(Event.CHANGE, __lineChange);
			lhb.addEventListener(Event.CHANGE, __lineChange);
			lva.addEventListener(Event.CHANGE, __lineChange);
			lvb.addEventListener(Event.CHANGE, __lineChange);
		}
		
		private function __lineChange(e:Event):void
		{
			countParam();
		}
		
		/** 计算参数 */
		private function countParam():void
		{
			left = Math.min(lva.x, lvb.x);
			right = Math.max(lva.x, lvb.x);
			top = Math.min(lha.y, lhb.y);
			bottom = Math.max(lha.y, lhb.y);
			
			AddG9BmdSure.instance.g9Changed();
		}
		
		public function setContent(content:DisplayObject):void
		{
			clear();
			
			this.content = content;
			if(content == null)
			{
				
			}
			else
			{
				if(content.width >=3 || content.height >= 3)
				{
					this.addChild(this.content);
					
					lha.bounds.height = content.height;
					lhb.bounds.height = content.height;
					lva.bounds.width = content.width;
					lvb.bounds.width = content.width;
					
					lha.setSize(content.width, 1);
					lhb.setSize(content.width, 1);
					lva.setSize(1, content.height);
					lvb.setSize(1, content.height);
					
					lha.y = content.height * 3 / 8;
					lhb.y = content.height * 5 / 8;
					lva.x = content.width * 3 / 8;
					lvb.x = content.width * 5 / 8;
					
					this.addChild(lha);
					this.addChild(lhb);
					this.addChild(lva);
					this.addChild(lvb);
				}
				else
				{
					StatusBar.instance.show("图像尺寸小于3*3没有必要使用九宫图");
				}
			}
			countParam();
		}
		
		private function clear():void
		{
			if(this.content && this.content.parent)
			{
				this.content.parent.removeChild(this.content);
			}
		}
		
	}	

}

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

class Line extends Sprite
{
	private var w:int = 1;
	private var h:int = 1;
	
	public var bounds:Rectangle = new Rectangle(0,0,1,1);
	
	public function Line()
	{
		super();
		this.buttonMode = true;
		this.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
		this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
	}	
	
	private function __mouseDown(e:MouseEvent):void
	{
		this.startDrag(false, bounds);
		this.addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		e.stopImmediatePropagation();
	}
	
	private function __mouseMove(e:MouseEvent):void
	{
		this.dispatchEvent(new Event(Event.CHANGE));
	}
	
	private function __mouseUp(e:MouseEvent):void
	{
		this.stopDrag();
		this.removeEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		this.dispatchEvent(new Event(Event.CHANGE));
	}
	
	public function setSize(w:int, h:int):void
	{
		this.w = w;
		this.h = h;
		paint();
	}
	
	private function paint():void
	{
		this.graphics.clear();
		this.graphics.lineStyle(5, 0xffffff, 0.5);
		this.graphics.drawRect(0, 0, w, h);
		this.graphics.endFill();
		
		this.graphics.lineStyle(0, 0, 0);
		this.graphics.beginFill(0xfe0000);
		this.graphics.drawRect(0, 0, w, h);
		this.graphics.endFill();
	}
}