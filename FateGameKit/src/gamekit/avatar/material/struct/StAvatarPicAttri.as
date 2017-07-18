package gamekit.avatar.material.struct
{
	public class StAvatarPicAttri
	{
		public var width:int = 0;
		public var height:int = 0;
		public var offsetX:int = 0;
		public var offsetY:int = 0;
		
		public function StAvatarPicAttri(w:int, h:int, ofx:int, ofy:int)
		{
			width = w;
			height = h;
			offsetX = ofx;
			offsetY = ofy;
		}
		
		public function toString():String
		{
			return "[StAvatarPicAttri] width=" + width + " height=" + height + " offsetX=" + offsetX + " offsetY=" + offsetY;
		}
	}
}