package run.scene.avatar
{
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.L;
	
	import comm.define.SpriteType;
	
	import flash.utils.ByteArray;
	
	import gamekit.FateGameKit;
	import gamekit.avatar.material.AvatarDisplay;
	
	public class PlayerAvt extends CreatureAvt
	{
		public function PlayerAvt()
		{
			super();
		}
		
		/** 构造部件 */
		override protected function createParts():void
		{
			super.createParts();
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
//			this.changeSelfLook("0001", true);
//			this.changeWeaponLook("0000", true);
//			this.changeHorseLook("1001");
			this.changeSelfLook(spriteVO.look);
			this.changeWeaponLook(playerVO.weaponLook);
		}
		
		override public function heroDo():void
		{
			Game.fight.tryHit();
		}
		
	}
}