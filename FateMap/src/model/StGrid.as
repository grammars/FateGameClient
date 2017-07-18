package model
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;

	public class StGrid
	{
		/** 是否是阻碍点 */
		public var isBlock:Boolean = false;
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
		
		private static var tf:TextField;
		private static var fmt:TextFormat;
		
		{
			tf = new TextField();
			fmt = new TextFormat(null, 12, 0xffffff);
			tf.defaultTextFormat = fmt;
		}
		
		public function StGrid()
		{
		}
		
		private function getMarkCount():int
		{
			var count:int = 0;
			if(isBlock == true && WorkConfig.me().VIEW_BLOCK) { count++; }
			if(isMask == true && WorkConfig.me().VIEW_MASK) { count++; }
			if(isStall == true && WorkConfig.me().VIEW_STALL) { count++; }
			if(isDeliver == true && WorkConfig.me().VIEW_DELIVER) { count++; }
			if(isNumTag == true && WorkConfig.me().VIEW_NUM_TAG) { count++; }
			return count;
		}
		
		public function paint(g:Graphics, tx:int, ty:int, gw:int, gh:int):void
		{
			if(getMarkCount() <= 0) { return; }
			var averH:int = gh / getMarkCount();
			var curPosY:int = 0;
			var no:int = 0;//记录第几层，用于修正积累性长度差
			var cache:BitmapData;
			if(isBlock == true && WorkConfig.me().VIEW_BLOCK)
			{
				if(++no >= getMarkCount()) { averH = gh - averH*(no-1); }
				g.beginFill(0xff3b48, 0.6);
				g.drawRect(tx, ty+curPosY, gw, averH);
				g.endFill();
				curPosY += averH;
			}
			if(isMask == true && WorkConfig.me().VIEW_MASK)
			{
				if(++no >= getMarkCount()) { averH = gh - averH*(no-1); }
				g.beginFill(0x68c428, WorkConfig.me().DRAW_ALPHA);
				g.drawRect(tx, ty+curPosY, gw, averH);
				g.endFill();
				curPosY += averH;
			}
			if(isStall == true && WorkConfig.me().VIEW_STALL)
			{
				if(++no >= getMarkCount()) { averH = gh - averH*(no-1); }
				g.beginFill(0xe98139, WorkConfig.me().DRAW_ALPHA);
				g.drawRect(tx, ty+curPosY, gw, averH);
				g.endFill();
				curPosY += averH;
			}
			if(isDeliver == true && WorkConfig.me().VIEW_DELIVER)
			{
				if(++no >= getMarkCount()) { averH = gh - averH*(no-1); }
				g.beginFill(0x3681d5, WorkConfig.me().DRAW_ALPHA);
				g.drawRect(tx, ty+curPosY, gw, averH);
				g.endFill();
				tf.text = deliverVal.toString();
				cache = new BitmapData(gw, gh, true, 0x00000000);
				cache.draw(tf, new Matrix(1,0,0,1,0,curPosY));
				g.beginBitmapFill(cache);
				g.drawRect(tx, ty+curPosY, gw, averH);
				g.endFill();
				curPosY += averH;
			}
			if(isNumTag == true && WorkConfig.me().VIEW_NUM_TAG)
			{
				if(++no >= getMarkCount()) { averH = gh - averH*(no-1); }
				g.beginFill(0xbd17a6, WorkConfig.me().DRAW_ALPHA);
				g.drawRect(tx, ty+curPosY, gw, averH);
				g.endFill();
				tf.text = numTagVal.toString();
				cache = new BitmapData(gw, gh, true, 0x00000000);
				cache.draw(tf, new Matrix(1,0,0,1,0,curPosY));
				g.beginBitmapFill(cache);
				g.drawRect(tx, ty+curPosY, gw, averH);
				g.endFill();
				curPosY += averH;
			}
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