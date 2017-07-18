package run.info
{
	import central.Centre;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.skin.JPanelSkin;
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	import gamekit.layer.Layer;
	
	import ui.skin.font.DefaultFont;
	import ui.skin.pane.ModernPaneSkin;
	
	public class InfoNotice extends JPanel
	{
		private static const MARGIN:int = 6;
		
		private var label:JLabel = new JLabel();
		
		public function InfoNotice()
		{
			super();
			
			label.textFormat = DefaultFont.create();
			this.addChild(label);
			ModernPaneSkin.instance.apply(this);
		}
		
		public function show(content:String):void
		{
			label.useHtml = true;
			label.usePack = true;
			label.useStroke = true;
			label.text = content;
			
			label.draw();
			//label.drawRect(0xffffff, 0.3, 0x00ff00, 0.8);
			//label.textField.border = true;
			
			label.x = label.y = MARGIN;
			this.setSize(label.width+2*MARGIN, label.height+2*MARGIN);
			
			this.x = (Centre.stage.stageWidth - this.width) / 2;
			this.y = 100;
			Layer.alert.addChild(this);
			setTimeout(__easeOut, 1000);
		}
		
		private function __easeOut():void
		{
			TweenMax.to(this, 1, {y:0, alpha:0.0, ease: Circ.easeOut, onComplete: __tweenOver});
		}
		
		private function __tweenOver():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
		
	}
}