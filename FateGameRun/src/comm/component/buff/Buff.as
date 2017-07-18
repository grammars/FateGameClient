package comm.component.buff
{
	import central.Game;
	
	import cfg.BuffCfg;
	
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.struct.buff.StBuff;
	
	import flash.utils.ByteArray;
	
	import run.scene.avatar.CreatureAvt;

	public class Buff extends StBuff
	{
		/** 来源对象 */
		public var source:CreatureAvt;
		/** 目标对象 */
		public var target:CreatureAvt;
		/** Buff的配置 */
		public var config:BuffCfg;
		
		public function Buff()
		{
		}
		
		private function build():void
		{
			config = BuffCfg.get(this.cfgId);
			source = Game.scene.getCreature(this.sourceTid);
			target = Game.scene.getCreature(this.targetTid);
		}
		
		/** 导入结构数据 */
		public function importData(data:StBuff):void
		{
			this.cfgId = data.cfgId;
			this.id = data.id;
			this.sourceTid = data.sourceTid;
			this.targetTid = data.targetTid;
			this.destroyTime = data.destroyTime;
			this.readyTime = data.readyTime;
			this.curRunTimes = data.curRunTimes;
			
			this.deltHp = data.deltHp;
			this.deltMp = data.deltMp;
			this.deltMoveSpeed = data.deltMoveSpeed;
			this.deltAttack = data.deltAttack;
			this.deltAttackSpeed = data.deltAttackSpeed;
			this.deltArmor = data.deltArmor;
			this.deltArmorPene = data.deltArmorPene;
			this.deltSpellPower = data.deltSpellPower;
			this.deltSpellImmun = data.deltSpellImmun;
			this.deltSpellPene = data.deltSpellPene;
			
			build();
		}
		
	}
}