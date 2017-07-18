package run.login
{
	import com.anstu.jsock.utils.MD5;

	public class StLoginInfo
	{
		/** 密钥 */
		private static const SKEY:String = "abc123";
		
		/** 用户名 */
		public var account:String = "";
		/** 时间戳 */
		public var timestamp:String = "";
		/** ip */
		public var srvIP:String = "";
		/** port */
		public var srvPort:int = 0;
		
		/** sign */
		public var sign:String = "";
		
		public function StLoginInfo()
		{
			timestamp = new Date().time.toString();
		}
		
		/** 获得sign */
		public function createSign():String
		{
			var source:String = SKEY + "_" + account + "_" + timestamp;
			sign = MD5.hash(source).toUpperCase();
			return sign;
		}
		
	}
}