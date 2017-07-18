package builder.view
{
	import builder.Builder;
	import builder.view.base.BFrame;
	
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
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JImage;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JPushButtonSkin;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class UIBox extends BFrame
	{
		private static var _instance:UIBox;
		public static function get instance():UIBox
		{
			if(_instance == null) { _instance = new UIBox(); }
			return _instance;
		}
		
		override public function get W():int
		{
			return 120;
		}
		
		override public function get H():int
		{
			var h:int = Builder.stage.stageHeight - MenuBar.instance.H - ToolBox.instance.H - StatusBar.instance.H;
			if(h <= 0) { h = 1; }
			return h;
		}
		
		private static const BTN_W:int = 97;
		private static const BTN_H:int = 30;
		private static const BTN_GAP:int = 2;
		
		private var scr:JScrollPanel;
		
		private var createJFrameBtn:JPushButton;
		private var createJPanelBtn:JPushButton;
		private var createJScrollPanelBtn:JPushButton;
		private var createJImageBtn:JPushButton;
		private var createJLabelBtn:JPushButton;
		private var createJLinkBtn:JPushButton;
		private var createJInputTextBtn:JPushButton;
		private var createJTextBtn:JPushButton;
		private var createJTextAreaBtn:JPushButton;
		private var createJTitleBtn:JPushButton;
		private var createJPushButtonBtn:JPushButton;
		private var createJCheckBoxBtn:JPushButton;
		private var createJRadioButtonBtn:JPushButton;
		private var createJListBtn:JPushButton;
		private var createJListItemBtn:JPushButton;
		private var createJComboBoxBtn:JPushButton;
		private var createJScrollBarHBtn:JPushButton;
		private var createJScrollBarVBtn:JPushButton;
		private var createJScrollSliderHBtn:JPushButton;
		private var createJScrollSliderVBtn:JPushButton;
		private var createJSliderHBtn:JPushButton;
		private var createJSliderVBtn:JPushButton;
		private var createJCalendarBtn:JPushButton;
		
		public function UIBox()
		{
			super();
			enableBtns();
		}
		
		override protected function createParts():void
		{
			super.createParts();
			
			scr = new JScrollPanel();
			new JScrollPanelSkin().apply(scr);
			scr.move(MARGIN, MARGIN);
			this.addChild(scr);
			
			createJFrameBtn = createItemBtn("JFrame", __createJFrame);
			createJPanelBtn = createItemBtn("JPanel", __createJPanel);
			createJScrollPanelBtn = createItemBtn("JScrollPanel", __createJScrollPanel);
			createJImageBtn = createItemBtn("JImage", __createJImage);
			createJLabelBtn = createItemBtn("JLabel", __createJLabel);
			createJLinkBtn = createItemBtn("JLink", __createJLink);
			createJInputTextBtn = createItemBtn("JInputText", __createJInputText);
			createJTextBtn = createItemBtn("JText", __createJText);
			createJTextAreaBtn = createItemBtn("JTextArea", __createJTextArea);
			createJTitleBtn = createItemBtn("JTitle", __createJTitle);
			createJPushButtonBtn = createItemBtn("JPushButton", __createJPushButton);
			createJCheckBoxBtn = createItemBtn("JCheckBox", __createJCheckBox);
			createJRadioButtonBtn = createItemBtn("JRadioButton", __createJRadioButton);
			createJListBtn = createItemBtn("JList", __createJList);
			createJListItemBtn = createItemBtn("JListItem", __createJListItem);
			createJComboBoxBtn = createItemBtn("JComboBox", __createJComboBox);
			createJScrollBarHBtn = createItemBtn("JScrollBarH", __createJScrollBarH);
			createJScrollBarVBtn = createItemBtn("JScrollBarV", __createJScrollBarV);
			createJScrollSliderHBtn = createItemBtn("JScrollSliderH", __createJScrollSliderH);
			createJScrollSliderVBtn = createItemBtn("JScrollSliderV", __createJScrollSliderV);
			createJSliderHBtn = createItemBtn("JSliderH", __createJSliderH);
			createJSliderVBtn = createItemBtn("JSliderV", __createJSliderV);
			createJCalendarBtn = createItemBtn("JCalendar", __createJCalendar);
		}
		
		private var btnNum:int = 0;
		private function createItemBtn(caption:String, cb:Function):JPushButton
		{
			var btn:JPushButton = new JPushButton(caption, cb);
			var skin:JPushButtonSkin = new JPushButtonSkin();
			skin.labelFormat = new JTextFormat(null, 12, Builder.LAKE_BLUE, false);
			skin.apply(btn);
			btn.setSize(BTN_W, BTN_H);
			btn.move(0, (BTN_H+BTN_GAP)*btnNum);
			scr.addChild(btn);
			btnNum++;
			return btn;
		}
		
		override protected function paint():void
		{
			super.paint();
			scr.setSize(Math.max(W-2*MARGIN-12,1), Math.max(H-2*MARGIN-12,1));
		}
		
		public function enableBtns():void
		{
			var enabled:Boolean = (Builder.doc != null);
			createJFrameBtn.enabled = enabled;
			createJPanelBtn.enabled = enabled;
			createJScrollPanelBtn.enabled = enabled;
			createJImageBtn.enabled = enabled;
			createJLabelBtn.enabled = enabled;
			createJInputTextBtn.enabled = enabled;
			createJTextBtn.enabled = enabled;
			createJTextAreaBtn.enabled = enabled;
			createJTitleBtn.enabled = enabled;
			createJPushButtonBtn.enabled = enabled;
			createJCheckBoxBtn.enabled = enabled;
			createJRadioButtonBtn.enabled = enabled;
			createJListBtn.enabled = enabled;
			createJListItemBtn.enabled = enabled;
			createJComboBoxBtn.enabled = enabled;
			createJScrollBarHBtn.enabled = enabled;
			createJScrollBarVBtn.enabled = enabled;
			createJScrollSliderHBtn.enabled = enabled;
			createJScrollSliderVBtn.enabled = enabled;
			createJSliderHBtn.enabled = enabled;
			createJSliderVBtn.enabled = enabled;
			createJCalendarBtn.enabled = enabled;
		}
		
		private function __createJFrame(e:MouseEvent):void
		{
			var frame:CsFrame = new CsFrame();
			Builder.addShell(frame);
		}
		
		private function __createJPanel(e:MouseEvent):void
		{
			var panel:CsPanel = new CsPanel();
			Builder.addShell(panel);
		}
		
		private function __createJScrollPanel(e:MouseEvent):void
		{
			var scrollPanel:CsScrollPanel = new CsScrollPanel();
			Builder.addShell(scrollPanel);
		}
		
		private function __createJImage(e:MouseEvent):void
		{
			var image:CsImage = new CsImage();
			Builder.addShell(image);
		}
		
		private function __createJLabel(e:MouseEvent):void
		{
			var label:CsLabel = new CsLabel();
			Builder.addShell(label);
		}
		
		private function __createJLink(e:MouseEvent):void
		{
			var link:CsLink = new CsLink();
			Builder.addShell(link);
		}
		
		private function __createJInputText(e:MouseEvent):void
		{
			var inputText:CsInputText = new CsInputText();
			Builder.addShell(inputText);
		}
		
		private function __createJText(e:MouseEvent):void
		{
			var text:CsText = new CsText();
			Builder.addShell(text);
		}
		
		private function __createJTextArea(e:MouseEvent):void
		{
			var textArea:CsTextArea = new CsTextArea();
			Builder.addShell(textArea);
		}
		
		private function __createJTitle(e:MouseEvent):void
		{
			var title:CsTitle = new CsTitle();
			Builder.addShell(title);
		}
		
		private function __createJPushButton(e:MouseEvent):void
		{
			var pushButton:CsPushButton = new CsPushButton();
			Builder.addShell(pushButton);
		}
		
		private function __createJCheckBox(e:MouseEvent):void
		{
			var checkBox:CsCheckBox = new CsCheckBox();
			Builder.addShell(checkBox);
		}
		
		private function __createJRadioButton(e:MouseEvent):void
		{
			var radioButton:CsRadioButton = new CsRadioButton();
			Builder.addShell(radioButton);
		}
		
		private function __createJList(e:MouseEvent):void
		{
			var list:CsList = new CsList();
			Builder.addShell(list);
		}
		
		private function __createJListItem(e:MouseEvent):void
		{
			var listItem:CsListItem = new CsListItem();
			Builder.addShell(listItem);
		}
		
		private function __createJComboBox(e:MouseEvent):void
		{
			var comboBox:CsComboBox = new CsComboBox();
			Builder.addShell(comboBox);
		}
		
		private function __createJScrollBarH(e:MouseEvent):void
		{
			var scrollBar:CsScrollBar = new CsScrollBar(JuiConst.HORIZONTAL);
			Builder.addShell(scrollBar);
		}
		
		private function __createJScrollBarV(e:MouseEvent):void
		{
			var scrollBar:CsScrollBar = new CsScrollBar(JuiConst.VERTICAL);
			Builder.addShell(scrollBar);
		}
		
		private function __createJScrollSliderH(e:MouseEvent):void
		{
			var scrollSlider:CsScrollSlider = new CsScrollSlider(JuiConst.HORIZONTAL);
			Builder.addShell(scrollSlider);
		}
		
		private function __createJScrollSliderV(e:MouseEvent):void
		{
			var scrollSlider:CsScrollSlider = new CsScrollSlider(JuiConst.VERTICAL);
			Builder.addShell(scrollSlider);
		}
		
		private function __createJSliderH(e:MouseEvent):void
		{
			var slider:CsSlider = new CsSlider(JuiConst.HORIZONTAL);
			Builder.addShell(slider);
		}
		
		private function __createJSliderV(e:MouseEvent):void
		{
			var slider:CsSlider = new CsSlider(JuiConst.VERTICAL);
			Builder.addShell(slider);
		}
		
		private function __createJCalendar(e:MouseEvent):void
		{
			var calendar:CsCalendar = new CsCalendar();
			Builder.addShell(calendar);
		}
		
	}
}