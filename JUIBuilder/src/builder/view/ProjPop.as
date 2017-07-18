package builder.view
{
	import builder.Builder;
	import builder.ProjManager;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalInput;
	import builder.view.base.CrystalLabel;
	import builder.view.base.Popup;
	import builder.view.proj.ProjCfg;
	
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.skin.JComboBoxSkin;
	
	import flash.events.MouseEvent;
	
	public class ProjPop extends Popup
	{
		private static var _instance:ProjPop;
		public static function get instance():ProjPop
		{
			if(_instance == null) { _instance = new ProjPop(); }
			return _instance;
		}
		
		private var createInput:CrystalInput;
		private var createBtn:CrystalBtn;
		
		private var openLabel:CrystalLabel;
		private var projDrop:JComboBox;
		private var openBtn:CrystalBtn;
		
		public function ProjPop()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.normalBtn.enabled = false;
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			
			createInput = new CrystalInput("default", 210, 25);
			createInput.move(30, 50);
			this.addChild(createInput);
			
			createBtn = new CrystalBtn("创建项目", __createBtn, 100, 25);
			createBtn.move(260, 50);
			this.addChild(createBtn);
			
			openLabel = new CrystalLabel("打开项目:", 100, 25);
			openLabel.move(30, 100);
			this.addChild(openLabel);
			
			projDrop = new JComboBox("请选择一个项目", []);
			new JComboBoxSkin().apply(projDrop);
			projDrop.labelButton.label.textFormat.color = Builder.LAKE_BLUE;
			projDrop.width = 200;
			projDrop.move(130, 100);
			this.addChild(projDrop);
			
			openBtn = new CrystalBtn("打开项目", __openBtn, 300, 25);
			openBtn.move(50, 140);
			this.addChild(openBtn);
			
			setSize(400, 200);
			setTitle("项目操作");
		}
		
		private function __createBtn(e:MouseEvent):void	
		{
			var projName:String = createInput.text;
			ProjManager.create(projName);
			hide();
		}
		
		/** 更新项目配置项 */
		public function updateProjItems():void
		{
			var items:Array = [];
			for(var i:int = 0; i < ProjManager.cfgs.length; i++)
			{
				var cfg:ProjCfg = ProjManager.cfgs[i];
				items.push(cfg.projName);
			}
			projDrop.items = items;
		}
		
		/** 打开项目 */
		private function __openBtn(e:MouseEvent):void
		{
			var projName:String = projDrop.selectedItem as String;
			ProjManager.open(projName);
		}
		
	}
}