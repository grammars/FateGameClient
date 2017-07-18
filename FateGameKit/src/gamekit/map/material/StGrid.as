package gamekit.map.material
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;

	public class StGrid extends AStarNode
	{
		//** 是否是阻碍点 [在AStarNode中] */
		//public var isBlock:Boolean = false;
		/** 是否是遮罩点 */
		public var isMask:Boolean = false;
		/** 是否是摆摊点 */
		public var isStall:Boolean = false;
		/** 是否是传送点 */
		public var isDeliver:Boolean = false;
		/** 传送点数值 */
		public var deliverVal:int = 0;
		/** 是否是数字标识位 */
		public var isNumTag:Boolean = false;
		/** 数字标识位的数值 */
		public var numTagVal:int = 0;
		
		public function StGrid()
		{
		}
		
		public function encode():ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			var bt:int = 0;
			if(isBlock == true) { bt += 1; }
			if(isMask == true) { bt += 2; }
			if(isStall == true) { bt += 4; }
			if(isDeliver == true) { bt += 8; }
			if(isNumTag == true) { bt += 16; }
			bytes.writeByte(bt);
			bytes.writeShort(deliverVal);
			bytes.writeShort(numTagVal);
			return bytes;
		}
		
		public function decode(bytes:ByteArray):Boolean
		{
			if(bytes.bytesAvailable < 5) 
			{
				return false;
			}
			var bt:int = bytes.readByte();
			if(bt & 1) { isBlock = true; } else { isBlock = false; }
			if(bt & 2) { isMask = true; } else { isMask = false; }
			if(bt & 4) { isStall = true; } else { isStall = false; }
			if(bt & 8) { isDeliver = true; } else { isDeliver = false; }
			if(bt & 16) { isNumTag = true; } else { isNumTag = false; }
			deliverVal = bytes.readShort();
			numTagVal = bytes.readShort();
			return true;
		}
		
	}
}