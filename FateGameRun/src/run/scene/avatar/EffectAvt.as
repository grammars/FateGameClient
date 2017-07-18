package run.scene.avatar
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import comm.define.SpriteType;
	
	import flash.utils.ByteArray;
	
	import gamekit.avatar.ActionType;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	
	import run.scene.avatar.action.EffectFlyFollow;

	public class EffectAvt extends SpriteAvt
	{
		/** 特效离地高度 */
		private static const ABOVE_FLOOR:int = 50;
		
		/** 只播放一次 */
		private var playOnce:Boolean = false;
		
		public function EffectAvt(playOnce:Boolean=false, pBornTime:Object=null)
		{
			super(pBornTime);
			this.mouseEnabled = false;
			
			this.playOnce = playOnce;
			if(this.playOnce)
			{
				this.addEventListener(AvatarEvent.ACTION_ONCE_DONE, __actionOnceDone);
			}
			this.setAction(ActionType.EFFECT);
		}
		
		/** 添加脚底阴影 */
		override protected function addShadow():void
		{
			//
		}
		
		private var CRotation:Number = 0;
		/** 设置Cartoon旋转 */
		public function setCRotation(value:Number):void
		{
			if(this.CRotation != value)
			{
				this.CRotation = value;
				handleCRotation();
			}
		}
		/** 获取Cartoon旋转 */
		public function getCRotation():Number { return this.CRotation; }
		/** 实施Cartoon旋转 */
		private function handleCRotation():void
		{
			if(this.self)
			{
				this.self.getCartoon().rotation = this.CRotation;
			}
		}
		
		/** 包含的AvatarProxy发生了变更 */
		override protected function partChanged():void
		{
			super.partChanged();
			self.getCartoon().y = -ABOVE_FLOOR;
			handleCRotation();
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
			//this.changeEffectLook("fireline");
		}
		
		/** __actionOnceDone */
		private function __actionOnceDone(e:AvatarEvent):void
		{
			if(this.playOnce)
			{
				this.removeEventListener(AvatarEvent.ACTION_ONCE_DONE, __actionOnceDone);
				this.remove();
			}
		}
		
		/** 技能特效飞行[仅限同一地图场景] */
		public function fly(toX:int, toY:int, duration:int):void
		{	
			var fromPX:int = this.x;
			var fromPY:int = this.y;
			var toPX:int = MapFacade.getInstance().getPixelX(toX);
			var toPY:int = MapFacade.getInstance().getPixelY(toY);
			
			this.self.getCartoon().rotation = Math.atan2(toPY-fromPY, toPX-fromPX) * 180 / Math.PI;
			
			TweenMax.to(this, duration/1000, {x:toPX, y:toPY, onComplete: __flyOver});
		}
		
		/** 飞到目标点 */
		private function __flyOver():void
		{
			this.remove();
		}
		
		private var flyFollower:EffectFlyFollow;
		/** 技能跟踪飞行[仅限同一地图场景] */
		public function flyWith(follow:SpriteAvt, duration:int):void
		{
			if(flyFollower) { flyFollower.dispose(); }
			flyFollower = new EffectFlyFollow();
			flyFollower.start(this, follow, duration);
		}
		
		/** 取消飞行跟踪 */
		public function cancelFlyWith():void
		{
			if(flyFollower) { flyFollower.dispose(); }
		}
		
	}
}