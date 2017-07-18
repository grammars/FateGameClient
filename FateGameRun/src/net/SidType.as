package net
{
	/** 会话身份类型 */
	public class SidType
	{
		/** 客户端 */
		public static const CLIENT:int = 0;
		
		/** 登陆服 */
		public static const LOGIN:int = 1;
		
		/** 网关服 */
		public static const GATE:int = 2;
		
		/** 游戏服 */
		public static const GAME:int = 4;
		
		/** 数据服 */
		public static const DATA:int = 8;
		
		public function SidType()
		{
		}
	}
}