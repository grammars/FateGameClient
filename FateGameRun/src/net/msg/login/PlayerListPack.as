package net.msg.login
{
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class PlayerListPack
	{
		public var p0:PlayerPreviewVO;
		public var p1:PlayerPreviewVO;
		public var p2:PlayerPreviewVO;
		
		public var list:Vector.<PlayerPreviewVO> = new Vector.<PlayerPreviewVO>();
		
		public function PlayerListPack()
		{
		}
		
		public function read(bytes:ByteArray):void
		{
			list.length = 0;
			var size:int = EndianFacade.readByte(bytes);
			if(size >= 1)
			{
				p0 = new PlayerPreviewVO();
				p0.read(bytes);
				list.push(p0);
			}
			if(size >= 2)
			{
				p1 = new PlayerPreviewVO();
				p1.read(bytes);
				list.push(p1);
			}
			if(size >= 3)
			{
				p2 = new PlayerPreviewVO();
				p2.read(bytes);
				list.push(p2);
			}
		}
		
		public function toString():String
		{
			var ret:String = "";
			if(p0) { ret += " p0:" + p0; }
			if(p1) { ret += " p1:" + p1; }
			if(p2) { ret += " p2:" + p2; }
			return  ret;
		}
		
	}
}