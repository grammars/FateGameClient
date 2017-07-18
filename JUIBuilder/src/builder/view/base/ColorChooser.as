package builder.view.base
{
	import builder.Builder;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JSliderSkin;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ColorChooser extends JPanel
	{
		private var R:int = 0;
		private var G:int = 0;
		private var B:int = 0;
		
		private var slideR:JSlider;
		private var slideG:JSlider;
		private var slideB:JSlider;
		
		private var color:uint = 0;
		
		private var colorShape:Shape = new Shape();
		
		private var handler:Function = null;
		
		public function ColorChooser(handler:Function = null)
		{
			super();
			
			this.handler = handler;
			
			this.bgAlpha = 0;
			this.setSize(220, 60);
			
			slideR = createSlider("R:", __slideR, 0);
			slideG = createSlider("G:", __slideG, 20);
			slideB = createSlider("B:", __slideB, 40);
			
			colorShape.x = 180;
			colorShape.y = 0;
			this.addChild(colorShape);
			
			paint();
		}
		
		private function createSlider(label:String, hander:Function, py:int):JSlider
		{
			var desc:CrystalLabel = new CrystalLabel(label, 20, 20, 14);
			//desc.useFrame = true;
			desc.move(0, py);
			this.addChild(desc);
			var slider:JSlider = new JSlider(JuiConst.HORIZONTAL, hander);
			//slider.useFrame = true;
			new JSliderSkin().apply(slider);
			slider.maximum = 255;
			slider.width = 160;
			slider.move(20, py+2);
			this.addChild(slider);
			return slider;
		}
		
		private function __slideR(e:Event):void
		{
			R = slideR.value;
			paint();
		}
		
		private function __slideG(e:Event):void
		{
			G = slideG.value;
			paint();
		}
		
		private function __slideB(e:Event):void
		{
			B = slideB.value;
			paint();
		}
		
		private function paint():void
		{
			color = (R << 16) + (G << 8) + B;
			colorShape.graphics.clear();
			colorShape.graphics.lineStyle(2, Builder.DARK_GREY);
			colorShape.graphics.beginFill(color);
			colorShape.graphics.drawRect(0, 0, 40, 60);
			colorShape.graphics.endFill();
			
			if(handler != null)
			{
				handler(color);
			}
		}
		
	}
}