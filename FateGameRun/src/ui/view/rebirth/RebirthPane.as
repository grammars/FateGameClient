package ui.view.rebirth
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.controls.JTitle;
	import com.anstu.jui.define.JuiConst;
	
	import comm.L;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.formats.TextAlign;
	
	import gamekit.layer.Layer;
	
	import run.scene.avatar.CreatureAvt;
	
	import ui.skin.font.DefaultFont;
	import ui.skin.pane.TipClassicPaneSkin;
	import ui.skin.pushButton.CommOrangeBtnSkin;
	import ui.view.BasePane;
	import ui.view.IBasePane;
	
	public class RebirthPane extends BasePane
	{
		private static var _instance:RebirthPane;
		public static function get instance():RebirthPane
		{
			if(_instance == null) { _instance = new RebirthPane(); }
			return _instance;
		}
		
		public function setKiller(killerName:String):void
		{
			var content:String = "<font color='#ffecb9'>你被</font><font color='#cf1221'>" + killerName
				+ "</font><font color='#ffecb9'>击杀了</font>";
			descLabel.text = content;
		}
		
		private var descLabel:JLabel;
		private var exeHereBtn:JPushButton;
		private var exeHomeBtn:JPushButton;
		
		public function RebirthPane()
		{
			super();
			
			this.layer = Layer.alert;
			
			TipClassicPaneSkin.instance.apply(this);
			this.setSize(360, 175);
			
			var label:JLabel;
			var fmt:JTextFormat;
			
			var title:JTitle = new JTitle(L.T("你阵亡了"));
			fmt = DefaultFont.create();
			fmt.size = 24;
			fmt.bold = true;
			title.textFormat = fmt;
			title.setSize(360, 30);
			title.move(0, 15);
			title.align = JuiConst.CENTER;
			title.valign = JuiConst.MIDDLE;
			this.addChild(title);
			
			descLabel = new JLabel();
			fmt = DefaultFont.create();
			fmt.size = 16;
			fmt.bold = true;
			fmt.letterSpacing = 2.0;
			descLabel.textFormat = fmt;
			descLabel.align = JuiConst.CENTER;
			descLabel.useHtml = true;
			descLabel.useStroke = true;
			descLabel.setSize(360, 60);
			descLabel.move(0, 55);
			this.addChild(descLabel);
			
			exeHereBtn = new JPushButton(L.T("原地复活"), __exeHereBtn);
			exeHereBtn.setSize(120, 30);
			exeHereBtn.move(40, 115);
			CommOrangeBtnSkin.instance.apply(exeHereBtn);
			
			this.addChild(exeHereBtn);
			exeHomeBtn = new JPushButton(L.T("回城复活"), __exeHomeBtn);
			exeHomeBtn.setSize(120, 30);
			exeHomeBtn.move(190, 115);
			CommOrangeBtnSkin.instance.apply(exeHomeBtn);
			this.addChild(exeHomeBtn);
		}
		
		override public function putDefaultPos(e:Event=null):void
		{
			putCentre();
		}
		
		private function __exeHereBtn(e:MouseEvent):void
		{
			//Game.info.notice("请求原地复活");
			Game.rebirth.rebirthHere();
		}
		
		private function __exeHomeBtn(e:MouseEvent):void
		{
			//Game.info.notice("请求回城复活");
			Game.rebirth.rebirthHome();
		}
		
	}
}