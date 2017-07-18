package builder.view.prop.item
{
	import builder.view.prop.item.parts.PicChooser;

	public class PIFill extends PropItemBase
	{
		private var filler:PicChooser;
		
		private var desc:String;
		
		public function setFill( value:String ):void
		{
			filler.setValue(value);
		}
		public function getFill():String { return filler.getValue(); }
		
		public function PIFill(desc:String, noteContent:String=null, hasMargin:Boolean=false)
		{
			this.desc = desc;
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 460;
			mainH = 40;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			filler = createPicChooser(desc, 0, 5);
		}
	}
}