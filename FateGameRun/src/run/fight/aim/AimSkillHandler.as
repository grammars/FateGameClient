package run.fight.aim
{
	import central.Game;
	
	import cfg.SkillCfg;
	
	import comm.L;
	import comm.component.skill.SkillItem;
	
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
	
	import net.msg.IMessage;
	import net.msg.fight.FightMsg;
	
	import res.Res;
	
	import run.fight.law.FightLaw;
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.EffectAvt;
	import run.scene.avatar.MonsterAvt;

	public class AimSkillHandler
	{
		private var skill:SkillItem;
		
		/** 技能冷却时间 */
		protected var hitFreeTime:Number = 0;
		/** 过多少时间之后可以再攻击 */
		protected function hitCD():void
		{
			//hitFreeTime = Utils.timestamp() + skill.config.cdTime;
		}
		/** 是否可以使用技能，即完成技能冷却 */
		protected function isHitFree():Boolean
		{
			//return Utils.timestamp()-hitFreeTime>-100;
			return true;
		}
		
		private var hitPreTag:uint = 0;
		/** 接下来技能预备 */
		public function nextHitPre():void
		{
			cancelNextHitPre();
			hitPreTag = setTimeout(useSkill, skill.config.cdTime, skill);
		}
		/** 取消接下来技能预备 */
		private function cancelNextHitPre():void
		{
			clearInterval(hitPreTag);
		}
		//
		private var hitExeTag:uint = 0;
		/** 接下来技能结算 */
		public function nextHitExe():void
		{
			//cancelNextHitExe();
			//
			var afterTime:int = getHitCostTime();
			hitExeTag = setTimeout(hitExecute, afterTime);
		}
		/** 取消接下来技能结算 */
		private function cancelNextHitExe():void
		{
			clearInterval(hitExeTag);
		}
		
		private function getHitCostTime():int
		{
			var costTime:int = 0;
			const hitCdTime:int = skill.config.cdTime;
			const stdTime:int = AvatarRule.getStdPlayTimeByAction(ActionType.MAGIC_SING);
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
		
		public function AimSkillHandler()
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
			killUse();
		}
		
		public function killUse():void
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
				useSkill(skill);
			}
		}
		
		public function useSkill(param:SkillItem):Boolean
		{
			skill = param;
			
			needWaitStop = false;
			if(!Game.hero.alive) { return false; }
			//trace("尝试技能");
			
			const isAimSelf:Boolean = skill.config.extAim.aimSelf;
			
			var target:CreatureAvt;
			
			if(isAimSelf)
			{
				target = Game.scene.hero;
			}
			else
			{
				target = Game.scene.getSltTar() as CreatureAvt;
				if(!target)
				{
					var mot:AvatarDisplay = Layer.avatar.getMouseOverTarget();
					if(mot is CreatureAvt)
					{
						target = mot as CreatureAvt;
						Game.scene.setSltTar(target);
					}
				}
			}
			
			if(!target)
			{
				//trace("技能目标为空");
				return false;
			}
			
			if( !FightLaw.skillRelationAvailable(target, param) )
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
				//Game.info.notice("技能CD未到");
				return false;
			}
			
			if(!isAimSelf)
			{
				if( GeomUtils.gridDistance(Game.scene.hero, target) > skill.useDistance() )
				{
					//Game.info.notice("攻击距离太远，先走过去再说");
					Game.scene.hero.towards(target, skill.useDistance());
					needWaitStop = true;
					return false;
				}
				
				Game.scene.hero.cancelTowards();
				Game.scene.hero.stopMove();
				Game.scene.hero.faceTo(target);
			}
			
			//Game.info.notice("开始施法");
			Game.scene.hero.playAction(ActionType.MAGIC_SING, true);
			
			FightMsg.getInstance().sendPlayerSkillAimPrepare_C2G(skill, Game.scene.hero.getDirection());
			
			hitCD();
			
			nextHitExe();
			nextHitPre();
			//
			return true;
		}
		
		public function playSkillFly(userTid:int, tarIds:Array, skillId:int):void
		{
			var user:CreatureAvt = Game.scene.getCreature(userTid);
			if(!user) { return; }
			
			var skillCfg:SkillCfg = SkillCfg.get(skillId);
			
			for(var i:int = 0; i < tarIds.length; i++)
			{
				var target:CreatureAvt = Game.scene.getCreature(tarIds[i]);
				if(!target) { continue; }
				if(Res.isNull(skillCfg.extAim.aimFlyEffect)) { continue; }
				var hitFlyEff:EffectAvt = new EffectAvt();
				hitFlyEff.changeSkillEffect(skillCfg.extAim.aimFlyEffect);
				hitFlyEff.setGridX(user.getGridX());
				hitFlyEff.setGridY(user.getGridY());
				Layer.avatar.append(hitFlyEff);
				
				var gridDist:Number = GeomUtils.gridDistance(user, target);
				
				hitFlyEff.flyWith(target, gridDist*skillCfg.extAim.aimFlyGridTime);
			}
		}
		
		private function getNearCreature(target:AvatarDisplay, range:Number, maxNum:Object=null, includeHero:Boolean=false):Vector.<CreatureAvt>
		{
			var nears:Vector.<CreatureAvt> = new Vector.<CreatureAvt>();
			nears.push(target);
			var childrens:Vector.<AvatarDisplay> = Layer.avatar.getChildren();
			for(var i:int = 0; i < childrens.length; i++)
			{
				if(maxNum != null)
				{
					if(nears.length >= Number(maxNum)) { break; }
				}
				var avt:AvatarDisplay = childrens[i];
				if(avt is CreatureAvt)
				{
					var ma:CreatureAvt = avt as CreatureAvt;
					var dist:Number = GeomUtils.gridDistance(target, ma);
					if(dist <= range)
					{
						if(includeHero==false && ma.isHero==true) { continue; }
						nears.push(ma);
					}
				}
			}
			return nears;
		}
		
		private function hitExecute():void
		{
			var target:CreatureAvt;
			
			if(skill.config.extAim.aimSelf)
			{
				target = Game.scene.hero;
			}
			else
			{
				target = Game.scene.getSltTar() as CreatureAvt;
			}
			if(!target) { return; }//trace("技能结算目标为空");
			/* 之前由客户端发送所有目标对象，现在改成只发送一个选择对象目标
			var nears:Vector.<CreatureAvt> = getNearCreature(target, skill.config.extAim.aimRange, skill.config.extAim.aimMaxCount);
			
			var tarIds:Array = new Array();
			for(var i:int = 0; i < nears.length; i++)
			{
				tarIds.push(nears[i].getTid()); 
			}
			*/
			FightMsg.getInstance().sendPlayerSkillAimExecute_C2G( skill.id, target.getTid() );
		}
		
	}
}