package com.anstu.jui
{
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.components.JStyle;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.components.StListItemData;
	import com.anstu.jui.controls.JCalendar;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JFrame;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JList;
	import com.anstu.jui.controls.JListItem;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JRadioButton;
	import com.anstu.jui.controls.JScrollBar;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.controls.JScrollSlider;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.controls.JText;
	import com.anstu.jui.controls.JTextArea;
	import com.anstu.jui.controls.JTitle;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JCalendarSkin;
	import com.anstu.jui.skin.JCheckBoxSkin;
	import com.anstu.jui.skin.JComboBoxSkin;
	import com.anstu.jui.skin.JFrameSkin;
	import com.anstu.jui.skin.JListSkin;
	import com.anstu.jui.skin.JPanelSkin;
	import com.anstu.jui.skin.JPushButtonSkin;
	import com.anstu.jui.skin.JRadioButtonSkin;
	import com.anstu.jui.skin.JScrollBarSkin;
	import com.anstu.jui.skin.JScrollPanelSkin;
	import com.anstu.jui.skin.JScrollSliderSkin;
	import com.anstu.jui.skin.JSliderSkin;
	import com.anstu.jui.skin.JTextAreaSkin;
	import com.anstu.jui.skin.JTextSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	public class JUIDemo extends Sprite
	{
		private static var _instance:JUIDemo;
		public static function get instance():JUIDemo
		{
			if(_instance == null) { _instance = new JUIDemo(); }
			return _instance;
		}
		
		private var tab_JPanel:Tab = new Tab("JPanel");
		private var tab_JText:Tab = new Tab("JText");
		private var tab_JLabel:Tab = new Tab("JLabel");
		private var tab_JPushButton:Tab = new Tab("JPushButton");
		private var tab_JInputText:Tab = new Tab("JInputText");
		private var tab_JTitle:Tab = new Tab("JTitle");
		private var tab_JTextArea:Tab = new Tab("JTextArea");
		private var tab_JListItem:Tab = new Tab("JListItem");
		private var tab_JList:Tab = new Tab("JList");
		private var tab_JCheckBox:Tab = new Tab("JCheckBox");
		private var tab_JRadioButton:Tab = new Tab("JRadioButton");
		private var tab_JComboBox:Tab = new Tab("JComboBox");
		private var tab_JSlider:Tab = new Tab("JSlider");
		private var tab_JScrollSlider:Tab = new Tab("JScrollSlider");
		private var tab_JScrollBar:Tab = new Tab("JScrollBar");
		private var tab_JScrollPanel:Tab = new Tab("JScrollPanel");
		private var tab_JCalendar:Tab = new Tab("JCalendar");
		private var tab_JFrame:Tab = new Tab("JFrame");
		private var tab_fill:Tab = new Tab("延迟填充");
		
		private var tabs:Array;
		
		private var ctn_JPanel:Sprite = new Sprite();
		private var ctn_JText:Sprite = new Sprite();
		private var ctn_JLabel:Sprite = new Sprite();
		private var ctn_JPushButton:Sprite = new Sprite();
		private var ctn_JInputText:Sprite = new Sprite();
		private var ctn_JTitle:Sprite = new Sprite();
		private var ctn_JTextArea:Sprite = new Sprite();
		private var ctn_JListItem:Sprite = new Sprite();
		private var ctn_JList:Sprite = new Sprite();
		private var ctn_JCheckBox:Sprite = new Sprite();
		private var ctn_JRadioButton:Sprite = new Sprite();
		private var ctn_JComboBox:Sprite = new Sprite();
		private var ctn_JSlider:Sprite = new Sprite();
		private var ctn_JScrollSlider:Sprite = new Sprite();
		private var ctn_JScrollBar:Sprite = new Sprite();
		private var ctn_JScrollPanel:Sprite = new Sprite();
		private var ctn_JCalendar:Sprite = new Sprite();
		private var ctn_JFrame:Sprite = new Sprite();
		private var ctn_fill:Sprite = new Sprite();
		
		private var ctns:Array;
		
		public function JUIDemo()
		{
			super();
			setup();
		}
		
		private function setup():void
		{
			tabs = [tab_JPanel, tab_JText, tab_JLabel, tab_JPushButton, tab_JInputText, 
				tab_JTitle, tab_JTextArea, tab_JListItem, tab_JList, tab_JCheckBox, tab_JRadioButton,
				tab_JComboBox, tab_JSlider, tab_JScrollSlider, tab_JScrollBar, tab_JScrollPanel,
				tab_JCalendar, tab_JFrame, tab_fill];
			ctns = [ctn_JPanel, ctn_JText, ctn_JLabel, ctn_JPushButton, ctn_JInputText, 
				ctn_JTitle, ctn_JTextArea, ctn_JListItem, ctn_JList, ctn_JCheckBox, ctn_JRadioButton,
				ctn_JComboBox, ctn_JSlider, ctn_JScrollSlider, ctn_JScrollBar, ctn_JScrollPanel,
				ctn_JCalendar, ctn_JFrame, ctn_fill];
			for(var i:int = 0; i < tabs.length; i++)
			{
				tabs[i].x = 128 * Math.floor(i%2);
				tabs[i].y = 36 * Math.floor(i/2);
				ctns[i].x = 260;
				ctns[i].y = 0;
				this.addChild(tabs[i]);
			}
			this.addEventListener(MouseEvent.CLICK, __click);
			//
			setDemos();
		}
		
		private function __click(e:MouseEvent):void
		{
			var i:int = 0;
			for(i = 0; i < tabs.length; i++)
			{
				if(tabs[i] == e.target)
				{
					for(var j:int = 0; j < ctns.length; j++)
					{
						if(ctns[j].parent) { ctns[j].parent.removeChild(ctns[j]); }
					}
					break;
				}
			}
			//
			if(i < ctns.length)
			{
				addChild(ctns[i]);
			}
			else
			{
				//点击了其他地方
			}
		}
		
		private function setDemos():void
		{
			set_JPanel();
			set_JText();
			set_JLabel();
			set_JPushButton();
			set_JInputText();
			set_JTitle();
			set_JTextArea();
			set_JListItem();
			set_JList();
			set_JCheckBox();
			set_JRadioButton();
			set_JComboBox();
			set_JSlider();
			set_JScrollSlider();
			set_JScrollBar();
			set_JScrollPanel();
			set_JCalendar();
			set_JFrame();
			set_fill();
		}
		
		private function set_JPanel():void
		{
			var panel:JPanel = new JPanel();
			new JPanelSkin().apply(panel);
			panel.width = 300;
			panel.height = 400;
			ctn_JPanel.addChild(panel);
			
			var p2:JPanel = new JPanel();
			var p2s:JPanelSkin = new JPanelSkin();
			p2s.background_ns = "plugin";
			p2s.background_cls = "paneFrame.png";
			p2s.apply(p2);
			p2.move(320, 0);
			p2.width = 300;
			p2.height = 200;
			ctn_JPanel.addChild(p2);
			
			var p3:JPanel = new JPanel();
			var p3s:JPanelSkin = new JPanelSkin();
			p3s.background_ns = "base";
			p3s.background_cls = "wordStart.png";
			p3s.background_opt = JResource.OPT_TILE_REPEAT;
			//p3s.background_opt = JResource.OPT_TILE_SINGLE;
			p3s.apply(p3);
			p3.move(320, 230);
			p3.width = 300;
			p3.height = 200;
			ctn_JPanel.addChild(p3);
		}
		
		private function set_JText():void
		{
			var text:JText = new JText("这是一个JText\r换行吧\n如何呢");
			new JTextSkin().apply(text);
			text.move(0, 0);
			text.setSize(120, 280);
			text.editable = true;
			text.selectable = true;
			text.textFormat.color = 0xff0000;
			ctn_JText.addChild(text);
			
			var text2:JText = new JText("这是一个JText\r换行吧\n如何呢");
			new JTextSkin().apply(text2);
			text2.move(130, 0);
			text2.setSize(120, 280);
			text2.editable = false;
			text2.selectable = true;
			text2.textFormat.color = 0x00ffff;
			ctn_JText.addChild(text2);
			
			var text3:JText = new JText("这是一个JText\r换行吧\n如何呢");
			text3.move(280, 0);
			text3.setSize(120, 280);
			text3.editable = false;
			text3.selectable = false;
			text3.textFormat.color = 0xff00ff;
			ctn_JText.addChild(text3);
		}
		
		private function set_JLabel():void
		{
			var l:JLabel = new JLabel("我是一个JLabel\r就是标签的意思 ");
			l.useFrame = true;
			l.width = 200;
			l.height = 200;
			l.align = JuiConst.RIGHT;
			l.valign = JuiConst.DOWN;
			l.textFormat.color = 0xdedede;
			l.textFormat.bold = true;
			l.useStroke = true;
			l.strokeBlur = 3;
			l.strokeColor = 0x000000;
			l.strokeStrength = 3;
			ctn_JLabel.addChild(l);
		}
		
		private function set_JPushButton():void
		{
			var btn:JPushButton = new JPushButton();
			new JPushButtonSkin().apply(btn);
			btn.setSize(100, 50);
			btn.move(50, 50);
			ctn_JPushButton.addChild(btn);
			//
			function __defaultHandler(e:MouseEvent):void
			{
				trace("样式按钮被点击啦");
			}
			var styleBtn:JPushButton = new JPushButton("无图模式", __defaultHandler);
			styleBtn.label.textFormat.color = "0xff0000";
			styleBtn.setSize(80, 30);
			styleBtn.x = 200;
			styleBtn.y = 50;
			ctn_JPushButton.addChild(styleBtn);
		}
		
		private function set_JInputText():void
		{
			var input:JInputText = new JInputText("请输入");
			input.maxChars = 4;
			input.width = 200;
			input.height = 40;
			input.textFormat.color = 0xfed510;
			input.textFormat.size = 16;
			input.useFrame = true;
			input.useStroke = true;
			ctn_JInputText.addChild(input);
		}
		
		private function set_JTitle():void
		{
			var title:JTitle = new JTitle("大标题");
			title.textFormat.font = "Microsoft Yahei";
			title.textFormat.size = 24;
			title.textFormat.bold = true;
			title.gradBeg = 0xff0000;
			title.gradEnd = 0x123456;
			title.strokeColor = 0xffff00;
			title.strokeBlur = 4;
			title.strokeAlpha = 0.9;
			title.strokeStrength = 3;
			ctn_JTitle.addChild(title);
		}
		
		private function set_JTextArea():void	
		{
			var ta:JTextArea = new JTextArea("一开始先写点什么东西\rinside\r1\r1\r1\r1\r1\r1\r1\r1\r1");
			ta.textFormat.font = "Microsoft Yahei";
			ta.textFormat.size = 18;
			ta.textFormat.italic = true;
			ta.useFrame = true;
			ta.scrollbar.scrollSlider.handle.tag = "debug";
			ctn_JTextArea.addChild(ta);
			//
			var sta:JTextArea = new JTextArea("A\rB\rC\rD\r一\r二\r三\r四");
			new JTextAreaSkin().apply(sta);
			sta.move(0, 250);
			sta.autoHideScrollBar = true;
			ctn_JTextArea.addChild(sta);
		}
		
		private function set_JListItem():void
		{
			var li:JListItem = new JListItem(new StListItemData("包含数据", {val:123}));
			li.defaultColor = 0xff0000;
			li.rolloverColor = 0xffff00;
			li.setSize(200, 50);
			li.x = 100;
			li.y = 100;
			li.label.align = JuiConst.CENTER;
			li.label.textFormat.color = 0x123456;
			li.label.valign = JuiConst.DOWN;
			ctn_JListItem.addChild(li);
		}
		
		private function set_JList():void
		{
			var items:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,"hello", new StListItemData("血量"), {caption:"caption"}, {text:"text"}, {label:"label"}];
			var ls:JList = new JList(items);
			//var ls:JList = new JList([22]);
			new JListSkin().apply(ls);
			ls.move(0,0);
			ls.setSize(150, 300);
			//ls.selectedIndex = 13;
			ls.addItemAt("选项", 4);
			ls.removeItemAt(3);
			//ls.showFrame(true);
			ctn_JList.addChild(ls);
			function selectHandler(e:Event):void
			{
				trace(ls.selectedItem);
				ls.removeItemAt(0);
			}
			ls.addEventListener(Event.SELECT, selectHandler);
			
			var nls:JList = new JList(items);
			nls.panel.bgAlpha = 0;
			nls.move(180,0);
			nls.setSize(150, 300);
			ctn_JList.addChild(nls);
		}
		
		private function set_JCheckBox():void
		{
			var skin:JCheckBoxSkin = new JCheckBoxSkin();
			var cb0:JCheckBox = new JCheckBox();
			cb0.setSize(19, 20);
			skin.apply(cb0);
			cb0.x = 100
			cb0.y = 100;
			cb0.selected = true;
			ctn_JCheckBox.addChild(cb0);
			var cb1:JCheckBox = new JCheckBox();
			cb1.x = 150
			cb1.y = 100;
			cb1.selected = false;
			ctn_JCheckBox.addChild(cb1);
			var cb2:JCheckBox = new JCheckBox();
			cb2.x = 200
			cb2.y = 100;
			cb2.selected = false;
			ctn_JCheckBox.addChild(cb2);
		}
		
		private function set_JRadioButton():void
		{
			var rb0:JRadioButton = new JRadioButton();
			rb0.move(0, 0);
			var rb1:JRadioButton = new JRadioButton();
			rb1.move(50, 0);
			var rb2:JRadioButton = new JRadioButton();
			rb2.move(100, 0);
			var group0:JRadioGroup = new JRadioGroup();
			group0.add(rb0);
			group0.add(rb1);
			group0.add(rb2);
			group0.remove(rb2);
			
			ctn_JRadioButton.addChild(rb0);
			ctn_JRadioButton.addChild(rb1);
			ctn_JRadioButton.addChild(rb2);
			
			var rb3:JRadioButton = new JRadioButton();
			rb3.move(0, 50);
			var rb4:JRadioButton = new JRadioButton();
			rb4.move(50, 50);
			var rb5:JRadioButton = new JRadioButton();
			rb5.move(100, 50);
			var group1:JRadioGroup = new JRadioGroup();
			group1.add(rb3);
			group1.add(rb4);
			group1.add(rb5);
			var skin:JRadioButtonSkin = new JRadioButtonSkin();
			skin.apply(rb3);
			skin.apply(rb4);
			skin.apply(rb5);
			
			ctn_JRadioButton.addChild(rb3);
			ctn_JRadioButton.addChild(rb4);
			ctn_JRadioButton.addChild(rb5);
		}
		
		private function set_JComboBox():void
		{
			var items:Array = ["选项0", "optionOne", 2, "3", {key:"4"}, 5, 6, 7, 8];
			
			var scb:JComboBox = new JComboBox("请选择一个选项", items);
			new JComboBoxSkin().apply(scb);
			scb.move(50, 50);
			scb.width = 200;
			scb.openPosition = JuiConst.DOWN;
			scb.numVisibleItems = 6;
			ctn_JComboBox.addChild(scb);
			
			function __selected(e:Event):void
			{
				var cb:JComboBox = e.target as JComboBox;
				trace(cb.selectedIndex, cb.selectedItem);
			}
			var cb:JComboBox = new JComboBox("请选择一个选项", items);
			cb.move(50, 300);
			cb.setSize(200, 24);
			cb.openPosition = JuiConst.UP;
			cb.numVisibleItems = 4;
			cb.list.autoHideScrollBar = false;
			cb.list.listItemHeight = 22;
			cb.list.textFormat.color = 0xd1c692;
			cb.list.alternateRows = true;
			cb.dropDownButton.setSize(17, 24);
			cb.addEventListener(Event.SELECT, __selected);
			ctn_JComboBox.addChild(cb);
		}
		
		private function set_JSlider():void
		{
			var skin:JSliderSkin = new JSliderSkin();
			var sld:JSlider = new JSlider(JuiConst.HORIZONTAL, traceValue);
			skin.apply(sld);
			//sld.setSize(200, 16);
			sld.move(50, 50);
			ctn_JSlider.addChild(sld);
			function traceValue():void { trace(sld.value); }
			//
			var vsld:JSlider = new JSlider(JuiConst.VERTICAL, traceValueV);
			skin.apply(vsld);
			vsld.handle.caption = "handle";
			vsld.handle.label.textFormat = new JTextFormat("微软雅黑", 14, 0xffff00);
			//vsld.setSize(16, 200);
			vsld.move(50, 130);
			vsld.minimum = 100;
			vsld.maximum = 0;
			vsld.value = 20;
			ctn_JSlider.addChild(vsld);
			function traceValueV():void { trace(vsld.value); }
		}
		
		private function set_JScrollSlider():void
		{
			var vss:JScrollSlider = new JScrollSlider(JuiConst.VERTICAL);
			new JScrollSliderSkin().apply(vss);
			vss.move(50, 50);
			vss.minimum = 100;
			vss.maximum = 0;
			vss.value = 20;
			vss.thumbPercent = (0.1);
			vss.step = 20;
			ctn_JScrollSlider.addChild(vss);
			
			var hss:JScrollSlider = new JScrollSlider(JuiConst.HORIZONTAL);
			new JScrollSliderSkin().apply(hss);
			hss.width = 180;
			hss.move(80, 50);
			hss.minimum = 100;
			hss.maximum = 0;
			hss.value = 20;
			hss.thumbPercent = (0.4);
			hss.step = 20;
			ctn_JScrollSlider.addChild(hss); 
			
			var hss2:JScrollSlider = new JScrollSlider(JuiConst.HORIZONTAL);
			hss2.setSize(200, 30);
			hss2.move(80, 150);
			hss2.minimum = 100;
			hss2.maximum = 0;
			hss2.value = 40;
			hss2.thumbPercent = (0.4);
			hss2.step = 10;
			ctn_JScrollSlider.addChild(hss2); 
		}
		
		private function set_JScrollBar():void
		{
			var skin:JScrollBarSkin = new JScrollBarSkin();
			
			var scrb:JScrollBar = new JScrollBar(JuiConst.HORIZONTAL, traceValue);
			skin.apply(scrb);
			//scrb.setSize(200, 19);
			scrb.move(50, 50);
			scrb.setSliderParams(0, 100, 30);
			scrb.thumbPercent = (0.3);
			scrb.step = 15;
			ctn_JScrollBar.addChild(scrb);
			function traceValue():void { trace(scrb.value); }
			//
			var vscrb:JScrollBar = new JScrollBar(JuiConst.VERTICAL);
			skin.apply(vscrb);
			vscrb.height = 200;
			vscrb.move(50, 150);
			vscrb.setSliderParams(0, 100, 30);
			vscrb.thumbPercent = (0.7);
			vscrb.step = 15;
			ctn_JScrollBar.addChild(vscrb);
			
			var nscrb:JScrollBar = new JScrollBar(JuiConst.VERTICAL);
			nscrb.setUpDownBtnSize(30, 20);
			nscrb.width = 30;
			nscrb.height = 200;
			nscrb.move(100, 150);
			nscrb.setSliderParams(0, 100, 30);
			nscrb.thumbPercent = (0.1);
			nscrb.step = 16;
			ctn_JScrollBar.addChild(nscrb);
		}
		
		private function set_JScrollPanel():void
		{
			var inside:JPanel = new JPanel();
			inside.enabled = false;
			new JPanelSkin().apply(inside);
			inside.setSize(1200, 1200);
			var sp:JScrollPanel = new JScrollPanel();
			new JScrollPanelSkin().apply(sp);
			sp.autoHideScrollBar = true;
			sp.setSize(200, 200);
			sp.addChild(inside);
			ctn_JScrollPanel.addChild(sp);
		}
		
		private function set_JCalendar():void
		{
			var cld:JCalendar = new JCalendar();
			new JCalendarSkin().apply(cld);
			cld.monthNames = JCalendar.MONTH_JP;
			cld.dateLabelPattern = "{yy}  {mm}";
			ctn_JCalendar.addChild(cld);
			
			function selectHandler(e:Event=null):void
			{
				trace(cld.selectedDate);
			}
			cld.addEventListener(Event.SELECT, selectHandler);
			//setInterval(selectHandler, 1000);
		}
		
		private function set_JFrame():void
		{
			var f0:JFrame = new JFrame();
			f0.move(20, 20);
			ctn_JFrame.addChild(f0);
			new JFrameSkin().apply(f0);
			
			var f1:JFrame = new JFrame();
			f1.move(100, 100);
			ctn_JFrame.addChild(f1);
			//new JFrameSkin().apply(f1);
		}
		
		private function set_fill():void
		{
			var panel:JPanel = new JPanel();
			JResource.fill(panel.fillBackground, "paneFrame.png", "plugin");
			panel.width = 300;
			panel.height = 400;
			ctn_fill.addChild(panel);
			//
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, __xmlIoError);
			xmlLoader.addEventListener(Event.COMPLETE, __xmlLoaded);
			xmlLoader.load(new URLRequest("plugin_uir.xml"));
		}
		private function __xmlIoError(e:IOErrorEvent):void
		{
			trace("__xmlIoError::" + e.toString());
		}
		private var pluginXml:XML;
		private function __xmlLoaded(e:Event):void
		{
			var xmlLoader:URLLoader = e.target as URLLoader;
			pluginXml = new XML(xmlLoader.data);
			var ns:String = pluginXml.property.@ns;
			var url:String = pluginXml.property.@url;
			var domainLoader:Loader = new Loader();
			var domainReq:URLRequest = new URLRequest(url);
			var domainCtx:LoaderContext = new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain));
			domainLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, __domainLoaded);
			domainLoader.load(domainReq, domainCtx);
		}
		private function __domainLoaded(e:Event):void
		{
			var li:LoaderInfo = e.target as LoaderInfo;
			JResource.add(pluginXml, li.applicationDomain);
		}
		
	}
}



import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;


class Tab extends Sprite
{
	public function Tab(label:String)
	{
		this.buttonMode = true;
		var tf:TextField = new TextField();
		tf.defaultTextFormat = new TextFormat(null, 16, 0xdedede, true);
		tf.width = 120;
		tf.height = 26;
		tf.selectable = false;
		tf.mouseEnabled = false;
		tf.autoSize = TextFieldAutoSize.CENTER;
		tf.text = label;
		addChild(tf);
		//
		this.graphics.lineStyle(2, 0x121212);
		this.graphics.beginFill(0x343434);
		this.graphics.drawRoundRect(0, 0, 120, 30, 5);
		this.graphics.endFill();
	}
}