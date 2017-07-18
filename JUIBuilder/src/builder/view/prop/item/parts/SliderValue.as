package builder.view.prop.item.parts
{
	import builder.Builder;
	import builder.view.prop.item.PIPair;
	
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JSliderSkin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SliderValue extends Sprite
	{
		private var pair:PIPair;
		private var slider:JSlider;
		
		public function SliderValue(totalWidth:int, desc:String, minimum:Number, maximum:Number)
		{
			super();
			
			pair = new PIPair(totalWidth, desc);
			pair.input.addEventListener(Event.CHANGE, __inputChange);
			this.addChild(pair);
			
			slider = new JSlider(JuiConst.HORIZONTAL, __sliderChange);
			new JSliderSkin().apply(slider);
			slider.minimum = minimum;
			slider.maximum = maximum;
			slider.width = totalWidth;
			slider.move(0, 40);
			this.addChild(slider);
			
			updateInput();
		}
		
		private function __inputChange(e:Event):void
		{
			slider.value = getValue();
		}
		
		private function __sliderChange(e:Event):void
		{
			updateInput();
		}
		
		private function updateInput():void
		{
			pair.input.text = slider.value.toString();
		}
		
		public function setValue(val:Number):void
		{
			pair.input.text = val.toString()
			slider.value = val;
		}
		
		public function getValue():Number { return parseFloat(pair.input.text); }
		
	}
}