package run.fight
{
	import central.Game;
	
	import cfg.MonsterInfoCfg;
	import cfg.MonsterPoolCfg;
	
	import run.scene.avatar.action.Traveller;
	
	public class MonsterVisit extends Traveller
	{
		/** 想要去击杀的怪物的配置 */
		private var mic:MonsterInfoCfg;
		/** 怪物池配置 */
		private var mpc:MonsterPoolCfg;
		
		public function MonsterVisit()
		{
			super();
		}
		
		public function visit(monsterId:int):void
		{
			mic = MonsterInfoCfg.get(monsterId);
			mpc = MonsterPoolCfg.getForMonster(monsterId);
			if(!mpc)
			{
				Game.info.notice("不存在这个想要去打败的怪物唉");
				return;
			}
			execute(mpc.mapId, mpc.mapX, mpc.mapY);
		}
		
		override protected function reached():void
		{
			if(!mic)
			{
				cancel();
				return;
			}
			Game.info.notice("寻找附近的怪物进行攻击");
			cancel();
		}
	}
}