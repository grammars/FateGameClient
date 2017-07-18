package comm.struct.login
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;

	public class StAccountInfo
	{
		/** 账号id */
		public var uid:String;
		/** 角色0 id */
		public var playeruid0:Long;
		/** 角色1 id */
		public var playeruid1:Long;
		/** 角色2 id */
		public var playeruid2:Long;
		
		public function StAccountInfo()
		{
		}
		
		
		/** 在数据库中是否存在 */
		public function exist():Boolean
		{
			return uid != null;
		}
		
		/** 是否有角色 */
		public function hasPlayer():Boolean
		{
			return playeruid0.compareNum(0) != 0 || playeruid1.compareNum(0) != 0 || playeruid2.compareNum(0) != 0 ;
		}
		
		/** 从消息读出 */
		public function readMsg(bytes:ByteArray):void
		{
			//Utils.dumpBytes(bytes);
			uid = EndianFacade.readMultiByte(bytes);
			playeruid0 = new Long().readFrom(bytes);
			playeruid1 = new Long().readFrom(bytes);
			playeruid2 = new Long().readFrom(bytes);
		}
		
		public function toString():String
		{
			return "uid=" + uid + " playeruid0= " + playeruid0.toNumber() 
				+ " playeruid1=" + playeruid1.toNumber() + " playeruid2=" + playeruid2.toNumber();
		}
		
	}
}