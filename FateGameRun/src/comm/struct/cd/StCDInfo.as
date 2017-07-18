package comm.struct.cd
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;
	
	import gamekit.utils.Utils;

	public class StCDInfo
	{
		/** 技能还是物品，取自CDUnit.T_Xxxx的类型 */
		public var type:int;
		/** 对应技能或者物品的模版id */
		public var id:int;
		/** cd总耗时 */
		public var cdTime:int;
		/** cd完成时间 */
		public var finishTime:Number;
		
		public function StCDInfo()
		{
		}
		
		/** 从bytes读出 */
		public function read(bytes:ByteArray):StCDInfo
		{
			type = EndianFacade.readByte(bytes);
			id = EndianFacade.readInt(bytes);
			cdTime = EndianFacade.readInt(bytes);
			finishTime = EndianFacade.readLong(bytes).toNumber();//这个告诉的服务器时间
			var leftCDTime:int = EndianFacade.readInt(bytes);
			finishTime = Utils.now()+leftCDTime;//但是客户端比较适合用自己的时间加上相对剩余CD时间来处理
			return this;
		}
	}
}