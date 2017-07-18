package run.fight.normal
{
	import central.Game;
	
	import cfg.VocCfg;
	
	import comm.L;
	
	import flash.utils.clearInterval;
	import flash.utils.setTimeout;
	
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarRule;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.layer.Layer;
	import gamekit.map.events.MapEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.utils.GeomUtils;
	import gamekit.utils.Utils;
	
	import net.msg.fight.FightMsg;
	
	import run.fight.law.FightLaw;
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.EffectAvt;

	public class NormalHitHandler
	{
		/** 普攻冷却时间 */
		protected var hitFreeTime:Number = 0;
		/** 过多少时间之后可以再攻击 */
		protected function hitCD():void
		{
			var afterTime:Number = 1000 / Game.hero.attris.attackSpeed();
			hitFreeTime = Utils.timestamp() + afterTime;
		}
		/** 是否可以进行普通，即完成普攻冷却 */
		protected function isHitFree():Boolean
		{
			return Utils.timestamp()-hitFreeTime>-100;
		}
		
		private var hitPreTag:uint = 0;
		/** 接下来普攻预备 */
		public function nextHitPre():void
		{
			cancelNextHitPre();
			hitPreTag = setTimeout(tryHit, 1000/Game.hero.attris.attackSpeed());
		}
		/** 取消接下来普攻预备 */
		private function cancelNextHitPre():void
		{
			clearInterval(hitPreTag);
		}
		//
		private var hitExeTag:uint = 0;
		/** 接下来普攻结算 */
		public function nextHitExe():void
		{
			//cancelNextHitExe();
			//
			var afterTime:int = getHitCostTime();
			hitExeTag = setTimeout(hitExecute, afterTime);
		}
		/** 取消接下来普攻结算 */
		private function cancelNextHitExe():void
		{
			clearInterval(hitExeTag);
		}
		
		private function getHitCostTime():int
		{
			var costTime:int = 0;
			const hitCdTime:int = 1000/Game.hero.attris.attackSpeed();
			const stdTime:int = AvatarRule.getStdPlayTimeByAction(ActionType.HIT);
			if(hitCdTime > stdTime)
			{
				costTime = stdTime;
			}
			else
			{
				costTime = hitCdTime;
			}
			return costTime;
		}
		
		public function NormalHitHandler()
		{
		}
		
		public function setup():void
		{
			MapMonitor.getInstance().addEventListener(MapEvent.CLICK, __mapLayerClick);
			Game.scene.hero.addEventListener(AvatarEvent.WALK_STOP, __heroWalkStop);
		}
		
		
		/** 地图层被点击 */
		private function __mapLayerClick(e:MapEvent):void
		{
			cancelNextHitExe();
			cancelNextHitPre();
			Game.scene.hero.towards(null);
			needWaitStop = false;
		}
		
		/** 是否有必要监听主角止步 */
		private var needWaitStop:Boolean = false;
		/** __heroWalkStop */
		private function __heroWalkStop(e:AvatarEvent):void
		{
			if(needWaitStop == true)
			{
				tryHit();
			}
		}
		
		/** 尝试普通攻击
		 * (只是尝试，可能因为距离不够而本次尝试失败) */
		public function tryHit():Boolean
		{
			needWaitStop = false;
			if(!Game.hero.alive) { return false; }
			//trace("尝试攻击");
			var target:CreatureAvt = Game.scene.getSltTar() as CreatureAvt;
			if(!target)
			{
				var mot:AvatarDisplay = Layer.avatar.getMouseOverTarget();
				if(mot is CreatureAvt)
				{
					target = mot as CreatureAvt;
					Game.scene.setSltTar(target);
				}
			}
			if(!target)
			{
				//trace("普攻预备目标为空");
				return false;
			}
			
			if(!FightLaw.hitRelationAvailable(target))
			{
				return false;
			}
			
			if(!target.getAlive())
			{
				Game.info.notice(L.T("目标已经死亡"));
				return false;
			}
			if(!isHitFree())
			{
				Game.info.notice("普攻CD未到");
				return false;
			}
			
			var vocCfg:VocCfg = VocCfg.get(Game.hero.voc);
			
			if( GeomUtils.gridDistance(Game.scene.hero, target) > vocCfg.hitDistance )
			{
				Game.info.notice("攻击距离太远，先走过去再说");
				Game.scene.hero.towards(target, vocCfg.hitDistance);
				needWaitStop = true;
				return false;
			}
			
			Game.scene.hero.cancelTowards();
			Game.scene.hero.stopMove();
			Game.scene.hero.faceTo(target);
			
			Game.info.notice("开始打击");
			Game.scene.hero.playAction(ActionType.HIT, true);
			
			FightMsg.getInstance().sendPlayerHitPrepare_C2G(target.getTid(), Game.scene.hero.getDirection());
			
			hitCD();
			
			nextHitExe();
			nextHitPre();
			return true;
		}
		
		public function playHitFly(attackerId:int, targetId:int):void
		{
			var attacker:CreatureAvt = Game.scene.getCreature(attackerId);
			if(!attacker) { return; }
			var target:CreatureAvt = Game.scene.getCreature(targetId);
			if(!target) { return; }
			
			var vocCfg:VocCfg = VocCfg.get(Game.hero.voc);
			if(!vocCfg) { return; }
			if(!vocCfg.isRemoteHit) { return; }
			
			var hitFlyEff:EffectAvt = new EffectAvt();
			hitFlyEff.changeSkillEffect(vocCfg.hitFlyEffect);
			hitFlyEff.setGridX(attacker.getGridX());
			hitFlyEff.setGridY(attacker.getGridY());
			Layer.avatar.append(hitFlyEff);
			hitFlyEff.flyWith(target, vocCfg.hitFlyTime);
		}
		
		private function hitExecute():void
		{
			var target:CreatureAvt = Game.scene.getSltTar() as CreatureAvt;
			if(!target)
			{
				//trace("普攻结算目标为空");
				return;
			}
			FightMsg.getInstance().sendPlayerHitExecute_C2G(target.getTid());
		}
		
	}
}