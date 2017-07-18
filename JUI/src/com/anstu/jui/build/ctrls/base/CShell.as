package com.anstu.jui.build.ctrls.base
{
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.define.JSize;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CShell extends Sprite implements ICShell
	{
		private static var frame:ShellFrame = new ShellFrame("default", 0x00ffff, 1, 1, 0xff0000, 2, 0.8);
		public static function setFrame(value:ShellFrame):void
		{
			frame = value;
		}
		
		/** 获得除基本属性之外的属性名String[] */
		public function getAttris():Array
		{
			return [];
		}
		
		/** 获得模版属性名String[] */
		public function getTpls():Array
		{
			return [];
		}
		
		/** 仅作为展示，不能被属性编辑器操纵 */
		public var onlyModel:Boolean = false;
		/** 是否允许拖动 */
		public static var allowDrag:Boolean = true;
		
		/** 资源命名空间 */
		public var assetsNS:String;
		
		public function getType():String { return getUI().toString(); }
		
		public function setTag(value:String):void
		{
			getUI().tag = value;
		}
		public function getTag():String { return getUI().tag; }
		
		public function setX(value:String):void
		{
			this.x = parseInt(value);
		}
		public function getX():String { return this.x.toString(); }
		
		public function setY(value:String):void
		{
			this.y = parseInt(value);
		}
		public function getY():String { return this.y.toString(); }
		
		public function setWidth(value:String):void
		{
			getUI().width = parseInt(value);
			paint();
		}
		public function getWidth():String { return getUI().width.toString(); }
		
		public function setHeight(value:String):void
		{
			getUI().height = parseInt(value);
			paint();
		}
		public function getHeight():String { return getUI().height.toString();; }
		
		/** 获得实际的控件<br>需要被覆盖 */
		public function getUI():JComponent { return null; }
		
		public var shellParent:ICShell;
		protected var shellChildren:Vector.<CShell> = new Vector.<CShell>();
		public function getChildren():Vector.<CShell> { return shellChildren; }
		
		protected var _selected:Boolean = false;
		public function set selected(value:Boolean):void
		{
			_selected = value;
			paint();
		}
		public function get selected():Boolean { return _selected; }
		
		public function CShell()
		{
			super();
			initialize();
			this.addChild(getUI());
			this.addEventListener(MouseEvent.CLICK, __click);
			this.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		}
		
		protected function initialize():void
		{
			//TODO
		}
		
		public function paint():void
		{
			var w:int = parseInt(getWidth());
			var h:int = parseInt(getHeight());
			this.graphics.clear();
			if(_selected)
			{
				this.graphics.lineStyle(frame.selectedThickness, frame.selectedColor, frame.selectedAlpha);
			}
			else
			{
				this.graphics.lineStyle(frame.frameThickness, frame.frameColor, frame.frameAlpha);
			}
			//this.graphics.beginFill(0xffff00, 0.3);
			this.graphics.drawRect(0, 0, w, h);
			this.graphics.endFill();
		}
		
		protected function __click(e:MouseEvent):void
		{
			if(CShellContext.instance.clickHandler)
			{
				CShellContext.instance.clickHandler.handle(e, this);
			}
		}
		
		protected function __mouseDown(e:MouseEvent):void
		{
			if(onlyModel) { return; }
			if(allowDrag) { this.startDrag(); }
			e.stopImmediatePropagation();
		}
		
		protected function __mouseUp(e:MouseEvent):void
		{
			if(onlyModel) { return; }
			this.stopDrag();
		}
		
		/** 添加一个CShell */
		public function addShell(child:CShell):void
		{
			child.removeSelf();
			
			getUI().addChild(child);
			if(shellChildren.indexOf(child) == -1)
			{
				shellChildren.push(child);
			}
			child.shellParent = this;
		}
		
		/** 移除一个CShell */
		public function removeShell(child:CShell):void
		{
			if(child.parent) { child.parent.removeChild(child); }
			var chInd:int = this.shellChildren.indexOf(child);
			if(chInd >= 0)
			{
				this.shellChildren.splice(chInd, 1);
			}
			child.shellParent = null;
		}
		
		/** 移除自身 */
		public function removeSelf():void
		{
			if(this.shellParent)
			{
				this.shellParent.removeShell(this);
				this.shellParent = null;
			}
		}
		
		/** 填充 */
		protected function fill(fillMethod:Function, value:String, fillOpt:String=null):void
		{
			CShellContext.instance.assetFiller.fill(fillMethod, value, assetsNS, fillOpt);
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
			else
			{
				this.visible = true;
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
		
		protected function baseAttriStr():String
		{
			var attriStr:String = "";
			attriStr += " tag='" + this.getTag() + "'";
			attriStr += " x='" + this.getX() + "'";
			attriStr += " y='" + this.getY() + "'";
			attriStr += " width='" + this.getWidth() + "'";
			attriStr += " height='" + this.getHeight() + "'";
			return attriStr;
		}
		
		/** 产生开始节点 */
		public function nodeBeg():String
		{
			return "<CShell>";
		}
		
		/** 产生结束节点 */
		public function nodeEnd():String
		{
			return "</CShell>";
		}
		
	}
}