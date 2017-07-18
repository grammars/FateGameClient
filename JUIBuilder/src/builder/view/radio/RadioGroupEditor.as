package builder.view.radio
{
	import builder.view.base.CrystalBtn;
	import builder.view.base.CrystalInput;
	import builder.view.base.Popup;
	import builder.view.prop.rc.PropRadioButton;
	
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.doc.DocRadioGroups;
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.events.MouseEvent;
	
	public class RadioGroupEditor extends Popup
	{
		private static var _instance:RadioGroupEditor;
		public static function get instance():RadioGroupEditor
		{
			if(_instance == null) { _instance = new RadioGroupEditor(); }
			return _instance;
		}
		
		private var drops:Array = new Array();
		public function getDrops():Array { return drops; }
		private function syncDrops():void
		{
			PropRadioButton.instance.groupsUpdate();
		}
		
//		public function findGroup(name:String):JRadioGroup
//		{
//			for(var i:int = 0; i < groups.length; i++)
//			{
//				if(name == groups[i].name)
//				{
//					return groups[i];
//				}
//			}
//			return null;
//		}
		
		public function deleteGroup(name:String):void
		{
			var i:int = DocRadioGroups.instance.checkGroupIndex(name);
			if(i >= 0)
			{
				DocRadioGroups.instance.removeGroup(name);
				drops.splice(i, 1);
			}
			printGroups();
			syncDrops();
		}
		
		public function clearGroup():void
		{
			DocRadioGroups.instance.clearGroups();
			drops.length = 0;
			printGroups();
			syncDrops();
		}
		
		public function createNodes():String
		{
			var nodes:String = "";
			for(var i:int = 0; i < DocRadioGroups.instance.getGroups().length; i++)
			{
				nodes += "<group>" + DocRadioGroups.instance.getGroups()[i].name + "</group>\r";
			}
			return nodes;
		}
		
		public function parse(list:XMLList):void
		{
			for each(var groupXml:XML in list)
			{
				var name:String = groupXml;
				var group:JRadioGroup = new JRadioGroup(name);
				DocRadioGroups.instance.addGroup(group);
				drops.push(name);
			}
			printGroups();
			syncDrops();
		}
		
		/** 内容框 */
		private var main:JScrollPanel;
		
		/** groupName输入 */
		private var groupNameInput:CrystalInput;
		/** group添加按钮 */
		private var groupAddBtn:CrystalBtn;
		
		public function RadioGroupEditor()
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
			
			groupNameInput = new CrystalInput("在此输入组名", 240, 25);
			groupNameInput.move(20, 300);
			this.addChild(groupNameInput);
			
			groupAddBtn = new CrystalBtn("添加组", __groupAddBtn, 100, 25);
			groupAddBtn.move(270, 300);
			this.addChild(groupAddBtn);
			
			setSize(400, 400);
			setTitle("RadioGroupEditor");
		}
		
		private function __groupAddBtn(e:MouseEvent):void
		{
			var groupName:String = groupNameInput.text;
			if(groupName == null || BU.trim(groupName) == "")
			{
				groupNameInput.text = "组名不能为空";
				return;
			}
			if(DocRadioGroups.instance.getGroup(groupName))
			{
				groupNameInput.text = "组不能重复";
				return;
			}
			var group:JRadioGroup = new JRadioGroup(groupName);
			DocRadioGroups.instance.addGroup(group);
			drops.push(groupName);
			
			printGroups();
			syncDrops();
		}
		
		private function printGroups():void
		{
			main.clearContent();
			
			for(var i:int = 0; i < DocRadioGroups.instance.getGroups().length; i++)
			{
				var item:RadioGroupItem = new RadioGroupItem(DocRadioGroups.instance.getGroups()[i]);
				item.x = 5;
				item.y = 5 + i * item.H;
				main.addChild(item);
			}
		}
		
	}
}