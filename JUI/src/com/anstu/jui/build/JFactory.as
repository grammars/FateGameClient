package com.anstu.jui.build
{
	import com.anstu.jui.build.ctrls.*;
	import com.anstu.jui.build.ctrls.base.AssetFiller;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.ctrls.base.CShellContext;
	import com.anstu.jui.build.doc.DocRadioGroups;
	import com.anstu.jui.build.doc.UIPack;
	import com.anstu.jui.build.pack.PackItem;
	import com.anstu.jui.build.template.TemplateInfo;
	import com.anstu.jui.build.template.TemplatesCache;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.controls.*;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.define.JuiType;

	public class JFactory
	{
		private static var docs:Object = new Object();
		
		public function JFactory()
		{
		}
		
		private static var inited:Boolean = false;
		private static function initialize():void
		{
			if(inited) { return; }
			
			CShellContext.instance.assetFiller = new AssetFiller();
			
			inited = true;
		}
		
		/** 注册模版配置文件 */
		public static function regTemplates(items:Vector.<PackItem>, assetsNS:String):void
		{
			initialize();
			
			for(var i:int = 0; i < items.length; i++)
			{
				var item:PackItem = items[i];
				var ti:TemplateInfo = TemplatesCache.parse(item.name, item.content, assetsNS);
				if(!ti) { continue; }
				//trace("模版信息：name=" + ti.name + " content=" + item.content + " assetsNS=" + assetsNS);
				TemplatesCache.putInfo(ti);
			}
		}
		
		/** 注册ui文档 */
		public static function regDocs(items:Vector.<PackItem>, assetsNS:String):void
		{
			initialize();
			
			for(var i:int = 0; i < items.length; i++)
			{
				var item:PackItem = items[i];
				item.assetsNS = assetsNS;
				docs[item.name] = item;
			}
		}
		
		/** 根据文档名生成UI */
		public static function create(docName:String):UIPack
		{
			var item:PackItem = docs[docName];
			if(!item) { return null; }
			var pack:UIPack = new UIPack();
			
			var xml:XML = XML(item.content);
			var headXml:XML = xml.head[0];
			var bodyXml:XML = xml.body[0];
			//trace("headXml=" + headXml.@version);
			//trace("bodyXml=" + bodyXml);
			
			var radiogroupXml:XML = headXml.radiogroup[0];
			if(radiogroupXml)
			{
				parseRadioGroup(radiogroupXml.children());
			}
			
			var ctrlsXmlList:XMLList = bodyXml.children();
			for each(var ctrlXml:XML in ctrlsXmlList)
			{
				var ctrl:JComponent = createCtrl(ctrlXml, item.assetsNS, pack);
				if(ctrl)
				{
					pack.put(ctrl);
				}
			}
			
			var tabpairXml:XML = headXml.tabpair[0];
			if(tabpairXml)
			{
				parseTabPair(tabpairXml.children(), pack);
			}
			
			return pack;
		}
		
		private static function parseRadioGroup(list:XMLList):void
		{
			DocRadioGroups.instance.clearGroups();
			for each(var groupXml:XML in list)
			{
				var name:String = groupXml;
				//trace("parseRadioGroup {" + name + "}");
				var group:JRadioGroup = new JRadioGroup(name);
				DocRadioGroups.instance.addGroup(group);
			}
		}
		
		private static function parseTabPair(list:XMLList, pack:UIPack):void
		{
			for each(var pairXml:XML in list)
			{
				var STag:String = pairXml.@s;
				var MTag:String = pairXml.@m;
				var Sui:JCheckBox = pack.getCheckBox(STag);
				var Mui:JComponent = pack.getCtrl(MTag);
				if(Sui && Mui)
				{
					Mui.setVisualController(Sui);
				}
			}
		}
		
		private static function createCtrl(ctrlXml:XML, assetsNS:String, pack:UIPack):JComponent
		{
			var ctrlType:String = ctrlXml.name();
			//trace("ctrlType:" + ctrlType);
			var ctrl:JComponent = null;
			
			if(ctrlType == JuiType.JCalendar)
			{
				var shellCalendar:CsCalendar = new CsCalendar();
				shellCalendar.assetsNS = assetsNS;
				ctrl = new JCalendar();
				shellCalendar.inject(ctrl);
				readCtrlAttris(shellCalendar, ctrlXml);
			}
			else if(ctrlType == JuiType.JCheckBox)
			{
				var shellCheckBox:CsCheckBox = new CsCheckBox();
				shellCheckBox.assetsNS = assetsNS;
				ctrl = new JCheckBox();
				shellCheckBox.inject(ctrl);
				readCtrlAttris(shellCheckBox, ctrlXml);
			}
			else if(ctrlType == JuiType.JComboBox)
			{
				var shellComboBox:CsComboBox = new CsComboBox();
				shellComboBox.assetsNS = assetsNS;
				ctrl = new JComboBox();
				shellComboBox.inject(ctrl);
				readCtrlAttris(shellComboBox, ctrlXml);
			}
			else if(ctrlType == JuiType.JFrame)
			{
				var shellFrame:CsFrame = new CsFrame();
				shellFrame.assetsNS = assetsNS;
				ctrl = new JFrame();
				shellFrame.inject(ctrl);
				readCtrlAttris(shellFrame, ctrlXml);
			}
			else if(ctrlType == JuiType.JImage)
			{
				var shellImage:CsImage = new CsImage();
				shellImage.assetsNS = assetsNS;
				ctrl = new JImage();
				shellImage.inject(ctrl);
				readCtrlAttris(shellImage, ctrlXml);
			}
			else if(ctrlType == JuiType.JInputText)
			{
				var shellInputText:CsInputText = new CsInputText();
				shellInputText.assetsNS = assetsNS;
				ctrl = new JInputText();
				shellInputText.inject(ctrl);
				readCtrlAttris(shellInputText, ctrlXml);
			}
			else if(ctrlType == JuiType.JLabel)
			{
				var shellLabel:CsLabel = new CsLabel();
				shellLabel.assetsNS = assetsNS;
				ctrl = new JLabel();
				shellLabel.inject(ctrl);
				readCtrlAttris(shellLabel, ctrlXml);
			}
			else if(ctrlType == JuiType.JLink)
			{
				var shellLink:CsLink = new CsLink();
				shellLink.assetsNS = assetsNS;
				ctrl = new JLink();
				shellLink.inject(ctrl);
				readCtrlAttris(shellLink, ctrlXml);
			}
			else if(ctrlType == JuiType.JList)
			{
				var shellList:CsList = new CsList();
				shellList.assetsNS = assetsNS;
				ctrl = new JList();
				shellList.inject(ctrl);
				readCtrlAttris(shellList, ctrlXml);
			}
			else if(ctrlType == JuiType.JListItem)
			{
				var shellListItem:CsListItem = new CsListItem();
				shellListItem.assetsNS = assetsNS;
				ctrl = new JListItem();
				shellListItem.inject(ctrl);
				readCtrlAttris(shellListItem, ctrlXml);
			}
			else if(ctrlType == JuiType.JPanel)
			{
				var shellPanel:CsPanel = new CsPanel();
				shellPanel.assetsNS = assetsNS;
				ctrl = new JPanel();
				shellPanel.inject(ctrl);
				readCtrlAttris(shellPanel, ctrlXml);
			}
			else if(ctrlType == JuiType.JPushButton)
			{
				var shellPushButton:CsPushButton = new CsPushButton();
				shellPushButton.assetsNS = assetsNS;
				ctrl = new JPushButton();
				shellPushButton.inject(ctrl);
				readCtrlAttris(shellPushButton, ctrlXml);
			}
			else if(ctrlType == JuiType.JRadioButton)
			{
				var shellRadioButton:CsRadioButton = new CsRadioButton();
				shellRadioButton.assetsNS = assetsNS;
				ctrl = new JRadioButton();
				shellRadioButton.inject(ctrl);
				readCtrlAttris(shellRadioButton, ctrlXml);
			}
			else if(ctrlType == JuiType.JScrollBarH)
			{
				var shellScrollBarH:CsScrollBar = new CsScrollBar(JuiConst.HORIZONTAL);
				shellScrollBarH.assetsNS = assetsNS;
				ctrl = new JScrollBar(JuiConst.HORIZONTAL);
				shellScrollBarH.inject(ctrl);
				readCtrlAttris(shellScrollBarH, ctrlXml);
			}
			else if(ctrlType == JuiType.JScrollBarV)
			{
				var shellScrollBarV:CsScrollBar = new CsScrollBar(JuiConst.VERTICAL);
				shellScrollBarV.assetsNS = assetsNS;
				ctrl = new JScrollBar(JuiConst.VERTICAL);
				shellScrollBarV.inject(ctrl);
				readCtrlAttris(shellScrollBarV, ctrlXml);
			}
			else if(ctrlType == JuiType.JScrollPanel)
			{
				var shellScrollPanel:CsScrollPanel = new CsScrollPanel();
				shellScrollPanel.assetsNS = assetsNS;
				ctrl = new JScrollPanel();
				shellScrollPanel.inject(ctrl);
				readCtrlAttris(shellScrollPanel, ctrlXml);
			}
			else if(ctrlType == JuiType.JScrollSliderH)
			{
				var shellScrollSliderH:CsScrollSlider = new CsScrollSlider(JuiConst.HORIZONTAL);
				shellScrollSliderH.assetsNS = assetsNS;
				ctrl = new JScrollSlider(JuiConst.HORIZONTAL);
				shellScrollSliderH.inject(ctrl);
				readCtrlAttris(shellScrollSliderH, ctrlXml);
			}
			else if(ctrlType == JuiType.JScrollSliderV)
			{
				var shellScrollSliderV:CsScrollSlider = new CsScrollSlider(JuiConst.VERTICAL);
				shellScrollSliderV.assetsNS = assetsNS;
				ctrl = new JScrollSlider(JuiConst.VERTICAL);
				shellScrollSliderV.inject(ctrl);
				readCtrlAttris(shellScrollSliderV, ctrlXml);
			}
			else if(ctrlType == JuiType.JSliderH)
			{
				var shellSliderH:CsSlider = new CsSlider(JuiConst.HORIZONTAL);
				shellSliderH.assetsNS = assetsNS;
				ctrl = new JSlider(JuiConst.HORIZONTAL);
				shellSliderH.inject(ctrl);
				readCtrlAttris(shellSliderH, ctrlXml);
			}
			else if(ctrlType == JuiType.JSliderV)
			{
				var shellSliderV:CsSlider = new CsSlider(JuiConst.VERTICAL);
				shellSliderV.assetsNS = assetsNS;
				ctrl = new JSlider(JuiConst.VERTICAL);
				shellSliderV.inject(ctrl);
				readCtrlAttris(shellSliderV, ctrlXml);
			}
			else if(ctrlType == JuiType.JText)
			{
				var shellText:CsText = new CsText();
				shellText.assetsNS = assetsNS;
				ctrl = new JText();
				shellText.inject(ctrl);
				readCtrlAttris(shellText, ctrlXml);
			}
			else if(ctrlType == JuiType.JTextArea)
			{
				var shellTextArea:CsTextArea = new CsTextArea();
				shellTextArea.assetsNS = assetsNS;
				ctrl = new JTextArea();
				shellTextArea.inject(ctrl);
				readCtrlAttris(shellTextArea, ctrlXml);
			}
			else if(ctrlType == JuiType.JTitle)
			{
				var shellTitle:CsTitle = new CsTitle();
				shellTitle.assetsNS = assetsNS;
				ctrl = new JTitle();
				shellTitle.inject(ctrl);
				readCtrlAttris(shellTitle, ctrlXml);
			}
			
			
			if(ctrl)
			{
				pack.reg(ctrl);
				
				var subCtrlsXmlList:XMLList = ctrlXml.children();
				for each(var subCtrlXml:XML in subCtrlsXmlList)
				{
					var subCtrl:JComponent = createCtrl(subCtrlXml, assetsNS, pack);
					if(subCtrl)
					{
						ctrl.addChild(subCtrl);
					}
				}
			}
			
			return ctrl;
		}
		
		private static function readCtrlAttris(shell:CShell, ctrlXml:XML):void
		{
			shell.setTag(ctrlXml.@tag);
			shell.getUI().x = (ctrlXml.@x);
			shell.getUI().y = (ctrlXml.@y);
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
		}
		
	}
}