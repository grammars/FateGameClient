package builder.view.prop.item
{
	import builder.view.prop.item.parts.PicChooser;
	import builder.view.prop.item.parts.SliderValue;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JComboBox;
	import com.anstu.jui.controls.JInputText;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JSlider;

	public class PIImage extends PropItemBase
	{
		protected var bgAlphaSlider:SliderValue;
		
		protected var bgColorPI:PIPair;
		
		protected var bgFillerChooser:PicChooser;
		
		protected var fillOptDrop:PIDrop;
		
		public function setBgAlpha(value:String):void { bgAlphaSlider.setValue( parseFloat(value) ); }
		public function getBgAlpha():String { return bgAlphaSlider.getValue().toString(); }
		
		public function setBgColor(value:String):void { bgColorPI.setValue(value); }
		public function getBgColor():String { return bgColorPI.getValue(); }
		
		public function setBgFill(value:String):void { bgFillerChooser.setValue(value); }
		public function getBgFill():String { return bgFillerChooser.getValue(); }
		
		public function setFillOpt(value:String):void { fillOptDrop.setValue(value); }
		public function getFillOpt():String { return fillOptDrop.getValue(); }
		
		public function PIImage(noteContent:String=null)
		{
			super(noteContent);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 460;
			mainH = 120;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			bgAlphaSlider = createSlider(130, "bgAlpha:", 0, 1, 0, 0);
			bgColorPI = new PIPair(130, "bgColor:");
			bgColorPI.move(135, 0);
			addToMain(bgColorPI);
			bgFillerChooser = createPicChooser("bgFiller:", 0, 60);
			
			fillOptDrop = new PIDrop(200, "fillOpt:", ["null", JResource.OPT_TILE_SINGLE, JResource.OPT_TILE_REPEAT]);
			fillOptDrop.move(0, 90);
			addToMain(fillOptDrop);
		}
		
	}
}