package comm.component.data
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.buff.BuffSet;
	import comm.component.player.AttriSet;
	import comm.component.skill.SkillSet;
	import comm.struct.buff.StBuffSet;
	import comm.struct.skill.StSkillSet;
	
	import flash.utils.ByteArray;
	
	/** 结构对应Server的Creature.java */
	public class CreatureData extends SpriteData
	{
		/** 是否存活 */
		public var alive:Boolean;
		/** 名字 */
		public var name:String;
		/** 性别 */
		public var sex:int;
		/** 职业 */
		public var voc:int;
		/** 等级 */
		public var level:int;
		
		/** 生物属性 */
		public var attris:AttriSet = new AttriSet();
		/** 技能信息 */
		public var skills:SkillSet = new SkillSet();
		/** Buff组 */
		public var buffs:BuffSet = new BuffSet();
		
		public function CreatureData()
		{
			super();
		}
		
		override public function read(bytes:ByteArray):void
		{
			super.read(bytes);
			
			alive = EndianFacade.readBoolean(bytes);
			name = EndianFacade.readMultiByte(bytes);
			sex = EndianFacade.readByte(bytes);
			voc = EndianFacade.readByte(bytes);
			level = EndianFacade.readInt(bytes);
			
			attris.read(bytes);
			skills.importData(new StSkillSet().read(bytes));
			buffs.importData(new StBuffSet().read(bytes));
		}
	}
}