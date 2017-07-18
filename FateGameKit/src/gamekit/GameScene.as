package gamekit
{
	import flash.display.Sprite;
	
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.map.MapFacade;
	
	public class GameScene extends Sprite
	{
		private static var instance:GameScene;
		public static function getInstance():GameScene
		{
			if(instance == null) { instance = new GameScene(); }
			return instance;
		}
		
		public function GameScene()
		{
			super();
			if(instance != null)
			{
				throw new Error("GameScene is singleton");
			}
		}
		
		public function focus(fx:Number, fy:Number):void
		{
			var tx:Number = -fx;
			var ty:Number = -fy;
			if(tx > 0) { tx = 0; }
			else if(tx < -MapFacade.getInstance().curMapWidth+FateGameKit.STAGE.stageWidth)
			{ tx = -MapFacade.getInstance().curMapWidth+FateGameKit.STAGE.stageWidth; }
			if(ty > 0) { ty = 0; }
			else if(ty < -MapFacade.getInstance().curMapHeight+FateGameKit.STAGE.stageHeight)
			{ ty = -MapFacade.getInstance().curMapHeight+FateGameKit.STAGE.stageHeight; }
			
			this.x = Math.round(tx);
			this.y = Math.round(ty);
		}
		
		public function focusTarget(tar:AvatarDisplay):void
		{
			var fx:Number = tar.x - FateGameKit.STAGE.stageWidth/2;
			var fy:Number = tar.y - FateGameKit.STAGE.stageHeight/2;
			focus(fx, fy);
		}
		
	}
}