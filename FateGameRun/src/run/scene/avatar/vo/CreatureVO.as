package run.scene.avatar.vo
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.component.buff.BuffSet;
	import comm.component.player.AttriSet;
	import comm.struct.buff.StBuffSet;
	
	import flash.utils.ByteArray;
	
	/** Creature Visual Object */
	public class CreatureVO extends SpriteVO
	{
		/** 是否存活 */
		public var alive:Boolean = true;
		/** 名字 */
		public var name:String;
		/** 性别 */
		public var sex:int;
		/** 职业 */
		public var voc:int;
		/** 等级 */
		public var level:int;
		
		/** 属性集 */
		public var attris:AttriSet = new AttriSet();
		/** buff集 */
		public var buffs:BuffSet = new BuffSet();
		
		public function CreatureVO()
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
			
			buffs.importData(new StBuffSet().read(bytes));
		}
	}
}