package gamekit.avatar.material
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import gamekit.FateGameKit;
	import gamekit.debug.AvtMonitor;
	import gamekit.layer.Layer;
	import gamekit.utils.DisObjSelect;
	import gamekit.utils.IntervalCounter;

	public class AvatarLayer extends Sprite
	{
		/** 主角体 */
		private var hero:AvatarDisplay;
		
		/** 更新显示深度排序间隔 */
		private var updateDisDepthIC:IntervalCounter = new IntervalCounter(30);
		
		private var enable:Boolean = true;
		public function setEnable(value:Boolean):void
		{
			this.enable = value;
			this.mouseChildren = this.mouseEnabled = this.enable;
		}
		public function getEnable():Boolean { return this.enable; }
		
		public function AvatarLayer()
		{
			this.addEventListener(MouseEvent.CLICK, __mouseClick);
			this.addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
		}
		
		/** __mouseClick */
		private function __mouseClick(e:MouseEvent):void
		{
			//trace("AvatarLayer::__mouseClick");
			var findAvt:Boolean = false;
			var gp:Point = new Point(FateGameKit.STAGE.mouseX, FateGameKit.STAGE.mouseY);
			var children:Vector.<AvatarDisplay> = getChildren();
			for(var i:int = children.length-1; i >= 0; i--)
			{
				if( children[i].mouseEnabled && children[i].includeGP(gp) )
				{
					children[i].clickHandler(e);
					findAvt = true;
					break;
				}
			}
			if(!findAvt)
			{
				var lp2map:Point = Layer.map.globalToLocal(gp);
				e.localX = lp2map.x;
				e.localY = lp2map.y;
				Layer.map.dispatchEvent(e);
			}
		}
		
		/** __mouseMove */
		private function __mouseMove(e:MouseEvent):void
		{
			//trace("AvatarLayer::__mouseMove");
			var gp:Point = new Point(FateGameKit.STAGE.mouseX, FateGameKit.STAGE.mouseY);
			var children:Vector.<AvatarDisplay> = getChildren();
			var targetGot:Boolean = false;//目标已找寻到
			for(var i:int = children.length-1; i >= 0; i--)
			{
				var ch:AvatarDisplay = children[i];
				if( targetGot==false && ch.mouseEnabled && ch.includeGP(gp) )
				{
					if(ch.mouseOver == false)
					{
						ch.overHandler(e);
						ch.mouseOver = true;
					}
					targetGot = true;
				}
				else
				{
					if(ch.mouseOver == true)
					{
						ch.outHandler(e);
						ch.mouseOver = false;
					}
				}
			}
		}
		
		/** 获取鼠标经过的AvatarDisplay */
		public function getMouseOverTarget():AvatarDisplay
		{
			var gp:Point = new Point(FateGameKit.STAGE.mouseX, FateGameKit.STAGE.mouseY);
			var children:Vector.<AvatarDisplay> = getChildren();
			for(var i:int = children.length-1; i >= 0; i--)
			{
				var ch:AvatarDisplay = children[i];
				if( ch.mouseEnabled && ch.includeGP(gp) )
				{
					return ch;
				}
			}
			return null;
		}
		
		/** 添加AvatarDisplay */
		public function append(dis:AvatarDisplay):AvatarDisplay
		{
			if(dis.isHero)
			{
				hero = dis;
			}
			dis.syncPxyAtGxy();
			super.addChild(dis);
			updateDisDepth();
			return dis;
		}
	
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			throw new Error("AvatarLayer::addChild is not allowed");
			return child;
		}
		
		/** ENTER_FRAME */
		public function nextFrame():void
		{
			if(updateDisDepthIC.trigger())
			{
				updateDisDepth();
			}
		}
		
		/** 获取所有的avatar对象 */
		public function getChildren():Vector.<AvatarDisplay>
		{
			var chs:Vector.<AvatarDisplay> = new Vector.<AvatarDisplay>();
			var i:int = 0;
			for(i = 0; i < this.numChildren; i++)
			{
				if(this.getChildAt(i) is AvatarDisplay)
				{
					chs.push(this.getChildAt(i));
				}
			}
			return chs;
		}
		
		/** 更新显示深度排序 */
		private function updateDisDepth():void
		{
			var children:Vector.<AvatarDisplay> = getChildren();
			children.sort(compareDepth);
			for(var i:int = 0; i < children.length; i++)
			{
				if(this.getChildIndex(children[i]) != i)
				{
					this.setChildIndex(children[i], i);
				}
			}
			
			AvtMonitor.getInstance().setNum(children.length);//顺便在此处加上调试器
		}
		private function compareDepth(a:AvatarDisplay, b:AvatarDisplay):int
		{
			if(a.y > b.y) { return 1; }
			else if (a.y == b.y) { return 0; }
			else { return -1; }
		}
		private function compareRealDepth(a:AvatarDisplay, b:AvatarDisplay):int
		{
			var aY:int = a.localToGlobal(new Point()).y;
			var bY:int = b.localToGlobal(new Point()).y;
			if(aY > bY) { return 1; }
			else if (aY == bY) { return 0; }
			else { return -1; }
		}
		
	}
}