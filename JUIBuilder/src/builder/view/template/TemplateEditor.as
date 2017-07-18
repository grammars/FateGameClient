package builder.view.template
{
	import builder.Builder;
	import builder.view.base.CrystalBtn;
	import builder.view.base.Popup;
	import builder.view.prop.item.PIBaseText;
	import builder.view.prop.item.PIButton;
	import builder.view.prop.item.PIScrollBar;
	import builder.view.prop.item.PITitle;
	import builder.view.template.rc.TempLabel;
	import builder.view.template.rc.TempPushButton;
	import builder.view.template.rc.TempScrollBarH;
	import builder.view.template.rc.TempScrollBarV;
	import builder.view.template.rc.TempTitle;
	
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;
	import com.anstu.jui.skin.JComboBoxSkin;
	
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class TemplateEditor extends Popup
	{
		private static var _instance:TemplateEditor;
		public static function get instance():TemplateEditor
		{
			if(_instance == null) { _instance = new TemplateEditor(); }
			return _instance;
		}
		
		private var typeChooser:JComboBox;
		private var createBtn:CrystalBtn;
		private var openBtn:CrystalBtn;
		private var saveBtn:CrystalBtn;
		
		private var curEditor:TempBase;
		
		public function TemplateEditor()
		{
			super();
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			this.normalBtn.enabled = false;
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			
			var types:Array = [JuiType.JLabel, JuiType.JTitle, JuiType.JPushButton,
				JuiType.JScrollBarH, JuiType.JScrollBarV];
			typeChooser = new JComboBox("请选择一个控件作为模版", types);
			new JComboBoxSkin().apply(typeChooser);
			typeChooser.labelButton.label.textFormat.color = Builder.LAKE_BLUE;
			typeChooser.width = 200;
			typeChooser.move(30, 50);
			this.addChild(typeChooser);
			
			createBtn = new CrystalBtn("创建模版", __createBtn, 80, 25);
			createBtn.move(250, 50);
			this.addChild(createBtn);
			
			openBtn = new CrystalBtn("打开模版", __openBtn, 80, 25);
			openBtn.move(350, 50);
			this.addChild(openBtn);
			
			saveBtn = new CrystalBtn("保存模版", __saveBtn, 80, 25);
			saveBtn.move(450, 50);
			this.addChild(saveBtn);
			
			const rcX:int = 30;
			const rcY:int = 75;
			TempLabel.instance.move(rcX, rcY);
			TempTitle.instance.move(rcX, rcY);
			TempPushButton.instance.move(rcX, rcY);
			TempScrollBarH.instance.move(rcX, rcY);
			TempScrollBarV.instance.move(rcX, rcY);
			
			this.addChild(TempLabel.instance);
			this.addChild(TempTitle.instance);
			this.addChild(TempPushButton.instance);
			this.addChild(TempScrollBarH.instance);
			this.addChild(TempScrollBarV.instance);
			
			turnOffAll();
			
			setSize(800, 600);
			setTitle("TemplateEditor");
		}
		
		private function clean():void
		{
			
		}
		
		private function turnOffAll():void
		{
			TempLabel.instance.visible = false;
			TempTitle.instance.visible = false;
			TempPushButton.instance.visible = false;
			TempScrollBarH.instance.visible = false;
			TempScrollBarV.instance.visible = false;
		}
		
		private function turnOn(uiType:String):void
		{
			turnOffAll();
			switch(uiType)
			{
			case JuiType.JLabel:
				curEditor = TempLabel.instance;
				break;
			case JuiType.JTitle:
				curEditor = TempTitle.instance;
				break;
			case JuiType.JPushButton:
				curEditor = TempPushButton.instance;
				break;
			case JuiType.JScrollBarH:
				curEditor = TempScrollBarH.instance;
				break;
			case JuiType.JScrollBarV:
				curEditor = TempScrollBarV.instance;
				break;
			default:
				curEditor = null;
				break;
			}
			if(curEditor)
			{
				curEditor.visible = true;
			}
		}
		
		private function __createBtn(e:MouseEvent):void
		{
			clean();
			var type:String = String(typeChooser.selectedItem);
			turnOn(type);
		}
		
		private function __openBtn(e:MouseEvent):void
		{
			clean();
			TemplateOpenWnd.instance.show();
		}

		private function __saveBtn(e:MouseEvent):void
		{
			clean();
			if(curEditor)
			{
				curEditor.save();
				loadTemplates();
			}
		}
		
		/** 加载模版 */
		public function loadTemplates():void
		{
			TemplatesCache.clearInfos();
			
			var templatesDir:File = new File(Builder.templatesDirFull());
			var arr:Array = templatesDir.getDirectoryListing();
			for(var i:int = 0; i < arr.length; i++)
			{
				var file:File = arr[i];
				if(false == file.isDirectory && file.extension==Builder.EXT)
				{
					var fs:FileStream = new FileStream();
					fs.open(file, FileMode.READ);
					var content:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
					//trace("content=" + content);
					var name:String = file.name.replace("."+Builder.EXT, "");
					
					var ti:TemplateInfo = TemplatesCache.parse(name, content);
					TemplatesCache.putInfo(ti);
				}
			}
		}
		
		/** 解析模版内容 */
		public function parseTemplate(content:String, fileName:String):void
		{
			var xml:XML = XML(content);
			var type:String = xml.name();
			//trace("模版类型" + type);
			switch(type)
			{
			case JuiType.JLabel:
				recoverTempLabel(xml, fileName);
				break;
			case JuiType.JTitle:
				recoverTempTitle(xml, fileName);
				break;
			case JuiType.JPushButton:
				recoverTempPushButton(xml, fileName);
				break;
			case JuiType.JScrollBarH:
				recoverTempScrollBar(xml, fileName, JuiType.JScrollBarH);
				break;
			case JuiType.JScrollBarV:
				recoverTempScrollBar(xml, fileName, JuiType.JScrollBarV);
				break;
			default:
				break;
			}

		}
		
		private function recoverTempLabel(xml:XML, fileName:String):void
		{
			var edit:PIBaseText = TempLabel.instance.edit;
			if(xml["@align"] != undefined) edit.setAlign( xml["@align"] );
			if(xml["@valign"] != undefined) edit.setValign( xml["@valign"] );
			if(xml["@autoWrap"] != undefined) edit.setAutoWrap( xml["@autoWrap"] );
			if(xml["@useStroke"] != undefined) edit.setUseStroke( xml["@useStroke"] );
			if(xml["@strokeColor"] != undefined) edit.setStrokeColor( xml["@strokeColor"] );
			if(xml["@strokeBlur"] != undefined) edit.setStrokeBlur( xml["@strokeBlur"] );
			if(xml["@strokeStrength"] != undefined) edit.setStrokeStrength( xml["@strokeStrength"] );
			if(xml["@useHtml"] != undefined) edit.setUseHtml( xml["@useHtml"] );
			if(xml["@font"] != undefined) edit.setFont( xml["@font"] );
			if(xml["@size"] != undefined) edit.setSize( xml["@size"] );
			if(xml["@color"] != undefined) edit.setColor( xml["@color"] );
			if(xml["@bold"] != undefined) edit.setBold( xml["@bold"] );
			if(xml["@italic"] != undefined) edit.setItalic( xml["@italic"] );
			if(xml["@underline"] != undefined) edit.setUnderline( xml["@underline"] );
			
			TempLabel.instance.apply();
			TempLabel.instance.setFileName(fileName);
			turnOn(JuiType.JLabel);
		}
		
		private function recoverTempTitle(xml:XML, fileName:String):void
		{
			var edit:PITitle = TempTitle.instance.edit;
			if(xml["@gradBeg"] != undefined) edit.setGradBeg( xml["@gradBeg"] );
			if(xml["@gradEnd"] != undefined) edit.setGradEnd( xml["@gradEnd"] );
			if(xml["@align"] != undefined) edit.setAlign( xml["@align"] );
			if(xml["@valign"] != undefined) edit.setValign( xml["@valign"] );
			if(xml["@autoWrap"] != undefined) edit.setAutoWrap( xml["@autoWrap"] );
			if(xml["@useStroke"] != undefined) edit.setUseStroke( xml["@useStroke"] );
			if(xml["@strokeColor"] != undefined) edit.setStrokeColor( xml["@strokeColor"] );
			if(xml["@strokeBlur"] != undefined) edit.setStrokeBlur( xml["@strokeBlur"] );
			if(xml["@strokeStrength"] != undefined) edit.setStrokeStrength( xml["@strokeStrength"] );
			if(xml["@font"] != undefined) edit.setFont( xml["@font"] );
			if(xml["@size"] != undefined) edit.setSize( xml["@size"] );
			if(xml["@bold"] != undefined) edit.setBold( xml["@bold"] );
			if(xml["@italic"] != undefined) edit.setItalic( xml["@italic"] );
			if(xml["@underline"] != undefined) edit.setUnderline( xml["@underline"] );
			
			TempTitle.instance.apply();
			TempTitle.instance.setFileName(fileName);
			turnOn(JuiType.JTitle);
		}
		
		private function recoverTempPushButton(xml:XML, fileName:String):void
		{
			var edit:PIButton = TempPushButton.instance.edit;
			
			if(xml["@defaultFill"] != undefined) edit.setDefaultFill( xml["@defaultFill"] );
			if(xml["@overFill"] != undefined) edit.setOverFill( xml["@overFill"] );
			if(xml["@downFill"] != undefined) edit.setDownFill( xml["@downFill"] );
			if(xml["@disabledFill"] != undefined) edit.setDisabledFill( xml["@disabledFill"] );
			if(xml["@faceFill"] != undefined) edit.setFaceFill( xml["@faceFill"] );
			
			if(xml["@label_useStroke"] != undefined) edit.labelPI.setUseStroke( xml["@label_useStroke"] );
			if(xml["@label_strokeColor"] != undefined) edit.labelPI.setStrokeColor( xml["@label_strokeColor"] );
			if(xml["@label_strokeBlur"] != undefined) edit.labelPI.setStrokeBlur( xml["@label_strokeBlur"] );
			if(xml["@label_strokeStrength"] != undefined) edit.labelPI.setStrokeStrength( xml["@label_strokeStrength"] );
			if(xml["@label_useHtml"] != undefined) edit.labelPI.setUseHtml( xml["@label_useHtml"] );
			if(xml["@label_font"] != undefined) edit.labelPI.setFont( xml["@label_font"] );
			if(xml["@label_size"] != undefined) edit.labelPI.setSize( xml["@label_size"] );
			if(xml["@label_color"] != undefined) edit.labelPI.setColor( xml["@label_color"] );
			if(xml["@label_bold"] != undefined) edit.labelPI.setBold( xml["@label_bold"] );
			if(xml["@label_italic"] != undefined) edit.labelPI.setItalic( xml["@label_italic"] );
			if(xml["@label_underline"] != undefined) edit.labelPI.setUnderline( xml["@label_underline"] );
			
			TempPushButton.instance.apply();
			TempPushButton.instance.setFileName(fileName);
			turnOn(JuiType.JPushButton);
		}
		
		private function recoverTempScrollBar(xml:XML, fileName:String, uiType:String):void
		{
			var temp:TempBase;
			var edit:PIScrollBar;
			if(uiType == JuiType.JScrollBarH)
			{
				temp = TempScrollBarH.instance;
				edit = TempScrollBarH.instance.edit;
			}
			else
			{
				temp = TempScrollBarV.instance;
				edit = TempScrollBarV.instance.edit;
			}
			
			if(xml["@fatSize"] != undefined) edit.fatSize.setValue( xml["@fatSize"] );
			if(xml["@bgFill"] != undefined) edit.bgFill.setFill( xml["@bgFill"] );
			
			if(xml["@handle_defaultFill"] != undefined) edit.handleBtn.setDefaultFill( xml["@handle_defaultFill"] );
			if(xml["@handle_overFill"] != undefined) edit.handleBtn.setOverFill( xml["@handle_overFill"] );
			if(xml["@handle_downFill"] != undefined) edit.handleBtn.setDownFill( xml["@handle_downFill"] );
			if(xml["@handle_disabledFill"] != undefined) edit.handleBtn.setDisabledFill( xml["@handle_disabledFill"] );
			if(xml["@handle_faceFill"] != undefined) edit.handleBtn.setFaceFill( xml["@handle_faceFill"] );
			
			if(xml["@upBtn_width"] != undefined) edit.upBtn.setWidth( xml["@upBtn_width"] );
			if(xml["@upBtn_height"] != undefined) edit.upBtn.setHeight( xml["@upBtn_height"] );
			if(xml["@upBtn_defaultFill"] != undefined) edit.upBtn.setDefaultFill( xml["@upBtn_defaultFill"] );
			if(xml["@upBtn_overFill"] != undefined) edit.upBtn.setOverFill( xml["@upBtn_overFill"] );
			if(xml["@upBtn_downFill"] != undefined) edit.upBtn.setDownFill( xml["@upBtn_downFill"] );
			if(xml["@upBtn_disabledFill"] != undefined) edit.upBtn.setDisabledFill( xml["@upBtn_disabledFill"] );
			if(xml["@upBtn_faceFill"] != undefined) edit.upBtn.setFaceFill( xml["@upBtn_faceFill"] );
			
			if(xml["@downBtn_width"] != undefined) edit.downBtn.setWidth( xml["@downBtn_width"] );
			if(xml["@downBtn_height"] != undefined) edit.downBtn.setHeight( xml["@downBtn_height"] );
			if(xml["@downBtn_defaultFill"] != undefined) edit.downBtn.setDefaultFill( xml["@downBtn_defaultFill"] );
			if(xml["@downBtn_overFill"] != undefined) edit.downBtn.setOverFill( xml["@downBtn_overFill"] );
			if(xml["@downBtn_downFill"] != undefined) edit.downBtn.setDownFill( xml["@downBtn_downFill"] );
			if(xml["@downBtn_disabledFill"] != undefined) edit.downBtn.setDisabledFill( xml["@downBtn_disabledFill"] );
			if(xml["@downBtn_faceFill"] != undefined) edit.downBtn.setFaceFill( xml["@downBtn_faceFill"] );
			
			temp.apply();
			temp.setFileName(fileName);
			turnOn(uiType);
		}
			
		
	}
}