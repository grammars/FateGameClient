package builder.view.assets.oper
{
	import builder.view.Alert;
	import builder.view.assets.AssetsNode;
	import builder.view.assets.browser.AssetsBrowser;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalInput;
	import builder.view.base.CrystalLabel;
	import builder.view.base.Popup;
	
	import flash.events.MouseEvent;
	
	public class AddPackSure extends Popup
	{
		private static var _instance:AddPackSure;
		public static function get instance():AddPackSure
		{
			if(_instance == null) { _instance = new AddPackSure(); }
			return _instance;
		}
		
		private var nameLabel:CrystalLabel;
		private var nameInput:CrystalInput;
		private var addBtn:CrystalBtn;
		
		public function AddPackSure()
		{
			super();
			
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			this.setSize(400, 150);
			this.setTitle("添加包");
			
			nameLabel = new CrystalLabel("包名：", 80, 25);
			nameLabel.move(50, 50);
			this.addChild(nameLabel);
			
			nameInput = new CrystalInput("", 200, 25);
			nameInput.move(130, 50);
			this.addChild(nameInput);
			
			addBtn = new CrystalBtn("添 加", __addBtn, 300, 30);
			addBtn.move(50, 100);
			this.addChild(addBtn);
		}
		
		private function __addBtn(e:MouseEvent):void
		{
			var node:AssetsNode = new AssetsNode(true);
			node.name = nameInput.text;
			AssetsBrowser.instance.addNode(node);
		}
	}
}