package run.scene.avatar.vo
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.struct.skill.StSkillItem;
	
	import flash.utils.ByteArray;

	public class AoeSkillVO extends SpriteVO
	{
		/** 造成Aoe的技能id */
		public var skillId:int;
		
		public function AoeSkillVO()
		{
			super();
		}
		
		override public function read(bytes:ByteArray):void
		{
			super.read(bytes);
			
			skillId = EndianFacade.readInt(bytes);
		}
	}
}