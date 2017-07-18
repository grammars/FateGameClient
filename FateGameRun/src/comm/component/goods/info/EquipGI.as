package comm.component.goods.info
{
	import cfg.GoodsEquipCfg;
	
	import comm.component.goods.GoodsInfo;
	
	import flash.utils.ByteArray;
	
	public class EquipGI extends GoodsInfo
	{
		public var equipCfg:GoodsEquipCfg;
		
		/** {该装备提供的}生命值 */
		public function hp():int { return ( equipCfg.baseHp ); }
		/** {该装备提供的}魔法值 */
		public function mp():int { return ( equipCfg.baseMp ); }
		
		/** {该装备提供的}移动速度 */
		public function moveSpeed():int { return ( equipCfg.baseMoveSpeed ); }
		
		/** {该装备提供的}攻击力 */
		public function attack():int { return ( equipCfg.baseAttack ); }
		/** {该装备提供的}攻击速度 */
		public function attackSpeed():Number { return ( equipCfg.baseAttackSpeed ); }
		/** {该装备提供的}护甲值 */
		public function armor():int { return ( equipCfg.baseArmor ); }
		/** {该装备提供的}护甲穿透 */
		public function armorPene():int { return ( equipCfg.baseArmorPene ); }
		
		/** {该装备提供的}法术强度 */
		public function spellPower():int { return ( equipCfg.baseSpellPower ); }
		/** {该装备提供的}法术免疫 */
		public function spellImmun():int { return ( equipCfg.baseSpellImmun ); }
		/** {该装备提供的}法术穿透 */
		public function spellPene():int { return ( equipCfg.baseSpellPene ); }
		
		override public function available():Boolean
		{
			if(super.available() == false) { return false; }
			if(equipCfg == null) { return false; }
			return true;
		}
		
		public function EquipGI()
		{
			super();
		}
		
		override protected function build():void
		{
			super.build();
			equipCfg = GoodsEquipCfg.get(baseCfgId);
		}
		
		override protected function readHandler(bytes:ByteArray):void
		{
			
		}
		
		override protected function copyHandler(source:GoodsInfo):void
		{
			
		}
		
	}
}