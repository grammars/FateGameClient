package comm.struct.buff
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;

	public class StBuff
	{
		/** buff配置id */
		public var cfgId:int;
		/** 唯一id */
		public var id:int;
		/** 来源对象tid */
		public var sourceTid:int;
		/** 目标对象tid */
		public var targetTid:int;
		
		/** 当前运行次数 */
		public var curRunTimes:int;
		/** 下次待命时间 */
		public var readyTime:Long;
		/** 销毁时间 */
		public var destroyTime:Long;
		
		/** {累计改变}生命值 */
		public var deltHp:int;
		/** {累计改变}魔法值 */
		public var deltMp:int;
		/** {累计改变}移动速度 */
		public var deltMoveSpeed:int;
		/** {累计改变}攻击力 */
		public var deltAttack:int;
		/** {累计改变}攻击速度 */
		public var deltAttackSpeed:Number;
		/** {累计改变}护甲值 */
		public var deltArmor:int;
		/** {累计改变}护甲穿透 */
		public var deltArmorPene:int;
		/** {累计改变}法术强度 */
		public var deltSpellPower:int;
		/** {累计改变}法术免疫 */
		public var deltSpellImmun:int;
		/** {累计改变}法术穿透 */
		public var deltSpellPene:int;
		
		public function StBuff()
		{
		}
		
		public function read(bytes:ByteArray):void
		{
			this.cfgId = EndianFacade.readInt(bytes);
			this.id = EndianFacade.readInt(bytes);
			this.sourceTid = EndianFacade.readInt(bytes);
			this.targetTid = EndianFacade.readInt(bytes);
			this.destroyTime = EndianFacade.readLong(bytes);
			this.readyTime = EndianFacade.readLong(bytes);
			this.curRunTimes = EndianFacade.readInt(bytes);
			
			this.deltHp = EndianFacade.readInt(bytes);
			this.deltMp = EndianFacade.readInt(bytes);
			this.deltMoveSpeed = EndianFacade.readInt(bytes);
			this.deltAttack = EndianFacade.readInt(bytes);
			this.deltAttackSpeed = EndianFacade.readFloat(bytes);
			this.deltArmor = EndianFacade.readInt(bytes);
			this.deltArmorPene = EndianFacade.readInt(bytes);
			this.deltSpellPower = EndianFacade.readInt(bytes);
			this.deltSpellImmun = EndianFacade.readInt(bytes);
			this.deltSpellPene = EndianFacade.readInt(bytes);
		}
		
	}
}