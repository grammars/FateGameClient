package run.scene.avatar.action
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import gamekit.layer.Layer;
	import gamekit.map.MapFacade;
	import gamekit.utils.GeomUtils;
	
	import run.scene.avatar.EffectAvt;
	import run.scene.avatar.SpriteAvt;

	public class EffectFlyFollow
	{
		private var hunter:EffectAvt;
		private var prey:SpriteAvt;
		private var duration:int;
		
		private var sp:Sprite;
		private var speed:Number = 1; //一毫秒要走的像素数
		
		private var lastFrameTime:Number = 0;
		private var endTime:Number = 0;
		
		public function EffectFlyFollow()
		{
		}
		
		/** 开始追踪 */
		public function start(hunter:EffectAvt, prey:SpriteAvt, duration:int):void
		{
			this.hunter = hunter;
			this.prey = prey;
			this.duration = duration;
			
			//this.self.getCartoon().rotation = Math.atan2(toPY-fromPY, toPX-fromPX) * 180 / Math.PI;
			const nowTime:Number = new Date().time;
			endTime = nowTime + duration;
			lastFrameTime = nowTime;
			
			sp = new Sprite();
			sp.addEventListener(Event.ENTER_FRAME, __enterFrame);
			Layer.alert.addChild(sp);
		}
		
		private function __enterFrame(e:Event):void
		{
			var nowTime:Number = new Date().time;
			var passTime:Number = nowTime - lastFrameTime;
			var leftTime:Number = endTime - nowTime;
			if(leftTime <= 0)
			{
				dispose();
				return;
			}
			
			var fromPX:Number = hunter.x;
			var fromPY:Number = hunter.y;
			var toPX:Number = prey.x;
			var toPY:Number = prey.y;
			
			var distance:Number = GeomUtils.distance(fromPX, fromPY, toPX, toPY);
			speed = distance/leftTime;
			var stepDist:Number = speed * passTime;
			
			//trace("__enterFrame::(" + fromPX + "," + fromPY + ") => (" + toPX + "," + toPY + ")");
			//trace("__enterFrame::speed=" + speed + " passTime=" + passTime + " stepDist=" + stepDist);
	
			
			
			var radian:Number = 0;
//			
//			if(toPX-fromPX == 0)
//			{
//				stepX = 0;
//				stepY = stepDist;
//			}
//			else if(toPY-fromPY == 0)
//			{
//				
//			}
			var atan2R:Number = Math.atan2(toPY-fromPY, toPX-fromPX);
			var stepX:Number = Math.abs( stepDist * Math.cos(atan2R) );
			var stepY:Number = Math.abs( stepDist * Math.sin(atan2R) );
			
			//trace("atan2R=" + atan2R + " stepX=" + stepX + " stepY=" + stepY);
			
			if(toPX-fromPX < 0) { stepX = -stepX; }
			if(toPY-fromPY < 0) { stepY = -stepY; }
			hunter.x += stepX;
			hunter.y += stepY;
			
			hunter.setCRotation( atan2R*180/Math.PI );
			
			lastFrameTime = nowTime;
		}
		
		/** 释放 */
		public function dispose():void
		{
			if(sp)
			{
				if(sp.parent) { sp.parent.removeChild(sp); }
				sp.removeEventListener(Event.ENTER_FRAME, __enterFrame);
				sp = null;
			}
			if(hunter)
			{
				hunter.remove();
				hunter = null;
			}
			prey = null;
		}
		
	}
}