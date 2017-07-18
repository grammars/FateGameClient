package ui.view.mapRadar
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gamekit.avatar.events.AvatarEvent;
	import gamekit.map.MapFacade;
	import gamekit.map.events.MapConfigEvent;
	import gamekit.map.events.MapMonitor;
	import gamekit.map.material.MapConfig;
	
	import ui.view.ViewWnd;
	
	public class MapRadarPane extends ViewWnd
	{
		private var shrinkBtn:JCheckBox;
		private var mapNameLabel:JLabel;
		private var mapPtLabel:JLabel;
		private var welfareBtn:JPushButton;
		private var mailBtn:JPushButton;
		private var mapBtn:JPushButton;
		private var teamBtn:JPushButton;
		private var friendBtn:JPushButton;
		private var cfgBtn:JPushButton;
		private var audioBtn:JCheckBox;
		
		public function MapRadarPane()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("map_radar");
			pane = uiPack.getCtrl("main");
			shrinkBtn = uiPack.getCheckBox("shrinkBtn");
			mapNameLabel = uiPack.getLabel("mapNameLabel");
			mapPtLabel = uiPack.getLabel("mapPtLabel");
			welfareBtn = uiPack.getPushButton("welfareBtn");
			mailBtn = uiPack.getPushButton("mailBtn");
			mapBtn = uiPack.getPushButton("mapBtn");
			teamBtn = uiPack.getPushButton("teamBtn");
			friendBtn = uiPack.getPushButton("friendBtn");
			cfgBtn = uiPack.getPushButton("cfgBtn");
			audioBtn = uiPack.getCheckBox("audioBtn");
			
			pane.addEventListener(MouseEvent.CLICK, __paneClick);
			shrinkBtn.addEventListener(Event.CHANGE, __shrinkBtn);
		}
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = Centre.stage.stageWidth-pane.width-30;
				pane.y = 0;
			}
		}
		
		private function __paneClick(e:MouseEvent):void
		{
			switch(e.target)
			{
			case welfareBtn:
				Game.info.notice("welfareBtn");
				break;
			case mailBtn:
				Game.info.notice("mailBtn");
				break;
			case mapBtn:
				Game.info.notice("mapBtn");
				break;
			case teamBtn:
				Game.info.notice("teamBtn");
				break;
			case friendBtn:
				Game.info.notice("friendBtn");
				break;
			case cfgBtn:
				Game.info.notice("cfgBtn");
				break;
			case audioBtn:
				Game.info.notice("audioBtn");
				break;
			}
		}
		
		private function __shrinkBtn(e:Event):void
		{
			if(shrinkBtn.selected) { hide(); } 
			else { show(); }
		}
		
		/** heroInit */
		public function heroInit():void
		{
			MapMonitor.getInstance().addEventListener(MapConfigEvent.FULL_DONE, __mapChange);
			
			Game.scene.hero.addEventListener(AvatarEvent.WALK_STEP, __heroWalkStep);
		}
		
		private function __mapChange(e:MapConfigEvent=null):void
		{
			var mapCfg:MapConfig = MapFacade.getInstance().getCurConfig();
			mapNameLabel.text = mapCfg.getMapName();
		}
		
		private function __heroWalkStep(e:AvatarEvent=null):void
		{
			mapPtLabel.text = Game.scene.hero.getGridX() + "," + Game.scene.hero.getGridY();
		}
		
	}
}