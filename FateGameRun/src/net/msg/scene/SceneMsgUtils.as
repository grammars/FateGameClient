package net.msg.scene
{
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.define.SpriteType;
	
	import flash.utils.ByteArray;
	
	import run.scene.avatar.*;
	import run.scene.avatar.vo.*;

	public class SceneMsgUtils
	{
		public function SceneMsgUtils()
		{
		}
		
		public static function readSpriteVO(bytes:ByteArray):SpriteVO
		{
			var type:int = EndianFacade.readByte(bytes);
			var vo:SpriteVO;
			switch(type)
			{
			case SpriteType.PLAYER:
				vo = new PlayerVO();
				break;
			case SpriteType.NPC:
				vo = new NpcVO();
				break;
			case SpriteType.MONSTER:
				vo = new MonsterVO();
				break;
			case SpriteType.DOOR:
				vo = new DoorVO();
				break;
			case SpriteType.DROP:
				vo = new DropVO();
				break;
			case SpriteType.EFFECT:
				vo = new EffectVO();
				break;
			case SpriteType.AOE_SKILL:
				vo = new AoeSkillVO();
				break;
			case SpriteType.PATH_SKILL:
				vo = new PathSkillVO();
				break;
			default:
				Log.error("SceneMsgUtils::readSpriteVO error type=" + type);
				break;
			}
			vo.read(bytes);
			Log.debug("SceneMsgUtils.readSpriteVO " + vo);
			return vo;
		}
		
	}
}