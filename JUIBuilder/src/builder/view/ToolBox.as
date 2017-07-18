package builder.view
{
	import builder.Builder;
	import builder.view.base.BFrame;
	import builder.view.base.CrystalBtn;
	import builder.view.radio.RadioGroupEditor;
	import builder.view.tab.TabPairEditor;
	import builder.view.template.TemplateEditor;
	
	import flash.events.MouseEvent;

	public class ToolBox extends BFrame
	{
		private static var _instance:ToolBox;
		public static function get instance():ToolBox
		{
			if(_instance == null) { _instance = new ToolBox(); }
			return _instance;
		}
		
		override public function get W():int
		{
			return 120;
		}
		
		override public function get H():int
		{
			return 140;
		}
		
		private var radioGroupBtn:CrystalBtn;
		private var tabPairBtn:CrystalBtn;
		private var templateBtn:CrystalBtn;
		
		public function ToolBox()
		{
			super();
		}
		
		override protected function createParts():void
		{
			super.createParts();
			
			radioGroupBtn = new CrystalBtn("RadioGroup", __radioGroupBtn, 100, 25);
			radioGroupBtn.move(10, 10);
			this.addChild(radioGroupBtn);
			
			tabPairBtn = new CrystalBtn("TabPair", __tabPairBtnBtn, 100, 25);
			tabPairBtn.move(10, 40);
			this.addChild(tabPairBtn);
			
			templateBtn = new CrystalBtn("Templates", __templateBtn, 100, 25);
			templateBtn.move(10, 70);
			this.addChild(templateBtn);
		}
		
		private function __radioGroupBtn(e:MouseEvent):void
		{
			RadioGroupEditor.instance.show();
		}
		
		private function __tabPairBtnBtn(e:MouseEvent):void
		{
			TabPairEditor.instance.show();
		}
		
		private function __templateBtn(e:MouseEvent):void
		{
			TemplateEditor.instance.show();
		}
		
	}
}