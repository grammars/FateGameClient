package run.scene.avatar
{
	import central.Centre;
	import central.Game;
	
	import comm.define.SpriteType;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import gamekit.avatar.ActionType;
	
	import test.ctrls.GameConsole;

	public class MonsterAvt extends CreatureAvt
	{
		public function MonsterAvt()
		{
			super();
			this.moveAction = ActionType.WALK;
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
			this.changeMonsterLook(spriteVO.look);
		}
		
		override public function heroDo():void
		{
			Game.fight.tryHit();
		}
		
	}
}