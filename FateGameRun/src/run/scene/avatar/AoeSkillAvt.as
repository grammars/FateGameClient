package run.scene.avatar
{
	import cfg.SkillCfg;
	
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.skill.SkillItem;
	import comm.define.SpriteType;
	import comm.struct.skill.StSkillItem;
	
	import flash.utils.ByteArray;
	
	import gamekit.avatar.ActionType;
	
	public class AoeSkillAvt extends SpriteAvt
	{
		
		public function AoeSkillAvt(pBornTime:Object=null)
		{
			super(pBornTime);
			this.mouseEnabled = false;
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
			
			var config:SkillCfg = SkillCfg.get(aoeSkillVO.skillId);
			this.actionSpeed.setActionTime(ActionType.EFFECT, config.extAoe.aoeEffectTime);
			this.changeSkillEffect(config.extAoe.aoeEffect);
		}
		
		
	}
}