package builder.view.prop.item.tpl
{
	import com.anstu.jui.build.BU;
	import builder.view.prop.item.PropItemBase;
	import builder.view.template.TemplateBrowser;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.MouseEvent;
	
	public class PITemplate extends PropItemBase
	{
		public var type:String;
		
		private var valueLabel:JLabel;
		private var browseBtn:JPushButton;
		
		private var _value:String = "";
		public function set value(v:String):void
		{
			_value = v;
			valueLabel.text = v;
		}
		public function get value():String { return _value; }
		
		public function available():Boolean
		{
			return BU.available(_value);
		}
		
		public function PITemplate(type:String, noteContent:String, hasMargin:Boolean=true)
		{
			this.type = type;
			super(noteContent, hasMargin);
		}
		
		override protected function setParam():void
		{
			mainW = noteW = 270;
			mainH = 40;
			noteH = 30;
		}
		
		override protected function addChildren():void
		{
			super.addChildren();
			
			valueLabel = createEasyLabel("", 200, 30, 0, 0);
			browseBtn = createEasyBtn("浏览", __browseBtn, 60, 30, 200, 0);
		}
		
		private function __browseBtn(e:MouseEvent):void
		{
			TemplateBrowser.instance.select(this);
		}
	}
}