package builder.view
{
	import builder.Builder;
	import builder.ctrls.*;
	import builder.view.base.*;
	import builder.view.prop.*;
	import builder.view.prop.rc.*;
	
	import com.anstu.jui.build.*;
	import com.anstu.jui.build.ctrls.*;
	import com.anstu.jui.build.ctrls.base.*;
	import com.anstu.jui.controls.*;
	import com.anstu.jui.skin.*;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PropBox extends Popup
	{
		private static var _instance:PropBox;
		public static function get instance():PropBox
		{
			if(_instance == null) { _instance = new PropBox(); }
			return _instance;
		}
		
		private var scroll:JScrollPanel = new JScrollPanel();
		private var applyBtn:JPushButton = new JPushButton();
		
		private var propWnd:PropBase;
		
		public function PropBox()
		{
			super();
			
			this.setTitle("编辑属性");
			
			this.setIconifiedSize(160, 200);
			this.setNormalSize(300, 600);
			this.setMaximizeSize(500, 800);
			
			applyBtn = new JPushButton("应用", __applyBtn);
			new JPushButtonSkin().apply(applyBtn);
			applyBtn.label.textFormat.color = Builder.LAKE_BLUE;
			applyBtn.move(10, 30);
			this.addChild(applyBtn);
			
			new JScrollPanelSkin().apply(scroll);
			scroll.autoHideScrollBar = false;
			scroll.move(10, 65);
			scroll.frameLineColor = Builder.LAKE_BLUE;
			scroll.frameLineAlpha = 1;
			scroll.frameLineThick = 3;
			scroll.frameFillColor = 0xffffff;
			scroll.frameFillAlpha = 1;
			scroll.frameRound = 10;
			scroll.useFrame = true;
			this.addChild(scroll);
			
			this.sizeMode = JFrame.SIZE_NORMAL;
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			applyBtn.width = Math.max(10,w-20);
			scroll.width = Math.max(10,w-35);
		}
		
		override public function set height(h:Number):void
		{
			super.height = h;
			applyBtn.height = 30;
			scroll.height = Math.max(10, h-95);
		}
		
		private function __applyBtn(e:MouseEvent):void
		{
			if(propWnd)
			{
				propWnd.apply();
			}
		}
		
		public function parentUpdate():void
		{
			scroll.clearContent();
			propWnd = null;
			var shell:CShell = Builder.getTarget();
			if(shell == null)
			{
				PropContainer.instance.print();
				propWnd = PropContainer.instance;
			}
			else if(shell is CsCalendar)
			{
				PropCalendar.instance.print(shell);
				propWnd = PropCalendar.instance;
			}
			else if(shell is CsCheckBox)
			{
				PropCheckBox.instance.print(shell);
				propWnd = PropCheckBox.instance;
			}
			else if(shell is CsComboBox)
			{
				PropComboBox.instance.print(shell);
				propWnd = PropComboBox.instance;
			}
			else if(shell is CsFrame)
			{
				PropFrame.instance.print(shell);
				propWnd = PropFrame.instance;
			}
			else if(shell is CsImage)
			{
				PropImage.instance.print(shell);
				propWnd = PropImage.instance;
			}
			else if(shell is CsInputText)
			{
				PropInputText.instance.print(shell);
				propWnd = PropInputText.instance;
			}
			else if(shell is CsLabel)
			{
				PropLabel.instance.print(shell);
				propWnd = PropLabel.instance;
			}
			else if(shell is CsLink)
			{
				PropLink.instance.print(shell);
				propWnd = PropLink.instance;
			}
			else if(shell is CsList)
			{
				PropList.instance.print(shell);
				propWnd = PropList.instance;
			}
			else if(shell is CsListItem)
			{
				PropListItem.instance.print(shell);
				propWnd = PropListItem.instance;
			}
			else if(shell is CsPanel)
			{
				PropPanel.instance.print(shell);
				propWnd = PropPanel.instance;
			}
			else if(shell is CsPushButton)
			{
				PropPushButton.instance.print(shell);
				propWnd = PropPushButton.instance;
			}
			else if(shell is CsRadioButton)
			{
				PropRadioButton.instance.print(shell);
				propWnd = PropRadioButton.instance;
			}
			else if(shell is CsScrollBar)
			{
				PropScrollBar.instance.print(shell);
				propWnd = PropScrollBar.instance;
			}
			else if(shell is CsScrollPanel)
			{
				PropScrollPanel.instance.print(shell);
				propWnd = PropScrollPanel.instance;
			}
			else if(shell is CsScrollSlider)
			{
				PropScrollSlider.instance.print(shell);
				propWnd = PropScrollSlider.instance;
			}
			else if(shell is CsSlider)
			{
				PropSlider.instance.print(shell);
				propWnd = PropSlider.instance;
			}
			else if(shell is CsText)
			{
				PropText.instance.print(shell);
				propWnd = PropText.instance;
			}
			else if(shell is CsTextArea)
			{
				PropTextArea.instance.print(shell);
				propWnd = PropTextArea.instance;
			}
			else if(shell is CsTitle)
			{
				PropTitle.instance.print(shell);
				propWnd = PropTitle.instance;
			}
			
			if(propWnd)
			{
				scroll.addChild(propWnd);
			}
		}
	}
}