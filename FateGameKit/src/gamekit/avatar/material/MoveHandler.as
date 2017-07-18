package gamekit.avatar.material
{
	import com.greensock.TweenMax;
	import com.greensock.data.TweenMaxVars;
	import com.greensock.easing.Linear;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import gamekit.FateGameKit;
	import gamekit.GameScene;
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarFacade;
	import gamekit.avatar.AvatarRule;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	import gamekit.map.deco.MapDecorator;
	import gamekit.map.material.AStarNode;
	import gamekit.map.material.MapConfig;
	import gamekit.map.material.MapLayer;
	import gamekit.utils.IntervalCounter;

	public class MoveHandler
	{
		private var tar:AvatarDisplay;
		
		private var path:Array;
		
		/** 下一格子目标点 */
		private var targetGrid:AStarNode;
		
		private var isWalking:Boolean = false;
		
		public function MoveHandler(tar:AvatarDisplay)
		{
			this.tar = tar;
		}
		
		/** 优化路径 */
		protected static function optimizePath(path:Array):Array
		{
			if(path == null || path.length == 0) return path;
			var optArr:Array = new Array();
			var lastVec:Point = null;
			for(var i:int = 0; i < path.length; i++)
			{
				var curVec:Point = null;
				var lastNode:AStarNode = null;
				var curNode:AStarNode = path[i];
				if(i >= 1)
				{
					lastNode = path[i-1];
					curVec = new Point(curNode.ind_X-lastNode.ind_X, curNode.ind_Y-lastNode.ind_Y);
					if(lastVec == null || lastVec.x != curVec.x || lastVec.y != curVec.y)
					{
						optArr.push(lastNode);
					}
					lastVec = curVec;
					if(i == path.length-1)
					{
						optArr.push(curNode);
					}
				}
			}
			if(path.length == 1)
			{
				optArr.push(path[0]);
			}
			return optArr;
		}
		
		/** 开始行走 */
		public function go(path:Array, incStart:Boolean=true):void
		{
			TweenMax.killTweensOf(this.tar);
			//注意此方法中的形参path和成员变量this.path重名,注意添加this
			Layer.map.getAstarShape().graphics.clear();
			//
			this.path = path;//optimizePath(path);
			//trace("优化后的路径为:", this.path);
			if(incStart && this.path.length <= 1)
			{
				//点击了原地
				stop();
				return;
			}
			
			//trace("主角自己的坐标("+tar.getGridX()+","+tar.getGridY()+")");
			AvatarEvent.dispatchWalkPathEvent(this.tar, path, isWalking);
			
			if(incStart && this.path.length >= 2)
			{
				this.path.shift();//原则上获得的可行走的路径至少包含start和end两个节点，所以剔除第一个start节点
			}
			//trace("剔除后的路径为:", this.path);
			this.tar.clearActions();
			this.tar.setAction(this.tar.moveAction);
			step();
		}
		
		/** 走一步 */
		private function step():void
		{
//			if(this.tar.name == "hero")
//			{
//				trace(":::>step");
//			}
			var isHero:Boolean = this.tar.isHero;
			targetGrid = this.path.shift();
			//trace("step:::",targetGrid);
			if(targetGrid)
			{
				var cfg:MapConfig = MapFacade.getInstance().getCurConfig();
				if(cfg == null)
				{
					stop();
					return;
				}
				//
				const nextPixX:Number = MapFacade.getInstance().getPixelX(targetGrid.ind_X);
				const nextPixY:Number = MapFacade.getInstance().getPixelY(targetGrid.ind_Y);
				const nowPixX:Number = tar.x;
				const nowPixY:Number = tar.y;
				const suggestDX:Number = nextPixX - nowPixX;
				const suggestDY:Number = nextPixY - nowPixY;
				
				const distance:Number = Math.sqrt( suggestDX*suggestDX + suggestDY*suggestDY );
				//trace("distance=", distance);
				if( distance == 0 )
				{
					stop();
				}
				AvatarEvent.dispatchWalkStepEvent(this.tar, targetGrid);
				
				const suggestDir:int = AvatarRule.countFaceDir(suggestDX, suggestDY);
				if(suggestDir != -1)
				{
					this.tar.setDirection(suggestDir);
				}
				//
				var stepTime:Number = getStepTime(this.tar.getSpeed(), distance);
				TweenMax.to(this.tar, stepTime, {x:nextPixX, y:nextPixY, ease: Linear.easeNone, onUpdate: __tweening, onComplete: __tweenOver});
				//
				isWalking = true;
			}
			else
			{
				stop();
			}
		}
		
		/** __tweening */
		private function __tweening():void
		{
			this.tar.syncGxyAtPxy();
			
			if(this.tar.isHero)
			{
				GameScene.getInstance().focusTarget(this.tar);
			}
		}
		
		/** __tweenOver */
		private function __tweenOver():void
		{
			step();
		}
		
		/** stop */
		public function stop():void
		{
//			if(this.tar.name == "hero")
//			{
//				trace("stop:::");
//			}
			isWalking = false;
			TweenMax.killTweensOf(this.tar);
			if(this.path) { this.path.length = 0; }
			this.tar.setAction(ActionType.STAND);
			AvatarEvent.dispatchWalkStopEvent(this.tar);
		}
		
		
		/** 获取此step的时间 */
		private function getStepTime(speed:Number, distance:Number):Number
		{
			return distance / speed;
		}
		
		
	}
}
