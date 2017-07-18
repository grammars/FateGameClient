package run.rebirth
{
	import central.Game;
	
	import gamekit.avatar.ActionType;
	
	import net.msg.fight.FightMsg;
	
	import run.AbstractRunHandler;
	import run.scene.avatar.CreatureAvt;
	
	public class RebirthRun extends AbstractRunHandler
	{
		/** 复活方式：回城复活 */
		private static const REBIRTH_WAY_HOME:int = 0;
		/** 复活方式：原地复活 */
		private static const REBIRTH_WAY_HERE:int = 1;
		
		/** 复活结果枚举：成功 */
		private static const EC_SUCC:int = 0;
		/** 复活结果枚举：失败,未知原因 */
		private static const EC_FAIL_UNDEFINED:int = 1;
		
		public function RebirthRun()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			super.startup();
		}
		
		/** 回城复活 */
		public function rebirthHome():void
		{
			FightMsg.getInstance().sendPlayerRebirthReq_C2G(REBIRTH_WAY_HOME);
		}
		
		/** 原地复活 */
		public function rebirthHere():void
		{
			FightMsg.getInstance().sendPlayerRebirthReq_C2G(REBIRTH_WAY_HERE);
		}
		
		/** 复活结果返回 */
		public function rebirthResult(srcTid:int, errCode:int):void
		{
			const isHero:Boolean = Game.isHeroByTid(srcTid); 
			switch(errCode)
			{
			case EC_SUCC:
				var cret:CreatureAvt = Game.scene.getCreature(srcTid);
				if(cret)
				{
					cret.creatureVO.alive = true;
					cret.playAndSetAction(ActionType.STAND);
				}
				if(isHero)
				{
					Game.hero.alive = true;
					Game.data.heroAliveChanged();
					Game.info.notice("复活成功！");
				}
				break;
			case EC_FAIL_UNDEFINED:
			default:
				if(isHero)
				{
					Game.info.notice("复活失败,未知原因~.~");
				}
				break;
			}
		}
		
	}
}