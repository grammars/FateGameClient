package run.data
{
	import central.Game;
	import central.View;
	
	import comm.component.data.HeroData;
	import comm.component.data.PlayerData;
	import comm.effects.EffectFilters;
	
	import gamekit.avatar.ActionType;
	import gamekit.layer.Layer;
	
	import run.AbstractRunHandler;
	import run.scene.avatar.CreatureAvt;
	import run.scene.avatar.PlayerAvt;
	
	import ui.view.heroAttri.HeroAttriFrame;
	import ui.view.heroCorner.HeroCornerPane;
	import ui.view.mapRadar.MapRadarPane;
	import ui.view.operate.OperPane;
	import ui.view.rebirth.RebirthPane;
	
	public class DataRun extends AbstractRunHandler
	{
		public function DataRun()
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
		
		/** hero数据读取完毕 */
		public function heroInit():void
		{
			Game.fight.setPkMode(Game.hero.pkMode);
			Game.skill.initSkillSet();
			View.heroCornerPane.heroInit();
			View.heroAttriFrame.heroInit();
			View.mapRadarPane.heroInit();
			heroAliveChanged();
		}
		
		/** hero被杀死了 */
		public function heroBeenKilled(killerName:String):void
		{
			RebirthPane.instance.setKiller(killerName);
			Game.hero.alive = false;
			heroAliveChanged();
			Game.scene.hero.stopMove();
			Game.scene.hero.playAndSetAction(ActionType.DIE);
		}
		
		/** hero生死变化 */
		public function heroAliveChanged():void
		{
			if(Game.hero.alive)
			{
				Layer.ui.setEnable(true);
				Layer.map.setEnable(true);
				Layer.avatar.setEnable(true);
				Layer.ui.filters = [];
				Layer.map.filters = [];
				Layer.avatar.filters = [];
				RebirthPane.instance.hide();
			}
			else
			{
				Layer.ui.setEnable(false);
				Layer.map.setEnable(false);
				Layer.avatar.setEnable(false);
				Layer.ui.filters = [EffectFilters.Grey];
				Layer.map.filters = [EffectFilters.Grey];
				Layer.avatar.filters = [EffectFilters.Grey];
				RebirthPane.instance.show();
				Game.scene.hero.playAndSetAction(ActionType.DIE);
			}
		}
		
	}
}