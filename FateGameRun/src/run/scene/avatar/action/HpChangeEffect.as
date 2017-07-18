package run.scene.avatar.action
{
	import com.anstu.jui.components.JTextFormat;
	import com.anstu.jui.controls.JLabel;
	import com.greensock.TweenMax;
	import com.greensock.easing.Circ;
	
	import flash.display.Sprite;
	
	import run.scene.avatar.SpriteAvt;
	
	import ui.skin.font.DefaultFont;

	public class HpChangeEffect extends Sprite
	{
		public static function show(target:SpriteAvt, delt:int):void
		{
			var eff:HpChangeEffect = new HpChangeEffect();
			eff.handle(target, delt);
		}
		
		private var label:JLabel = new JLabel();
		
		public function HpChangeEffect()
		{
			super();
		}
		
		public function handle(target:SpriteAvt, delt:int):void
		{
			var color:uint = delt < 0 ? 0xff0000 : 0x00ff00;
			var fmt:JTextFormat = new JTextFormat(DefaultFont.FONT, 16, color, true);
			label.textFormat = fmt;
			label.usePack = true;
			label.useStroke = true;
			label.text = delt < 0 ? ""+delt : "+"+delt;
			label.draw();
			this.addChild(label);
			this.x = -this.width/2;
			this.y = -130;
			target.addChild(this);
			
			easeOut();
		}
		
		private function easeOut():void
		{
			TweenMax.to(this, 1, {y:-150, alpha:0.5, ease: Circ.easeOut, onComplete: __tweenOver});
		}
		
		private function __tweenOver():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
	}
}