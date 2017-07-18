package gamekit.avatar.material
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import gamekit.GameScene;
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarRule;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.avatar.res.AvatarPreRes;
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	import gamekit.map.material.AStarNode;
	import gamekit.map.material.MapConfig;
	
	[Event(name="AvatarEvent.WALK_PATH", type="gamekit.avatar.events.AvatarEvent")]
	[Event(name="AvatarEvent.WALK_STEP", type="gamekit.avatar.events.AvatarEvent")]
	[Event(name="AvatarEvent.WALK_STOP", type="gamekit.avatar.events.AvatarEvent")]
	[Event(name="AvatarEvent.ACTION_ONCE_DONE", type="gamekit.avatar.events.AvatarEvent")]

	public class AvatarDisplay extends Sprite
	{
		/** 是否是主角 */
		public var isHero:Boolean = false;
		/** 是否被鼠标判定为事实经过 */
		public var mouseOver:Boolean = false;
		
		private var pos:Point = new Point();
		/** setX */
		override public function set x(value:Number):void
		{
			pos.x = value;
			super.x = Math.round(value);
		}
		override public function get x():Number { return pos.x; }
		/** setY */
		override public function set y(value:Number):void
		{
			pos.y = value;
			super.y = Math.round(value);
		}
		override public function get y():Number { return pos.y; }
		
		/** 移动时候使用的动作 */
		public var moveAction:String = ActionType.RUN;
		
		protected var self:AvatarProxy;
		protected var horse:AvatarProxy;
		protected var weapon:AvatarProxy;
		
		protected var preAvatar:Bitmap;
		protected var _usePreAvatar:Boolean = false;
		/** 是否使用预加载替身 */
		public function set usePreAvatar(value:Boolean):void
		{
			if(_usePreAvatar == value) { return; }
			_usePreAvatar = value;
			if(_usePreAvatar)
			{
				preAvatar = new Bitmap();
				preAvatar.bitmapData = AvatarPreRes.preAvatar;
				preAvatar.x = -AvatarPreRes.preAvatar.width/2;
				preAvatar.y = -AvatarPreRes.preAvatar.height;
				this.addChild(preAvatar);
			}
			else
			{
				if(preAvatar)
				{
					if(preAvatar.parent) { preAvatar.parent.removeChild(preAvatar); }
					preAvatar = null;
				}
			}
		}
		public function get usePreAvatar():Boolean { return _usePreAvatar; }
		
		/** 当前所处格子位置 */
		protected var gridPos:Point = new Point(0,0);
		/** 移动处理 */
		protected var mover:MoveHandler;
		/** 执行动作 */
		protected var action:String = ActionType.STAND;
		/** 方向 */
		protected var direction:int = 0;
		/** 动作播放速度 */
		public var actionSpeed:ActionSpeed = new ActionSpeed();
		
		/** 面向的AvatarDisplay */
		protected var towardAvt:AvatarDisplay;
		public function getTowardAvt():AvatarDisplay { return towardAvt; }
		/** 面向距离 */
		public static const TOWARD_DISTANCE:Number = 1.6;
		/** 指定面向距离 */
		protected var appointTowardDistance:Number = 1;
		
		/** 该avatar诞生绝对时间 */
		protected var bornTime:Number;
		
		/** Avatar显示对象
		 * @param pBornTime:Object=null 指定诞生绝对时间 */
		public function AvatarDisplay(pBornTime:Object=null)
		{
			if(pBornTime) { bornTime = Number(pBornTime); }
			else { bornTime = new Date().time; }
			mover = new MoveHandler(this);
			actionSpeed.changeCall = applyActionSpeed;
			addShadow();
		}
		
		/** 添加脚底阴影 */
		protected function addShadow():void
		{
			var fs:Bitmap = new Bitmap(AvatarPreRes.shadow);
			fs.x = -fs.width/2;
			fs.y = -fs.height/2;
			this.addChild(fs);
		}
		
		private var _selectedBmp:Bitmap;
		private function get selectedBmp():Bitmap
		{
			if(_selectedBmp == null)
			{
				_selectedBmp = new Bitmap(AvatarPreRes.avtSelect);
			}
			return _selectedBmp;
		}
		private var _selected:Boolean = false;
		/** 是否被选中 */
		public function set selected(value:Boolean):void
		{
			if(_selected != value)
			{
				_selected = value;
				if(_selected)
				{
					selectedBmp.x = -selectedBmp.width/2;
					selectedBmp.y = -selectedBmp.height/2;
					this.addChildAt(selectedBmp, 0);
				}
				else
				{
					if(selectedBmp.parent) { selectedBmp.parent.removeChild(selectedBmp); }
				}
			}
		}
		public function get selected():Boolean { return _selected; }
		
		public function setSelf(cfgAddr:String, swfAddr:String):void
		{
			if(self)
			{
				self.removeEventListener(Event.COMPLETE, __selfResLoaded);
				self.remove();
			}
			if(cfgAddr!=null && swfAddr!=null)
			{
				self = new AvatarProxy(bornTime);
				self.addEventListener(Event.COMPLETE, __selfResLoaded);
				self.install(cfgAddr, swfAddr);
				self.actionDoneCall = __actionDone;
				partChanged();
			}
		}
		private function __selfResLoaded(e:Event):void
		{
			usePreAvatar = false;
		}
		
		public function setHorse(cfgAddr:String, swfAddr:String):void
		{
			if(horse) { horse.remove() }
			if(cfgAddr!=null && swfAddr!=null)
			{
				horse = new AvatarProxy(bornTime);
				horse.install(cfgAddr, swfAddr);
				partChanged();
			}
		}
		
		public function setWeapon(cfgAddr:String, swfAddr:String):void
		{
			if(weapon) { weapon.remove() }
			if(cfgAddr!=null && swfAddr!=null)
			{
				weapon = new AvatarProxy(bornTime);
				weapon.install(cfgAddr, swfAddr);
				partChanged();
			}
		}
		
		/** 包含的AvatarProxy发生了变更 */
		protected function partChanged():void
		{
			if( horse ) { this.addChild(horse.getCartoon()); }
			if( self ) { this.addChild(self.getCartoon()); }
			if( weapon ) { this.addChild(weapon.getCartoon()); }
			syncStatus();
		}
		
		/** 同步状态到新AvatarProxy部件 */
		protected function syncStatus():void
		{
			setAction(getAction());
			setDirection(getDirection());
			applyActionSpeed();
		}
		
		public function remove():void
		{
			if(this.parent) { this.parent.removeChild(this); }
			if( self ) { self.remove(); }
			if( horse ) { horse.remove(); }
			if( weapon ) { weapon.remove(); }
		}
		
		/** 设置动作 */
		public function setAction(action:String):void
		{
			this.action = action;
			if(insertRequired==false)
			{
			if( self ) { self.setAction(action); }
			if( horse ) { horse.setAction(action); }
			if( weapon ) { weapon.setAction(action); }
			}
		}
		/** 获取动作 */
		public function getAction():String { return action; }
		
		/** 设置朝向 */
		public function setDirection(dir:int):void
		{
			this.direction = dir;
			if( self ) { self.setDirection(dir); }
			if( horse ) { horse.setDirection(dir); }
			if( weapon ) { weapon.setDirection(dir); }
		}
		/** 获取朝向 */
		public function getDirection():int { return direction; }
		
		private var speed:Number = 250;
		/** 设置移动速度[单位px/s] */
		public function setSpeed(value:Number):void
		{
			this.speed = value;
		}
		/** 获取移动速度[单位px/s] */
		public function getSpeed():Number { return this.speed; }
		
		/** 应用动作播放速度 */
		public function applyActionSpeed():void
		{
			if( self ) self.actionSpeed.cloneFrom(actionSpeed);
			if( horse ) horse.actionSpeed.cloneFrom(actionSpeed);
			if( weapon ) weapon.actionSpeed.cloneFrom(actionSpeed);
		}
		
		/** 动作播放完一遍之后的回调 */
		protected function __actionDone(curAction:String):void
		{
			//trace("AvatarDisplay::__actionDone ", curAction);
			handleInsertAction();
			AvatarEvent.dispatchActionOnceDone(this, curAction);
		}
		
		public function setGridX(value:int):void
		{
			gridPos.x = value;
		}
		public function getGridX():int { return gridPos.x; }
		
		public function setGridY(value:int):void
		{
			gridPos.y = value;
		}
		public function getGridY():int { return gridPos.y; }
		
		/** 将Grid x,y 同步适配 Pixel x,y */
		public function syncGxyAtPxy():void
		{
			gridPos.x = MapFacade.getInstance().getGridX(this.x);
			gridPos.y = MapFacade.getInstance().getGridY(this.y);
		}
		/** 将Pixel x,y 同步适配 Grid x,y */
		public function syncPxyAtGxy():void
		{
			this.x = MapFacade.getInstance().getPixelX(gridPos.x);
			this.y = MapFacade.getInstance().getPixelY(gridPos.y);
		}
		
		/** 按照路径走
		 * @param path 路径
		 * @param incStart 此路径是否包含起始点 */
		public function go(path:Array, incStart:Boolean=true):void
		{
			//tracePath(path);
			mover.go(path, incStart);
		}
		
		/** 通过寻路走到某点 */
		public function to(gx:int, gy:int):void
		{
			var arr:Array = Layer.map.findPath(getGridX(), getGridY(), gx, gy);
			go(arr);
		}
		
		/** 朝着指定对象走到其面前 */
		public function towards(ta:AvatarDisplay, appTowardDis:Object=null):void
		{
			cancelTowards();
			
			this.towardAvt = ta;
			this.appointTowardDistance = appTowardDis == null ? TOWARD_DISTANCE : Number(appTowardDis);
			if(this.towardAvt)
			{
				if(hasTowards(this.towardAvt))
				{
					towardsDone();
				}
				else
				{
					var tarPt:Point = getTowardsPt(this.getGridX(), this.getGridY(), this.towardAvt.getGridX(), ta.getGridY());
					this.to(tarPt.x, tarPt.y);
					this.addEventListener(AvatarEvent.WALK_STEP, __walkStep);
				}
			}
		}
		
		/** 取消朝着某方向走 */
		public function cancelTowards():void
		{
			this.removeEventListener(AvatarEvent.WALK_STEP, __walkStep);
			this.towardAvt = null;
		}
		
		/** 判断是否已经走到其面前了 */
		public function hasTowards(ta:AvatarDisplay):Boolean
		{
			if(!ta) { return false; }
			var deltX:int = ta.getGridX() - this.getGridX();
			var deltY:int = ta.getGridY() - this.getGridY();
			var nowDis:Number = Math.sqrt( deltX*deltX + deltY*deltY );
			return (nowDis <= appointTowardDistance);
		}
		
		/** 朝向他 */
		public function faceTo(ta:AvatarDisplay):void
		{
			var face:int = getTowardsFace(x, y, ta.x, ta.y);
			this.setDirection(face);
		}
		
		/** __walkStep */
		protected function __walkStep(e:AvatarEvent):void
		{
			if(this.towardAvt)
			{
				if(hasTowards(this.towardAvt))
				{
					towardsDone();
				}
				else
				{
					towards(this.towardAvt, appointTowardDistance);
				}
			}
			else
			{
				this.removeEventListener(AvatarEvent.WALK_STEP, __walkStep);
			}
		}
		
		/** 已完成靠近 */
		protected function towardsDone():void
		{
			faceTo(this.towardAvt);
			cancelTowards();
			this.stopMove();
		}
		
		/** 获得朝向对象的目标坐标点 */
		protected static function getTowardsPt(fromX:int, fromY:int, tarX:int, tarY:int):Point
		{
			var pt:Point = new Point(tarX,tarY);
			
			var deltX:int = 0;
			var deltY:int = 0;
			
			if(tarX-fromX > 0) { deltX = -TOWARD_DISTANCE; }
			else if(tarX-fromX < 0) { deltX = TOWARD_DISTANCE; }
			
			if(tarY-fromY > 0) { deltY = -TOWARD_DISTANCE; }
			else if(tarY-fromY < 0) { deltY = TOWARD_DISTANCE; }
			
			pt.x += deltX;
			pt.y += deltY;
			
			if( MapFacade.getInstance().getCurConfig().isBlock(pt.x, pt.y) )
			{
				pt.x = tarX;
				pt.y = tarY;
			}
			
			return pt;
		}
		
		/** 获得朝向对象的朝向 */
		private static function getTowardsFace(fromX:int, fromY:int, tarX:int, tarY:int):int
		{
			var face:int = -1;
			var deltX:int = 0;
			var deltY:int = 0;
			
			if(tarX-fromX > 0) { deltX = 1; }
			else if(tarX-fromX < 0) { deltX = -1; }
			
			if(tarY-fromY > 0) { deltY = 1; }
			else if(tarY-fromY < 0) { deltY = -1; }
			
			face = AvatarRule.countFaceDir(deltX, deltY);
			
			return face;
		}
		
		/** 停止移动行为 */
		public function stopMove():void
		{
			mover.stop();
		}
		
		/** 瞬移到某点 */
		public function teleport(gx:int, gy:int):void
		{
			this.setGridX(gx);
			this.setGridY(gy);
			syncPxyAtGxy();
			stopMove();
			if(this.isHero)
			{
				GameScene.getInstance().focusTarget(this);
			}
		}
		
		/** 是否存在插播动作 */
		private var insertRequired:Boolean = false;
		/** 插播的动作队列 */
		private var insertActions:Vector.<String> = new Vector.<String>();
		/** 插播动作 */
		public function playAction(action:String, immediate:Boolean=true):void
		{
			insertActions.push(action);
			insertRequired = true;
			if(immediate)
			{
				handleInsertAction();
			}
		}
		/** 处理插播动作 */
		private function handleInsertAction():void
		{
			if(insertRequired)
			{
				if(insertActions.length > 0)
				{
					var insAction:String = insertActions.shift();
					if( self ) self.setAction(insAction);
					if( horse ) horse.setAction(insAction);
					if( weapon ) weapon.setAction(insAction);
				}
				else
				{
					if( self ) self.setAction(this.action);
					if( horse ) horse.setAction(this.action);
					if( weapon ) weapon.setAction(this.action);
					insertRequired = false;
				}
			}
		}
		/** 清空动作队列 */
		public function clearActions():void
		{
			insertActions.length = 0;
			insertRequired = false;
		}
		
		/** 立即播放并且设置为此动作，抹杀之前所有的动作队列  */
		public function playAndSetAction(action:String):void
		{
			clearActions();
			setAction(action);
		}
		
		/** 打印路径 */
		protected function tracePath(path:Array):void
		{
			if(path == null)
			{
				trace("path == null");
			}
			else if(path.length == 0)
			{
				trace("path.length == 0");
			}
			else
			{
				var str:String = "path => ";
				for(var i:int = 0; i < path.length; i++)
				{
					var node:AStarNode = path[i];
					str += node.toString();	
				}
				trace(str);
			}
		}
		
		private var testBmp:Bitmap = new Bitmap();
		/** 是否包含该全局点 */
		public function includeGP(gp:Point):Boolean
		{
			var lp:Point = this.globalToLocal(gp);
			
			if( self && self.getCartoon().includeLP(lp) )
			{
				return true;
			}
			if( horse && horse.getCartoon().includeLP(lp) )
			{
				return true;
			}
			if( weapon && weapon.getCartoon().includeLP(lp) )
			{
				return true;
			}
			
			if( preAvatar && preAvatar.bitmapData )
			{
				var color:uint = preAvatar.bitmapData.getPixel32(lp.x+preAvatar.bitmapData.width/2, lp.y+preAvatar.bitmapData.height);
				if(color != 0) { return true; }
			}
			
			return false;
		}
		
		/** [Interface]clickHandler */
		public function clickHandler(e:MouseEvent):void
		{
			
		}
		
		/** [Interface]overHandler */
		public function overHandler(e:MouseEvent):void
		{
			
		}
		
		/** [Interface]outHandler */
		public function outHandler(e:MouseEvent):void
		{
			
		}
		
	}
}