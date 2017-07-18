package struct
{
	import flash.geom.Rectangle;

	public class StPic
	{
		public var picName:String;
		public var rect:Rectangle;
		public var oriWidth:int;
		public var oriHeight:int;
		
		public function StPic(picName:String, rect:Rectangle, oriWidth:int, oriHeight:int)
		{
			this.picName = picName;
			this.rect = rect;
			this.oriWidth = oriWidth;
			this.oriHeight = oriHeight;
		}
		
		public function getXmlNode():String
		{
			return '<' + picName + ' width="' + oriWidth + '" height="' + oriHeight + 
				'" offx="' + rect.x + '" offy="' + rect.y + '" />';
		}
		
	}
}