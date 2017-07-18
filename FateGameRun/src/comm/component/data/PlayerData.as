package comm.component.data
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;

	public class PlayerData extends CreatureData
	{
		/** 所属账号 */
		public var account:String;
		/** 武器外观 */
		public var weaponLook:String;
		/** PK模式 */
		public var pkMode:int;
		/** 经验 */
		public var exp:Long;
		/** 上次登录时间 */
		public var lastLoginTime:Date = new Date();
		/** 创建时间 */
		public var createTime:Date = new Date();
		
		/** 结构对应Server的Player.java
		 * {仅含Player.java中的部分，个人非公开数据存在HeroData中} */
		public function PlayerData()
		{
			super();
		}
		
		override public function read(bytes:ByteArray):void
		{
			super.read(bytes);
			
			account = EndianFacade.readMultiByte(bytes);
			weaponLook = EndianFacade.readMultiByte(bytes);
			pkMode = EndianFacade.readInt(bytes);
			exp = EndianFacade.readLong(bytes);
			lastLoginTime.time = EndianFacade.readLong(bytes).toNumber();
			createTime.time = EndianFacade.readLong(bytes).toNumber();
		}
	}
}