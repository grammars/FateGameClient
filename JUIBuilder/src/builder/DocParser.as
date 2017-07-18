package builder
{
	import builder.view.UICanvas;
	import builder.view.radio.RadioGroupEditor;
	import builder.view.tab.TabPairEditor;
	
	import com.anstu.jui.build.ctrls.CsCalendar;
	import com.anstu.jui.build.ctrls.CsCheckBox;
	import com.anstu.jui.build.ctrls.CsComboBox;
	import com.anstu.jui.build.ctrls.CsFrame;
	import com.anstu.jui.build.ctrls.CsImage;
	import com.anstu.jui.build.ctrls.CsInputText;
	import com.anstu.jui.build.ctrls.CsLabel;
	import com.anstu.jui.build.ctrls.CsLink;
	import com.anstu.jui.build.ctrls.CsList;
	import com.anstu.jui.build.ctrls.CsListItem;
	import com.anstu.jui.build.ctrls.CsPanel;
	import com.anstu.jui.build.ctrls.CsPushButton;
	import com.anstu.jui.build.ctrls.CsRadioButton;
	import com.anstu.jui.build.ctrls.CsScrollBar;
	import com.anstu.jui.build.ctrls.CsScrollPanel;
	import com.anstu.jui.build.ctrls.CsScrollSlider;
	import com.anstu.jui.build.ctrls.CsSlider;
	import com.anstu.jui.build.ctrls.CsText;
	import com.anstu.jui.build.ctrls.CsTextArea;
	import com.anstu.jui.build.ctrls.CsTitle;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;

	public class DocParser
	{
		public function DocParser()
		{
		}
		
		public static function parse(docText:String):void
		{
			var xml:XML = XML(docText);
			var headXml:XML = xml.head[0];
			var bodyXml:XML = xml.body[0];
			//trace("headXml=" + headXml.@version);
			//trace("bodyXml=" + bodyXml);
			var radiogroupXml:XML = headXml.radiogroup[0];
			if(radiogroupXml)
			{
				RadioGroupEditor.instance.parse(radiogroupXml.children());
			}
			//
			var ctrlsXmlList:XMLList = bodyXml.children();
			for each(var ctrlXml:XML in ctrlsXmlList)
			{
				var shell:CShell = createCtrl(ctrlXml);
				if(shell)
				{
					UICanvas.instance.addShell(shell);
				}
			}
			//
			var tabpairXml:XML = headXml.tabpair[0];
			if(tabpairXml)
			{
				TabPairEditor.instance.parse(tabpairXml.children());
			}
		}
		
		private static function createCtrl(ctrlXml:XML):CShell
		{
			var ctrlType:String = ctrlXml.name();
			trace("ctrlType:" + ctrlType);
			var shell:CShell = null;
			
			if(ctrlType == JuiType.JCalendar)
			{
				var calendar:CsCalendar = new CsCalendar();
				digestCalendar(calendar, ctrlXml);
				shell = calendar;
			}
			else if(ctrlType == JuiType.JCheckBox)
			{
				var checkBox:CsCheckBox = new CsCheckBox();
				digestCheckBox(checkBox, ctrlXml);
				shell = checkBox;
			}
			else if(ctrlType == JuiType.JComboBox)
			{
				var comboBox:CsComboBox = new CsComboBox();
				digestComboBox(comboBox, ctrlXml);
				shell = comboBox;
			}
			else if(ctrlType == JuiType.JFrame)
			{
				var frame:CsFrame = new CsFrame();
				digestFrame(frame, ctrlXml);
				shell = frame;
			}
			else if(ctrlType == JuiType.JImage)
			{
				var image:CsImage = new CsImage();
				digestImage(image, ctrlXml);
				shell = image;
			}
			else if(ctrlType == JuiType.JInputText)
			{
				var inputText:CsInputText = new CsInputText();
				digestInputText(inputText, ctrlXml);
				shell = inputText;
			}
			else if(ctrlType == JuiType.JLabel)
			{
				var label:CsLabel = new CsLabel();
				digestLabel(label, ctrlXml);
				shell = label;
			}
			else if(ctrlType == JuiType.JLink)
			{
				var link:CsLink = new CsLink();
				digestLink(link, ctrlXml);
				shell = link;
			}
			else if(ctrlType == JuiType.JList)
			{
				var list:CsList = new CsList();
				digestList(list, ctrlXml);
				shell = list;
			}
			else if(ctrlType == JuiType.JListItem)
			{
				var listItem:CsListItem = new CsListItem();
				digestListItem(listItem, ctrlXml);
				shell = listItem;
			}
			else if(ctrlType == JuiType.JPanel)
			{
				var panel:CsPanel = new CsPanel();
				digestPanel(panel, ctrlXml);
				shell = panel;
			}
			else if(ctrlType == JuiType.JPushButton)
			{
				var pushButton:CsPushButton = new CsPushButton();
				digestPushButton(pushButton, ctrlXml);
				shell = pushButton;
			}
			else if(ctrlType == JuiType.JRadioButton)
			{
				var radioButton:CsRadioButton = new CsRadioButton();
				digestRadioButton(radioButton, ctrlXml);
				shell = radioButton;
			}
			else if(ctrlType == JuiType.JScrollBarH)
			{
				var hScrollBar:CsScrollBar = new CsScrollBar(JuiConst.HORIZONTAL);
				digestScrollBar(hScrollBar, ctrlXml);
				shell = hScrollBar;
			}
			else if(ctrlType == JuiType.JScrollBarV)
			{
				var vScrollBar:CsScrollBar = new CsScrollBar(JuiConst.VERTICAL);
				digestScrollBar(vScrollBar, ctrlXml);
				shell = vScrollBar;
			}
			else if(ctrlType == JuiType.JScrollPanel)
			{
				var scrollPanel:CsScrollPanel = new CsScrollPanel();
				digestScrollPanel(scrollPanel, ctrlXml);
				shell = scrollPanel;
			}
			else if(ctrlType == JuiType.JScrollSliderH)
			{
				var hScrollSlider:CsScrollSlider = new CsScrollSlider(JuiConst.HORIZONTAL);
				digestScrollSlider(hScrollSlider, ctrlXml);
				shell = hScrollSlider;
			}
			else if(ctrlType == JuiType.JScrollSliderV)
			{
				var vScrollSlider:CsScrollSlider = new CsScrollSlider(JuiConst.VERTICAL);
				digestScrollSlider(vScrollSlider, ctrlXml);
				shell = vScrollSlider;
			}
			else if(ctrlType == JuiType.JSliderH)
			{
				var hSlider:CsSlider = new CsSlider(JuiConst.HORIZONTAL);
				digestSlider(hSlider, ctrlXml);
				shell = hSlider;
			}
			else if(ctrlType == JuiType.JSliderV)
			{
				var vSlider:CsSlider = new CsSlider(JuiConst.VERTICAL);
				digestSlider(vSlider, ctrlXml);
				shell = vSlider;
			}
			else if(ctrlType == JuiType.JText)
			{
				var text:CsText = new CsText();
				digestText(text, ctrlXml);
				shell = text;
			}
			else if(ctrlType == JuiType.JTextArea)
			{
				var textArea:CsTextArea = new CsTextArea();
				digestTextArea(textArea, ctrlXml);
				shell = textArea;
			}
			else if(ctrlType == JuiType.JTitle)
			{
				var title:CsTitle = new CsTitle();
				digestTitle(title, ctrlXml);
				shell = title;
			}
			 
			
			if(shell)
			{
				var subCtrlsXmlList:XMLList = ctrlXml.children();
				for each(var subCtrlXml:XML in subCtrlsXmlList)
				{
					var subShell:CShell = createCtrl(subCtrlXml);
					if(subShell)
					{
						shell.addShell(subShell);
					}
				}
			}
			
			return shell;
		}
		
		/** 汲取Base属性 */
		private static function digestBase(shell:CShell, ctrlXml:XML):void
		{
			shell.setTag(ctrlXml.@tag);
			shell.setX(ctrlXml.@x);
			shell.setY(ctrlXml.@y);
			if(ctrlXml.@width != undefined)
			{
				shell.setWidth(ctrlXml.@width);
			}
			if(ctrlXml.@height != undefined)
			{
				shell.setHeight(ctrlXml.@height);
			}
			
			var attris:Array = shell.getAttris();
			for(var i:int = 0; i < attris.length; i++)
			{
				var attriName:String = attris[i];
				if(ctrlXml["@"+attriName] != undefined)
				shell[attriName] = ctrlXml["@"+attriName];
			}
			
			var tpls:Array = shell.getTpls();
			for(var m:int = 0; m < tpls.length; m++)
			{
				var tplName:String = tpls[m];
				if(ctrlXml["@"+tplName] != undefined)
					shell[tplName] = ctrlXml["@"+tplName];
			}
			Builder.regShell(shell);
		}
		
		/** 汲取Calendar属性 */
		private static function digestCalendar(calendar:CsCalendar, ctrlXml:XML):void
		{
			digestBase(calendar, ctrlXml);
		}
		
		/** 汲取CheckBox属性 */
		private static function digestCheckBox(checkBox:CsCheckBox, ctrlXml:XML):void
		{
			digestBase(checkBox, ctrlXml);
		}
		
		/** 汲取ComboBox属性 */
		private static function digestComboBox(comboBox:CsComboBox, ctrlXml:XML):void
		{
			digestBase(comboBox, ctrlXml);
		}
		
		/** 汲取Frame属性 */
		private static function digestFrame(frame:CsFrame, ctrlXml:XML):void
		{
			digestBase(frame, ctrlXml);
			
//			frame.active = ctrlXml.@active;
//			frame.pane_bgAlpha = ctrlXml.@pane_bgAlpha;
//			frame.pane_bgColor = ctrlXml.@pane_bgColor;
//			frame.pane_bgFiller = ctrlXml.@pane_bgFiller;
//			
//			frame.iconifiedBtn_width = ctrlXml.@iconifiedBtn_width;
//			frame.iconifiedBtn_height = ctrlXml.@iconifiedBtn_height;
//			frame.iconifiedBtn_defaultFill = ctrlXml.@iconifiedBtn_defaultFill;
//			frame.iconifiedBtn_overFill = ctrlXml.@iconifiedBtn_overFill;
//			frame.iconifiedBtn_downFill = ctrlXml.@iconifiedBtn_downFill;
//			frame.iconifiedBtn_disabledFill = ctrlXml.@iconifiedBtn_disabledFill;
//			frame.iconifiedBtn_faceFill = ctrlXml.@iconifiedBtn_faceFill;
		}
		
		/** 汲取Image属性 */
		private static function digestImage(image:CsImage, ctrlXml:XML):void
		{
			digestBase(image, ctrlXml);
		}
		
		/** 汲取InputText属性 */
		private static function digestInputText(inputText:CsInputText, ctrlXml:XML):void
		{
			digestBase(inputText, ctrlXml);
		}
		
		/** 汲取Label属性 */
		private static function digestLabel(label:CsLabel, ctrlXml:XML):void
		{
			digestBase(label, ctrlXml);
		}
		
		/** 汲取Link属性 */
		private static function digestLink(link:CsLink, ctrlXml:XML):void
		{
			digestBase(link, ctrlXml);
		}
		
		/** 汲取List属性 */
		private static function digestList(list:CsList, ctrlXml:XML):void
		{
			digestBase(list, ctrlXml);
		}
		
		/** 汲取ListItem属性 */
		private static function digestListItem(listItem:CsListItem, ctrlXml:XML):void
		{
			digestBase(listItem, ctrlXml);
		}
		
		/** 汲取Panel属性 */
		private static function digestPanel(panel:CsPanel, ctrlXml:XML):void
		{
			digestBase(panel, ctrlXml);
		}
		
		/** 汲取PushButton属性 */
		private static function digestPushButton(pushButton:CsPushButton, ctrlXml:XML):void
		{
			digestBase(pushButton, ctrlXml);
		}
		
		/** 汲取RadioButton属性 */
		private static function digestRadioButton(radioButton:CsRadioButton, ctrlXml:XML):void
		{
			digestBase(radioButton, ctrlXml);
		}
		
		/** 汲取ScrollBar属性 */
		private static function digestScrollBar(scrollBar:CsScrollBar, ctrlXml:XML):void
		{
			digestBase(scrollBar, ctrlXml);
		}
		
		/** 汲取ScrollPanel属性 */
		private static function digestScrollPanel(scrollPanel:CsScrollPanel, ctrlXml:XML):void
		{
			digestBase(scrollPanel, ctrlXml);
		}
		
		/** 汲取ScrollSlider属性 */
		private static function digestScrollSlider(scrollSlider:CsScrollSlider, ctrlXml:XML):void
		{
			digestBase(scrollSlider, ctrlXml);
		}
		
		/** 汲取Slider属性 */
		private static function digestSlider(slider:CsSlider, ctrlXml:XML):void
		{
			digestBase(slider, ctrlXml);
		}
		
		/** 汲取Text属性 */
		private static function digestText(text:CsText, ctrlXml:XML):void
		{
			digestBase(text, ctrlXml);
		}
		
		/** 汲取TextArea属性 */
		private static function digestTextArea(textArea:CsTextArea, ctrlXml:XML):void
		{
			digestBase(textArea, ctrlXml);
		}
		
		/** 汲取Title属性 */
		private static function digestTitle(title:CsTitle, ctrlXml:XML):void
		{
			digestBase(title, ctrlXml);
		}
		
		
	}
}