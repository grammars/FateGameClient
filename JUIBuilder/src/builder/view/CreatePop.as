package builder.view
{
	import builder.Builder;
	import builder.view.base.Popup;
	
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.events.JBaseEvent;
	import com.anstu.jui.skin.JCheckBoxSkin;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	import flash.events.MouseEvent;
	
	public class CreatePop extends Popup
	{
		private static var _instance:CreatePop;
		public static function get instance():CreatePop
		{
			if(_instance == null) { _instance = new CreatePop(); }
			return _instance;
		}
		
		private var fileNameInput:JInputText;
		private var createBtn:JPushButton;
		
		public function CreatePop()
		{
			super();
			
			this.setSize(320, 260);
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			this.setTitle("新建文档");
			
			var fmt:JTextFormat = new JTextFormat(null,14,Builder.LAKE_BLUE);
			fmt.leading = 2;
			var label:JLabel;
			
			label = new JLabel("文档名:");
			label.textFormat = fmt;
			label.useStroke = true;
			label.setSize(60, 30);
			label.move(20, 40);
			//Builder.frameUI(label);
			this.addChild(label);
			
			fileNameInput = new JInputText("default");
			fileNameInput.textFormat = fmt;
			fileNameInput.useStroke = true;
			fileNameInput.setSize(230, 30);
			fileNameInput.move(70, 40);
			Builder.frameUI(fileNameInput);
			this.addChild(fileNameInput);
			
			label = new JLabel("ui文档创建于项目目录下。\r资源放在项目目录\\assets下。\r此文件名不包含后缀\rui模版创建于项目目录\\templates\\下");
			label.textFormat = fmt;
			label.useStroke = true;
			label.setSize(280, 80);
			label.move(20, 120);
			label.enabled = false;
			Builder.frameUI(label);
			this.addChild(label);
			
			createBtn = new JPushButton("创  建", __createBtn);
			new JPushButtonSkin().apply(createBtn);
			createBtn.label.textFormat.color = Builder.LAKE_BLUE;
			createBtn.setSize(280, 30);
			createBtn.move(20, 210);
			this.addChild(createBtn);
		}
		
		private function __createBtn(e:MouseEvent):void
		{
			if(Builder.doc != null)
			{
				const sureContent:String = "你有正在编辑的文档，确认要关闭当前的文档并新建文档吗？\r" +
					"正在编辑的文档如果没有保存过，将丢失!";
				Alert.instance.sure(doCreate, sureContent);
			}
			else
			{
				doCreate();
			}
			hide();
		}
		
		private function doCreate():void
		{
			var docName:String = fileNameInput.text;
			if(docName == "")
			{
				docName = "未命名" + int(Math.random() * 1000000);
			}
			Builder.createDoc(docName);
		}
		
	}
}