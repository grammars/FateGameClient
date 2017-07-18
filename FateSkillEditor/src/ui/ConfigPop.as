package ui
{
	import flash.events.MouseEvent;
	
	import ui.ctrls.CrystalBtn;
	import ui.ctrls.CrystalInput;
	import ui.ctrls.CrystalLabel;
	import ui.ctrls.Popup;
	
	public class ConfigPop extends Popup
	{
		private static var _instance:ConfigPop;
		public static function get instance():ConfigPop
		{
			if(_instance == null) { _instance = new ConfigPop(); }
			return _instance;
		}
		
		private var gridWInput:CrystalInput;
		private var gridHInput:CrystalInput;
		
		public function ConfigPop()
		{
			super();
			
			this.setSize(320, 200);
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			this.setTitle("设置");
			
			var label:CrystalLabel;
			
			label = new CrystalLabel("格子宽：", 60, 25);
			label.move(50, 50);
			this.addChild(label);
			
			gridWInput = new CrystalInput(""+Editor.gridW, 60, 25);
			gridWInput.move(120, 50);
			this.addChild(gridWInput);
			
			label = new CrystalLabel("格子高：", 60, 25);
			label.move(50, 80);
			this.addChild(label);
			
			gridHInput = new CrystalInput(""+Editor.gridH, 60, 25);
			gridHInput.move(120, 80);
			this.addChild(gridHInput);
			
			var btn:CrystalBtn = new CrystalBtn("应用格子", __applyGrid, 100, 25);
			btn.move(50, 120);
			this.addChild(btn);
			
		}
		
		
		private function __applyGrid(e:MouseEvent):void
		{
			Editor.gridW = Math.max(2, parseInt(gridWInput.text));
			Editor.gridH = Math.max(2, parseInt(gridHInput.text));
			GridsCanvas.instance.paint();
		}
		
	}
}