package net.msg.skill
{
	import central.Game;
	
	import comm.struct.skill.StSkillSet;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	
	public class SkillMsg extends IMessage
	{
		private static var instance:SkillMsg;
		public static function getInstance():SkillMsg
		{
			if(instance == null) { instance = new SkillMsg(); }
			return instance;
		}
		
		/** [技能]主消息号 */
		public static const MID:int = SKILL_MID;
		
		/** game向client发送初始化技能集 */
		private static const INIT_SKILL_SET_G2C:int = 1;
		
		public function SkillMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case INIT_SKILL_SET_G2C:
				recvInitSkillSet_G2C(bytes);
				break;
			}
		}
		
		/** recv( game向client发送初始化技能集 ) */
		private function recvInitSkillSet_G2C(bytes:ByteArray):void
		{
			var sks:StSkillSet = new StSkillSet();
			sks.read(bytes);
			Game.hero.skills.importData(sks);
			Game.skill.initSkillSet();
		}
		
	}
}