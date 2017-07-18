package run.scene.avatar
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import comm.define.SpriteType;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.ByteArray;

	public class DoorAvt extends SpriteAvt
	{
		public function DoorAvt()
		{
			super();
			this.mouseEnabled = false;
		}
		
		/** 构造部件 */
		override protected function createParts():void
		{
			super.createParts();
			//
			//debug();
		}
		
		private function debug():void
		{
			var sp:Shape = new Shape();
			sp.graphics.beginFill(0xff0000, 0.8);
			sp.graphics.drawRect(-20, 20, 20, 20);
			sp.graphics.endFill();
			this.addChild(sp);
		}
		
		/** 根据最新的VO进行更新 */
		override public function update():void
		{
			super.update();
			this.changeSceneEffect("door");
		}
		
	}
}