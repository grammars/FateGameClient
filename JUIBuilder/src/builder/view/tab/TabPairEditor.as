package builder.view.tab
{
	import builder.view.StatusBar;
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalInput;
	import builder.view.base.CrystalLabel;
	import builder.view.base.Popup;
	
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.events.MouseEvent;
	
	public class TabPairEditor extends Popup
	{
		private static var _instance:TabPairEditor;
		public static function get instance():TabPairEditor
		{
			if(_instance == null) { _instance = new TabPairEditor(); }
			return _instance;
		}
		
		/** 内容框 */
		private var main:JScrollPanel;
		
		/** 控制者S名称输入 */
		private var STagInput:CrystalInput;
		/** 受控者M名称输入 */
		private var MTagInput:CrystalInput;
		/** 添加按钮 */
		private var pairAddBtn:CrystalBtn;
		
		private var pairs:Vector.<TabPairItem> = new Vector.<TabPairItem>();
		
		public function TabPairEditor()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.normalBtn.enabled = false;
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			
			main = new JScrollPanel();
			new JScrollPanelSkin().apply(main);
			main.setSize(350, 240);
			main.move(20, 30);
			this.addChild(main);
			
			var label:CrystalLabel;
			
			label = new CrystalLabel("控制者S的tag:", 110, 25);
			label.move(20, 300);
			this.addChild(label);
				
			STagInput = new CrystalInput("S", 260, 25);
			STagInput.move(120, 300);
			this.addChild(STagInput);
			
			label = new CrystalLabel("受控者M的tag:", 110, 25);
			label.move(20, 330);
			this.addChild(label);
			
			MTagInput = new CrystalInput("M", 260, 25);
			MTagInput.move(120, 330);
			this.addChild(MTagInput);
			
			pairAddBtn = new CrystalBtn("添加配对", __pairAddBtn, 360, 25);
			pairAddBtn.move(20, 360);
			this.addChild(pairAddBtn);
			
			setSize(400, 400);
			setTitle("TabPairEditor");
		}
		
		private function __pairAddBtn(e:MouseEvent):void
		{
			var item:TabPairItem = new TabPairItem(STagInput.text, MTagInput.text);
			addPair(item);
		}
		
		public function clearPairs():void
		{
			pairs.length = 0;
		}
		
		public function addPair(item:TabPairItem):void
		{
			if(!item.bind())
			{
				StatusBar.instance.show("不符合要求的TabPair");
				return;
			}
			main.addChild(item);
			pairs.push(item);
			putItems();
		}
		
		public function removePair(item:TabPairItem):void
		{
			for(var i:int = pairs.length-1; i >= 0; i--)
			{
				var p:TabPairItem = pairs[i];
				if(p == item)
				{
					if(item.parent) { item.parent.removeChild(item); }
					pairs.splice(i, 1);
				}
			}
			putItems();
		}
		
		private function putItems():void
		{
			for(var i:int = 0; i < pairs.length; i++)
			{
				var p:TabPairItem = pairs[i];
				p.x = 10;
				p.y = 30 * i;
			}
		}
		
		public function createNodes():String
		{
			var nodes:String = "";
			for(var i:int = 0; i < pairs.length; i++)
			{
				var item:TabPairItem = pairs[i];
				nodes += '<pair s="'+item.STag+'" m="'+item.MTag+'"/>\r';
			}
			return nodes;
		}
		
		public function parse(list:XMLList):void
		{
			for each(var pairXml:XML in list)
			{
				var STag:String = pairXml.@s;
				var MTag:String = pairXml.@m;
				var item:TabPairItem = new TabPairItem(STag, MTag);
				addPair(item);
			}
		}
		
	}
}