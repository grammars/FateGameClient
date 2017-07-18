package run.scene.avatar
{
	import flash.events.MouseEvent;

	public class HeroAvt extends PlayerAvt
	{
		public function HeroAvt()
		{
			super();
			this.isHero = true;
			this.mouseEnabled = false;
			this.name = "hero";//for debug
		}
		
		/** 构造部件 */
		override protected function createParts():void
		{
			super.createParts();
			//
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
			//changeSelfLook("0000", true);
			//changeWeaponLook("0000", true);
			//changeHorseLook("1000");
			changeSelfLook(spriteVO.look);
		}
		
		/** 实体被点到了，排除了透明部分 */
		override public function clickHandler(e:MouseEvent):void
		{
			//主角自己不必相应什么事件
		}
		
	}
}