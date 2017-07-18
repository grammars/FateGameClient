package ui.view.tip
{
	import central.Centre;
	
	import cfg.SkillCfg;
	
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JTitle;
	
	import comm.component.skill.SkillItem;
	import comm.define.SkillDef;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import gamekit.layer.Layer;
	
	import res.Res;
	
	import run.fight.formula.SkillCostForm;
	
	import ui.skin.font.DefaultFont;
	import ui.skin.pane.TipEasyPaneSkin;
	import ui.view.ViewWnd;
	
	public class SkillTip extends ViewWnd
	{
		private static var _instance:SkillTip;
		public static function get instance():SkillTip
		{
			if(_instance == null) { _instance = new SkillTip(); }
			return _instance;
		}
		
		private var iconCtn:JPanel;
		private var nameLabel:JTitle;
		private var typeLabel:JLabel;
		private var cdLabel:JLabel;
		private var costLabel:JLabel;
		private var tarNumLabel:JLabel;
		private var useDistLabel:JLabel;
		private var descLabel:JLabel;
		
		private var icon:Bitmap = new Bitmap();
		
		public function SkillTip()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("skill_tip");
			pane = uiPack.getCtrl("root");
			iconCtn = uiPack.getPanel("iconCtn");
			nameLabel = uiPack.getTitle("nameLabel");
			typeLabel = uiPack.getLabel("typeLabel");
			cdLabel = uiPack.getLabel("cdLabel");
			costLabel = uiPack.getLabel("costLabel");
			tarNumLabel = uiPack.getLabel("tarNumLabel");
			useDistLabel = uiPack.getLabel("useDistLabel");
			descLabel = uiPack.getLabel("descLabel");
			
			pane.mouseEnabled = pane.mouseChildren = false;
			icon.x = icon.y = 2;
			iconCtn.addChild(icon);
		}
		
		private var i:int = 0;
		/** 更新数据 */
		public function update(data:SkillItem):void
		{
			Res.fillIcon(icon, "skill/36/"+data.config.icon+".jpg");
			nameLabel.text = data.config.name;
			typeLabel.text = SkillDef.typeStr(data.config.type);
			cdLabel.text = data.config.cdTime + "ms";
			
			var costStr:String = "";
			var hpCost:int = SkillCostForm.costHp(data);
			var mpCost:int = SkillCostForm.costMp(data);
			if(hpCost > 0)
			{
				costStr += "<font color='#ffa122'>"+hpCost+"</font>hp ";
			}
			if(mpCost > 0)
			{
				costStr += "<font color='#6693fe'>"+mpCost+"</font>mp";
			}
			if(hpCost <= 0 && mpCost <= 0)
			{
				costStr = "无消耗";
			}
			costLabel.text = costStr;
			
			if(data.config.extAim)
			{
				tarNumLabel.text = data.config.extAim.aimMaxCount.toString();
			}
			else
			{
				tarNumLabel.text = "--";
			}
			
			useDistLabel.text = data.config.useDistance.toString();
			descLabel.text = data.config.desc;
		}
		
		/** 摆放到合适的位置 */
		public function put():void
		{
			pane.x = Centre.stage.mouseX + 10;
			pane.y = Centre.stage.mouseY - 240;
		}
		
	}
}