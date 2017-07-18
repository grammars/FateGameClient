package run.fight.aoe
{
	import central.Centre;
	import central.Game;
	
	import comm.component.skill.SkillItem;
	
	import flash.events.MouseEvent;
	
	import gamekit.avatar.ActionType;
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.map.MapFacade;
	import gamekit.map.material.AStarNode;
	import gamekit.map.material.MapConfig;
	import gamekit.utils.GeomUtils;
	
	import net.msg.fight.FightMsg;
	

	public class AoeSkillHandler
	{
		private var skill:SkillItem;
		
		private var preview:AoePreview = new AoePreview();
		
		private var useDistance:Number = 1.6;
		private var fireGX:int = 0;
		private var fireGY:int = 0;
		
		public function AoeSkillHandler()
		{
		}
		
		public function setup():void
		{
		}
		
		public function useSkill(param:SkillItem):Boolean
		{
			skill = param;
			
			preview.show(skill.config.extAoe.aoePreview);
			
			return true;
		}
		
		/** 施放于<br>
		 * @param px2heroX:int 相对于hero的像素X偏移
		 * @param px2heroY:int 相对于hero的像素Y偏移 */
		public function fireOn(px2heroX:int, px2heroY:int):Boolean
		{
			var mc:MapConfig = MapFacade.getInstance().getCurConfig();
			if(mc == null) { return false; }
			Game.info.notice("施放于相对主角(" + px2heroX + "," + px2heroY + ")");
			var gfx:int = Math.round( px2heroX / mc.getGridW() );
			var gfy:int = Math.round( px2heroY / mc.getGridH() );
			
			var dist:Number = GeomUtils.distance(0, 0, gfx, gfy);
			useDistance = skill.config.useDistance;
			
			fireGX = Game.scene.hero.getGridX() + gfx;
			fireGY = Game.scene.hero.getGridY() + gfy;
			if(dist > useDistance)
			{
				var tarNode:AStarNode = mc.retrieveNonBlockNode(fireGX, fireGY, useDistance);
				if(tarNode)
				{
					Game.scene.hero.to(tarNode.ind_X, tarNode.ind_Y);
					Game.scene.hero.addEventListener(AvatarEvent.WALK_STEP, __walkStep);
				}
				else
				{
					Game.info.notice("施法距离过远!");
				}
				return false;
			}
			startFire();
			return true;
		}
		
		/** __walkStep */
		private function __walkStep(e:AvatarEvent):void
		{
			var dist:Number = GeomUtils.distance(Game.scene.hero.getGridX(), Game.scene.hero.getGridY(), fireGX, fireGY);
			if(dist <= useDistance)
			{
				Game.scene.hero.removeEventListener(AvatarEvent.WALK_STEP, __walkStep);
				Game.scene.hero.stopMove();
				Game.info.notice("当前距离" + dist + ",施放距离要求" +　useDistance);
				startFire();
			}
		}
		
		/** 开始施法 */
		private function startFire():void
		{
			Game.info.notice("开始进行AOE施法!");
			//Game.scene.hero.playAndSetAction(ActionType.MAGIC_SING);
			FightMsg.getInstance().sendPlayerSkillAoeFire_C2G(skill.id, fireGX, fireGY, Game.scene.hero.getDirection());
		}
		
	}
}