package ui.view.link
{
	import central.Game;
	
	import cfg.NpcInfoCfg;
	
	import com.anstu.jui.controls.JLink;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.skin.font.DefaultFont;
	
	public class NpcLink extends Sprite
	{
		private var link:JLink;
		
		private var config:NpcInfoCfg;
		
		public function NpcLink(npcId:int=0)
		{
			super();
			
			link = new JLink("NPC");
			link.textFormat = DefaultFont.create();
			link.textFormat.underline = true;
			link.colorDefault = 0x00ff00;
			link.colorOver = 0xffff00;
			link.colorPress = 0x00ffff;
			this.addChild(link);
			this.addEventListener(MouseEvent.CLICK, __click);
			
			if(npcId > 0)
			{
				setup(npcId);
			}
		}
		
		public function setup(npcId:int):void
		{
			config = NpcInfoCfg.get(npcId);
			link.text = config.name;
			link.usePack = true;
			link.draw();
		}
		
		public function move(px:int, py:int):void
		{
			this.x = px;
			this.y = py;
		}
		
		private function __click(e:MouseEvent):void
		{
			Game.info.notice("寻路去找" + config.name);
			Game.npc.visitNpc(config.id);
		}
		
	}
}