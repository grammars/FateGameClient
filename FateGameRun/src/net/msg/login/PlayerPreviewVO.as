package net.msg.login
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;

	public class PlayerPreviewVO
	{
		/** 唯一id */
		public var uid:Long;
		/** 地图id */
		public var mapId:int;
		/** 地图x */
		public var mapX:int;
		/** 地图y */
		public var mapY:int;
		/** 外观 */
		public var look:String;
		
		/** 是否存活 */
		public var alive:Boolean;
		/** 名字 */
		public var name:String;
		/** 性别 */
		public var sex:int;
		/** 职业 */
		public var voc:int;
		/** 等级 */
		public var level:int;
		
		/** 所属账号 */
		public var account:String;
		/** 上次登录时间 */
		public var lastLoginTime:Long;
		/** 创建时间 */
		public var createTime:Long;
		
		public function PlayerPreviewVO()
		{
		}
		
		/** 从IoBuffer读出 */
		public function read(bytes:ByteArray):void
		{
			uid = EndianFacade.readLong(bytes);
			mapId = EndianFacade.readInt(bytes);
			mapX = EndianFacade.readInt(bytes);
			mapY = EndianFacade.readInt(bytes);
			look = EndianFacade.readMultiByte(bytes);
			alive = EndianFacade.readBoolean(bytes);
			name = EndianFacade.readMultiByte(bytes);
			sex = EndianFacade.readByte(bytes);
			voc = EndianFacade.readByte(bytes);
			level = EndianFacade.readInt(bytes);
			account = EndianFacade.readMultiByte(bytes);
			lastLoginTime = EndianFacade.readLong(bytes);
			createTime = EndianFacade.readLong(bytes); 
		}
		
	}
}