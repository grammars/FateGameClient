package central
{
	import comm.component.data.HeroData;
	
	import run.action.ActionRun;
	import run.buff.BuffRun;
	import run.cd.CDRun;
	import run.data.DataRun;
	import run.fight.FightRun;
	import run.goods.GoodsRun;
	import run.info.InfoRun;
	import run.login.LoginRun;
	import run.npc.NpcRun;
	import run.rebirth.RebirthRun;
	import run.scene.SceneRun;
	import run.skill.SkillRun;
	import run.task.TaskRun;

	public class Game
	{
		/** hero数据 */
		public static var hero:HeroData = new HeroData();
		
		/** action */
		public static var action:ActionRun;
		/** 登录 */
		public static var login:LoginRun;
		/** 数据 */
		public static var data:DataRun;
		/** 场景 */
		public static var scene:SceneRun;
		/** 战斗 */
		public static var fight:FightRun;
		/** 信息提示 */
		public static var info:InfoRun;
		/** 复活 */
		public static var rebirth:RebirthRun;
		/** 玩家物品（背包，装备，仓库，等） */
		public static var goods:GoodsRun;
		/** 技能 */
		public static var skill:SkillRun;
		/** Buff */
		public static var buff:BuffRun;
		/** 任务 */
		public static var task:TaskRun;
		/** npc */
		public static var npc:NpcRun;
		/** cd */
		public static var cd:CDRun;
		
		/** 根据临时id判断是否是主角 */
		public static function isHeroByTid(tid:int):Boolean
		{
			return tid == hero.tid;
		}
		
		public function Game()
		{
		}
		
		public static function startup():void
		{
			action = new ActionRun();
			login = new LoginRun();
			data = new DataRun();
			scene = new SceneRun();
			fight = new FightRun();
			info = new InfoRun();
			rebirth = new RebirthRun();
			goods = new GoodsRun();
			skill = new SkillRun();
			buff = new BuffRun();
			task = new TaskRun();
			npc = new NpcRun();
			cd = new CDRun();
			
			action.startup();
			login.startup();
			data.startup();
			scene.startup();
			fight.startup();
			info.startup();
			rebirth.startup();
			goods.startup();
			skill.startup();
			buff.startup();
			task.startup();
			npc.startup();
			cd.startup();
		}
		
	}
}