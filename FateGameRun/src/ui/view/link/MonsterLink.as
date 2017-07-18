package ui.view.link
{
	import central.Game;
	
	import cfg.MonsterInfoCfg;
	import cfg.MonsterPoolCfg;
	
	import com.anstu.jui.controls.JLink;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.skin.font.DefaultFont;
	
	public class MonsterLink extends Sprite
	{
		private var link:JLink;
		
		private var config:MonsterInfoCfg;
		
		public function MonsterLink(monsterId:int, tagStr:String="")
		{
			super();
			config = MonsterInfoCfg.get(monsterId);
			link = new JLink(config.name+tagStr);
			link.textFormat = DefaultFont.create();
			link.textFormat.underline = true;
			link.colorDefault = 0x00ff00;
			link.colorOver = 0xffff00;
			link.colorPress = 0x00ffff;
			link.usePack = true;
			link.draw();
			this.addChild(link);
			this.addEventListener(MouseEvent.CLICK, __click);
		}
		
		public function move(px:int, py:int):void
		{
			this.x = px;
			this.y = py;
		}
		
		private function __click(e:MouseEvent):void
		{
			Game.info.notice("寻路去打击" + config.name);
			Game.fight.visitMonster(config.id);
		}
	}
}