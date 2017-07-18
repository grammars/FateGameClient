package ui.view.task
{
	import cfg.GoodsBaseCfg;
	import cfg.NpcInfoCfg;
	import cfg.TaskCfg;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JLink;
	
	import comm.component.task.TaskItem;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import ui.skin.font.DefaultFont;
	import ui.view.link.MonsterLink;
	import ui.view.link.NpcLink;
	import ui.view.utils.ViewUtils;
	
	public class TaskComplexLine extends Sprite
	{
		private var info:TaskItem;
		
		private var thisHeight:int = 24;
		public function getHeight():int
		{
			return thisHeight;
		}
		
		public function TaskComplexLine()
		{
			super();
		}
		
		public function present(info:TaskItem):void
		{
			this.info = info;
			ViewUtils.clearContent(this);
			switch(info.config.actType)
			{
			case TaskCfg.ACT_NULL:
				break;
			case TaskCfg.ACT_TALK_NPC:
				build4TalkNpc();
				thisHeight = 24;
				break;
			case TaskCfg.ACT_KILL_MONSTER:
				build4KillMonster();
				thisHeight = 24;
				break;
			case TaskCfg.ACT_COLLECT:
				build4Collect();
				thisHeight = 24;
				break;
			case TaskCfg.ACT_PASS_ZONE:
				build4PassZone();
				thisHeight = 24;
				break;
			}
		}
		
		private function build4TalkNpc():void
		{
			var pos:Point = new Point();
			var lab:JLabel;
			lab = ViewUtils.label("寻找",false,0xfeecbf);
			lab.move(0,0);
			//lab.showFrame(true);
			this.addChild(lab);
			pos.x += lab.width - 3;
			
			var lk:NpcLink = new NpcLink(info.config.tarNpcId);
			lk.move(pos.x, pos.y);
			this.addChild(lk);
			pos.x += lk.width - 3;
			
			lab = ViewUtils.label(",你可能会有所发现",false,0xfeecbf);
			lab.move(pos.x, pos.y);
			//lab.showFrame(true);
			this.addChild(lab);
		}
		
		private function build4KillMonster():void
		{
			var pos:Point = new Point();
			var lab:JLabel;
			lab = ViewUtils.label("击败",false,0xfeecbf);
			lab.move(0,0);
			//lab.showFrame(true);
			this.addChild(lab);
			pos.x += lab.width - 3;
			
			var tagStr:String = "(" + info.killMonsterNum + "/" + info.config.tarMonsterNum + ")";
			var lk:MonsterLink = new MonsterLink(info.config.tarMonsterId, tagStr);
			lk.move(pos.x, pos.y);
			this.addChild(lk);
			pos.x += lk.width - 3;
			
			lab = ViewUtils.label(",这是你的使命",false,0xfeecbf);
			lab.move(pos.x, pos.y);
			//lab.showFrame(true);
			this.addChild(lab);
		}
		
		private function build4Collect():void
		{
			var gbc:GoodsBaseCfg = GoodsBaseCfg.get(info.config.tarGoodsId);
			var content:String = "<font color='#feecbf'>收集<font color='#fe00bf'>"+gbc.name+"</font>("
				+info.gotGoodsNum+"/"+info.config.tarGoodsNum+")个</font>";
			var lab:JLabel = ViewUtils.htmlLabel(content, true);
			lab.move(0,0);
			this.addChild(lab);
		}
		
		private function build4PassZone():void
		{
			
		}
		
	}
}