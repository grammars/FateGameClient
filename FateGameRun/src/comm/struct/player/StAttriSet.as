package comm.struct.player
{
	import flash.utils.ByteArray;

	public class StAttriSet
	{
		/** 属性源:自身 */
		public static const SRC_BASE:int = 0;
		/** 属性源:装备附加 */
		public static const SRC_EQUIP:int = 1;
		/** 属性源:技能附加 */
		public static const SRC_SKILL:int = 2;
		/** 属性源:buff附加 */
		public static const SRC_BUFF:int = 3;
		
		/** 属性现状 */
		protected var current:StAttributes = new StAttributes();
		
		/** 自身属性 */
		public var base:StAttributes = new StAttributes();
		/** 装备附加属性 */
		public var equip:StAttributes = new StAttributes();
		/** 技能附加属性 */
		public var skill:StAttributes = new StAttributes();
		/** buff附加属性 */
		public var buff:StAttributes = new StAttributes();
		
		public function StAttriSet()
		{
		}
		
		/** 从IoBuffer读出 */
		public function read(bytes:ByteArray):void
		{
			current.read(bytes);
			base.read(bytes);
			equip.read(bytes);
			skill.read(bytes);
			buff.read(bytes);
		}
		
		/** clone */
		public function clone(vo:StAttriSet):void
		{
			this.current.clone(vo.current);
			this.base.clone(vo.base);
			this.equip.clone(vo.equip);
			this.skill.clone(vo.skill);
			this.buff.clone(vo.buff);
		}
		
		/** toString */
		public function toString():String
		{
			return "[StAttriSet] current=" + current + " base=" + base + 
				" equip=" + equip + " skill=" + skill + " buff=" + buff;
		}
		
	}
}