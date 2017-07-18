package ui.view.chatBox
{
	import central.Centre;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.build.JFactory;
	import com.anstu.jui.components.JRadioGroup;
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JImage;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JRadioButton;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JPushButtonSkin;
	import com.anstu.jui.skin.JRadioButtonSkin;
	
	import comm.L;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import gamekit.layer.Layer;
	
	import ui.skin.font.DefaultFont;
	import ui.skin.scrollPane.DefaultScrollPaneSkin;
	import ui.view.IBasePane;
	import ui.view.ViewWnd;
	
	public class ChatBoxPane extends ViewWnd
	{
		private var scrollPane:JScrollPanel;
		private var resizeBtn:JCheckBox;
		private var mixTab:JRadioButton;
		private var privateTab:JRadioButton;
		private var teamTab:JRadioButton;
		private var familyTab:JRadioButton;
		private var systemTab:JRadioButton;
		private var worldTab:JRadioButton;
		private var bulletinTab:JRadioButton;
		
		public function ChatBoxPane()
		{
			super();
		}
		
		/** 初始化 */
		override protected function init():void
		{
			uiPack = JFactory.create("chat_box");
			pane = uiPack.getCtrl("root");
			scrollPane = uiPack.getScrollPanel("scrollPane");
			resizeBtn = uiPack.getCheckBox("resizeBtn");
			mixTab = uiPack.getRadioButton("mixTab");
			privateTab = uiPack.getRadioButton("privateTab");
			teamTab = uiPack.getRadioButton("teamTab");
			familyTab = uiPack.getRadioButton("familyTab");
			systemTab = uiPack.getRadioButton("systemTab");
			worldTab = uiPack.getRadioButton("worldTab");
			bulletinTab = uiPack.getRadioButton("bulletinTab");
			
			scrollPane.autoHideScrollBar = true;
			resizeBtn.addEventListener(Event.CHANGE, __resize);
			pane.addEventListener(MouseEvent.CLICK, __paneClick);
		}
		
		
		/** 放到默认位置 */
		override public function putDefaultPos(event:Event=null):void
		{
			if(pane)
			{
				pane.x = 0;
				pane.y = Centre.stage.stageHeight - pane.height - 110;
			}
		}
		
		private function __resize(e:Event):void
		{
			
		}
		
		private function __paneClick(e:MouseEvent):void
		{
			if(e.target == pane || e.target == scrollPane.background)
			{
				doMapClick(e);
			}
		}
		
		/** 将鼠标点击传递给地图 */
		private function doMapClick(e:MouseEvent):void
		{
			var gp:Point = new Point(Centre.stage.mouseX, Centre.stage.mouseY);
			var lp2map:Point = Layer.map.globalToLocal(gp);
			e.localX = lp2map.x;
			e.localY = lp2map.y;
			Layer.map.dispatchEvent(e);
		}
		
	}
}