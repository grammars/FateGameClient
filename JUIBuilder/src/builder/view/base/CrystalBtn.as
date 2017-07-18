package builder.view.base
{
	import builder.Builder;
	
	import com.anstu.jui.controls.JPushButton;
	import com.anstu.jui.skin.JPushButtonSkin;
	
	public class CrystalBtn extends JPushButton
	{
		protected var w:int = 1;
		protected var h:int = 1;
		
		public function CrystalBtn(label:String="", defaultHandler:Function=null, w:int=65, h:int=25)
		{
			this.w = w;
			this.h = h;
			super(label, defaultHandler);
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			new JPushButtonSkin().apply(this);
			this.label.textFormat.color = Builder.LAKE_BLUE;
		}
		
		override protected function init():void
		{
			super.init();
			setSize(w, h);
		}
		
	}
}