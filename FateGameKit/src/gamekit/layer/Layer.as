package gamekit.layer
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import gamekit.GameScene;
	import gamekit.avatar.material.AvatarLayer;
	import gamekit.map.MapFacade;
	import gamekit.map.material.MapLayer;

	public class Layer
	{
		/** loading层 */
		public static const loading:LoadingLayer = new LoadingLayer();
		/** alert层 */
		public static const alert:AlertLayer = new AlertLayer();
		/** UI层 */
		public static const ui:UILayer = new UILayer();
		/** 前景层 */
		public static const foreground:ForegroundLayer = new ForegroundLayer();
		/** avatar层 */
		public static const avatar:AvatarLayer = new AvatarLayer();
		/** 背景层 */
		public static const background:BackgroundLayer = new BackgroundLayer();
		/** 地图层 */
		public static const map:MapLayer = new MapLayer();
		
		public function Layer()
		{
		}
		
		public static function setup(stage:Stage):void
		{
			stage.addChild(GameScene.getInstance());
			GameScene.getInstance().addChild(map);
			GameScene.getInstance().addChild(background);
			GameScene.getInstance().addChild(avatar);
			GameScene.getInstance().addChild(foreground);
			stage.addChild(ui);
			stage.addChild(alert);
			stage.addChild(loading);
		}
		
	}
}