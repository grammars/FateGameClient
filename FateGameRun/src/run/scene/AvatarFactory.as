package run.scene
{
	import comm.define.SpriteType;
	
	import run.scene.avatar.*;
	import run.scene.avatar.SpriteAvt;
	import run.scene.avatar.vo.SpriteVO;

	public class AvatarFactory
	{
		public function AvatarFactory()
		{
		}
		
		public static function create(vo:SpriteVO):SpriteAvt
		{
			var avt:SpriteAvt;
			switch(vo.type)
			{
			case SpriteType.PLAYER:
				avt = new PlayerAvt();
				break;
			case SpriteType.NPC:
				avt = new NpcAvt();
				break;
			case SpriteType.MONSTER:
				avt = new MonsterAvt();
				break;
			case SpriteType.DOOR:
				avt = new DoorAvt();
				break;
			case SpriteType.DROP:
				avt = new DropAvt();
				break;
			case SpriteType.EFFECT:
				avt = new EffectAvt(false, vo.bornTime);
				break;
			case SpriteType.AOE_SKILL:
				avt = new AoeSkillAvt(vo.bornTime);
				break;
			case SpriteType.PATH_SKILL:
				avt = new PathSkillAvt(vo.bornTime);
				break;
			}
			avt.setVO(vo);
			avt.update();
			return avt;
		}
		
	}
}