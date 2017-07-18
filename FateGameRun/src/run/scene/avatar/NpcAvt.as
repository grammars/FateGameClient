package run.scene.avatar
{
	import central.Centre;
	import central.Game;
	
	import comm.define.SpriteType;
	
	import flash.utils.ByteArray;
	
	import net.msg.npc.NpcMsg;

	public class NpcAvt extends CreatureAvt
	{	
		public function NpcAvt()
		{
			super();
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
			this.changeNpcLook(spriteVO.look);
		}
		
		override public function heroDo():void
		{
			Game.npc.visitNpc(this.npcVO.cfgId);
		}
		
	}
}