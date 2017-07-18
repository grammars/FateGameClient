package builder.view.template
{
	import builder.view.base.Popup;
	import builder.view.prop.item.tpl.PITemplate;
	
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	public class TemplateBrowser extends Popup
	{
		private static var _instance:TemplateBrowser;
		public static function get instance():TemplateBrowser
		{
			if(_instance == null) { _instance = new TemplateBrowser(); }
			return _instance;
		}
		
		private var scr:JScrollPanel;
		
		public function TemplateBrowser()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.normalBtn.enabled = false;
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			
			scr = new JScrollPanel();
			new JScrollPanelSkin().apply(scr);
			scr.setSize(350, 500);
			scr.move(20, 50);
			this.addChild(scr);
			
			setSize(400, 600);
			setTitle("TemplateBrowser");
		}
		
		private var reqFrom:PITemplate;
		public function select(reqFrom:PITemplate):void
		{
			this.reqFrom = reqFrom;
			paint(reqFrom.type);
			show();
		}
		
		public function resultBack(value:String):void
		{
			reqFrom.value = value;
			hide();
		}
		
		private function paint(type:String):void
		{
			scr.clearContent();
			var infos:Vector.<TemplateInfo> = TemplatesCache.getInfos(type);
			for(var i:int = 0; i < infos.length; i++)
			{
				var item:TBItem = new TBItem(infos[i]);
				item.x = 5;
				item.y = 5 + 33 * i;
				scr.addChild(item);
			}
		}
		
	}
}


import builder.view.base.CrystalBtn;
import builder.view.base.CrystalLabel;
import builder.view.template.TemplateBrowser;
import com.anstu.jui.build.template.TemplateInfo;

import flash.display.Sprite;
import flash.events.MouseEvent;

class TBItem extends Sprite
{
	private var btn:CrystalBtn;
	
	private var info:TemplateInfo;
	
	public function TBItem(info:TemplateInfo)
	{
		this.info = info;
		btn = new CrystalBtn(info.name, __labelDClick, 340, 30);
		this.addChild(btn);
	}
	
	private function __labelDClick(e:MouseEvent):void
	{
		TemplateBrowser.instance.resultBack(this.info.name);
	}
	
}