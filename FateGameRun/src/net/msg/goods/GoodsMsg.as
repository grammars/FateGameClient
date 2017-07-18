package net.msg.goods
{
	import central.Game;
	
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.component.goods.GoodsFactory;
	import comm.component.goods.GoodsInfo;
	import comm.component.goods.GoodsOperEnum;
	import comm.struct.goods.StGoodsContainer;
	
	import flash.utils.ByteArray;
	
	import net.msg.IMessage;
	import net.msg.MsgBuffer;
	
	public class GoodsMsg extends IMessage
	{
		private static var instance:GoodsMsg;
		public static function getInstance():GoodsMsg
		{
			if(instance == null) { instance = new GoodsMsg(); }
			return instance;
		}
		
		/** [物品]主消息号 */
		public static const MID:int = GOODS_MID;
		
		/** game向client通知物品操作异常 */
		private static const OPER_EXCEPTION_G2C:int = 1;
		
		/** game向client通知背包已清空 */
		private static const CLEAR_ITEMS_IN_BAG_G2C:int = 10;
		/** game向client发送初始化背包物品 */
		private static const INIT_ITEMS_TO_BAG_G2C:int = 11;
		/** game向client通知添加物品到背包 */
		private static const ADD_ITEM_TO_BAG_G2C:int = 12;
		/** game向client通知移除物品从背包 */
		private static const REMOVE_ITEM_FROM_BAG_G2C:int = 13;
		/** game向client通知更新背包物品 */
		private static const UPDATE_ITEM_IN_BAG_G2C:int = 14;
		
		/** game向client通知装备已清空 */
		private static const CLEAR_ITEMS_IN_EQUIP_G2C:int = 20;
		/** game向client发送初始化装备 */
		private static const INIT_ITEMS_TO_EQUIP_G2C:int = 21;
		/** game向client通知穿上装备 */
		private static const ADD_ITEM_TO_EQUIP_G2C:int = 22;
		/** game向client通知脱下装备 */
		private static const REMOVE_ITEM_FROM_EQUIP_G2C:int = 23;
		/** game向client通知更新装备物品 */
		private static const UPDATE_ITEM_IN_EQUIP_G2C:int = 24;
		
		/** game向client通知仓库已清空 */
		private static const CLEAR_ITEMS_IN_WAREHOUSE_G2C:int = 30;
		/** game向client发送初始化仓库物品 */
		private static const INIT_ITEMS_TO_WAREHOUSE_G2C:int = 31;
		/** game向client通知添加物品到仓库 */
		private static const ADD_ITEM_TO_WAREHOUSE_G2C:int = 32;
		/** game向client通知移除物品从仓库 */
		private static const REMOVE_ITEM_FROM_WAREHOUSE_G2C:int = 33;
		/** game向client通知更新仓库物品 */
		private static const UPDATE_ITEM_IN_WAREHOUSE_G2C:int = 34;
		
		/** client请求移动物品：从背包到背包 */
		private static const MOVE_ITEM_BAG_TO_BAG_REQ_C2G:int = 41;
		/** client请求移动物品：从背包到仓库 */
		private static const MOVE_ITEM_BAG_TO_WAREHOUSE_REQ_C2G:int = 42;
		/** client请求移动物品：从仓库到仓库 */
		private static const MOVE_ITEM_WAREHOUSE_TO_WAREHOUSE_REQ_C2G:int = 43;
		/** client请求移动物品：从仓库到背包 */
		private static const MOVE_ITEM_WAREHOUSE_TO_BAG_REQ_C2G:int = 44;
		
		/** client请求丢弃背包物品 */
		private static const DROP_ITEM_FROM_BAG_REQ_C2G:int = 51;
		/** client请求拆分背包物品 */
		private static const SPLIT_ITEM_IN_BAG_REQ_C2G:int = 52;
		
		/** client请求穿上装备 */
		private static const PUT_ON_EQUIP_REQ_C2G:int = 61;
		/** client请求脱下装备 */
		private static const TAKE_OFF_EQUIP_REQ_C2G:int = 62;
		
		/** client请求使用物品 */
		private static const USE_ITEM_REQ_C2G:int = 71;
		
		public function GoodsMsg()
		{
			super();
		}
		
		override public function handle(subId:int, bytes:ByteArray):void
		{
			switch(subId)
			{
			case OPER_EXCEPTION_G2C:
				recvOperException_G2C(bytes);
				break;
			
			case CLEAR_ITEMS_IN_BAG_G2C:
				recvClearItemsInBag_G2C(bytes);
				break;
			case INIT_ITEMS_TO_BAG_G2C:
				recvInitItemsToBag_G2C(bytes);
				break;
			case ADD_ITEM_TO_BAG_G2C:
				recvAddItemToBag_G2C(bytes);
				break;
			case REMOVE_ITEM_FROM_BAG_G2C:
				recvRemoveItemFromBag_G2C(bytes);
				break;
			case UPDATE_ITEM_IN_BAG_G2C:
				recvUpdateItemInBag_G2C(bytes);
				break;
			
			case CLEAR_ITEMS_IN_EQUIP_G2C:
				recvClearItemsInEquip_G2C(bytes);
				break;
			case INIT_ITEMS_TO_EQUIP_G2C:
				recvInitItemsToEquip_G2C(bytes);
				break;
			case ADD_ITEM_TO_EQUIP_G2C:
				recvAddItemToEquip_G2C(bytes);
				break;
			case REMOVE_ITEM_FROM_EQUIP_G2C:
				recvRemoveItemFromEquip_G2C(bytes);
				break;
			case UPDATE_ITEM_IN_EQUIP_G2C:
				recvUpdateItemInEquip_G2C(bytes);
				break;
			
			case CLEAR_ITEMS_IN_WAREHOUSE_G2C:
				recvClearItemsInWarehouse_G2C(bytes);
				break;
			case INIT_ITEMS_TO_WAREHOUSE_G2C:
				recvInitItemsToWarehouse_G2C(bytes);
				break;
			case ADD_ITEM_TO_WAREHOUSE_G2C:
				recvAddItemToWarehouse_G2C(bytes);
				break;
			case REMOVE_ITEM_FROM_WAREHOUSE_G2C:
				recvRemoveItemFromWarehouse_G2C(bytes);
				break;
			case UPDATE_ITEM_IN_WAREHOUSE_G2C:
				recvUpdateItemInWarehouse_G2C(bytes);
				break;
			}
		}
		
		/** recv( game向client通知物品操作异常 ) */
		private function recvOperException_G2C(bytes:ByteArray):void
		{
			var errCode:int = EndianFacade.readByte(bytes);
			var containerType:int = EndianFacade.readByte(bytes);
			Game.info.notice( GoodsOperEnum.errMsg(errCode, containerType) );
		}
		
		//=========================Bag=====↓=====================================
		
		/** recv( game向client通知背包已清空 ) */
		private function recvClearItemsInBag_G2C(bytes:ByteArray):void
		{
			Game.hero.bag.clearItems();
		}
		
		/** recv( game向client发送初始化背包物品 ) */
		private function recvInitItemsToBag_G2C(bytes:ByteArray):void
		{
			var data:StGoodsContainer = new StGoodsContainer();
			data.read(bytes);
			Game.hero.bag.importData(data);
		}
		
		/** recv( game向client通知添加物品到背包 ) */
		private function recvAddItemToBag_G2C(bytes:ByteArray):void
		{
			var info:GoodsInfo = GoodsFactory.readInfo(bytes);
			Game.hero.bag.addItem(info);
		}
		
		/** recv( game向client通知移除物品从背包 ) */
		private function recvRemoveItemFromBag_G2C(bytes:ByteArray):void
		{
			var itemUid:Long = EndianFacade.readLong(bytes);
			Game.hero.bag.removeItem(itemUid);
		}
		
		/** recv( game向client通知更新背包物品 ) */
		private function recvUpdateItemInBag_G2C(bytes:ByteArray):void
		{
			var info:GoodsInfo = GoodsFactory.readInfo(bytes);
			Game.hero.bag.updateItem(info);
		}
		
		//=========================Equip=====↓=====================================
		
		/** recv( game向client通知装备已清空 ) */
		private function recvClearItemsInEquip_G2C(bytes:ByteArray):void
		{
			Game.hero.equip.clearItems();
		}
		
		/** recv( game向client发送初始化装备 ) */
		private function recvInitItemsToEquip_G2C(bytes:ByteArray):void
		{
			var data:StGoodsContainer = new StGoodsContainer();
			data.read(bytes);
			Game.hero.equip.importData(data);
		}
		
		/** recv( game向client通知穿上装备 ) */
		private function recvAddItemToEquip_G2C(bytes:ByteArray):void
		{
			var info:GoodsInfo = GoodsFactory.readInfo(bytes);
			Game.hero.equip.addItem(info);
		}
		
		/** recv( game向client通知脱下装备 ) */
		private function recvRemoveItemFromEquip_G2C(bytes:ByteArray):void
		{
			var itemUid:Long = EndianFacade.readLong(bytes);
			Game.hero.equip.removeItem(itemUid);
		}
		
		/** recv( game向client通知更新装备物品 ) */
		private function recvUpdateItemInEquip_G2C(bytes:ByteArray):void
		{
			var info:GoodsInfo = GoodsFactory.readInfo(bytes);
			Game.hero.equip.updateItem(info);
		}
		
		//=========================Warehouse=====↓=====================================
		
		/** recv( game向client通知仓库已清空 ) */
		private function recvClearItemsInWarehouse_G2C(bytes:ByteArray):void
		{
			Game.hero.warehouse.clearItems();
		}
		
		/** recv( game向client发送初始化仓库物品 ) */
		private function recvInitItemsToWarehouse_G2C(bytes:ByteArray):void
		{
			var data:StGoodsContainer = new StGoodsContainer();
			data.read(bytes);
			Game.hero.warehouse.importData(data);
		}
		
		/** recv( game向client通知添加物品到仓库 ) */
		private function recvAddItemToWarehouse_G2C(bytes:ByteArray):void
		{
			var info:GoodsInfo = GoodsFactory.readInfo(bytes);
			Game.hero.warehouse.addItem(info);
		}
		
		/** recv( game向client通知移除物品从仓库 ) */
		private function recvRemoveItemFromWarehouse_G2C(bytes:ByteArray):void
		{
			var itemUid:Long = EndianFacade.readLong(bytes);
			Game.hero.warehouse.removeItem(itemUid);
		}
		
		/** recv( game向client通知更新仓库物品 ) */
		private function recvUpdateItemInWarehouse_G2C(bytes:ByteArray):void
		{
			var info:GoodsInfo = GoodsFactory.readInfo(bytes);
			Game.hero.warehouse.updateItem(info);
		}
		
		//=========================Xxxx=====↓=====================================
		
		/** send( client请求移动物品：从背包到背包 ) */
		public function sendMoveItemBagToBagReq_C2G(srcUid:Long, tarInd:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, MOVE_ITEM_BAG_TO_BAG_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, srcUid);
			EndianFacade.writeInt(mb.bytes, tarInd);
			mb.send();
		}
		
		/** send( client请求移动物品：从背包到仓库 ) */
		public function sendMoveItemBagToWarehouseReq_C2G(srcUid:Long, tarInd:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, MOVE_ITEM_BAG_TO_WAREHOUSE_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, srcUid);
			EndianFacade.writeInt(mb.bytes, tarInd);
			mb.send();
		}
		
		/** send( client请求移动物品：从仓库到仓库 ) */
		public function sendMoveItemWarehouseToWarehouseReq_C2G(srcUid:Long, tarInd:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, MOVE_ITEM_WAREHOUSE_TO_WAREHOUSE_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, srcUid);
			EndianFacade.writeInt(mb.bytes, tarInd);
			mb.send();
		}
		
		/** send( client请求移动物品：从仓库到背包 ) */
		public function sendMoveItemWarehouseToBagReq_C2G(srcUid:Long, tarInd:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, MOVE_ITEM_WAREHOUSE_TO_BAG_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, srcUid);
			EndianFacade.writeInt(mb.bytes, tarInd);
			mb.send();
		}
		
		/** send( client请求丢弃背包物品 ) */
		public function sendDropItemFromBagReq_C2G(itemUid:Long):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, DROP_ITEM_FROM_BAG_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, itemUid);
			mb.send();
		}
		
		/** send( client请求穿上装备 ) */
		public function sendPutOnEquipReq_C2G(srcUid:Long):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, PUT_ON_EQUIP_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, srcUid);
			mb.send();
		}
		
		/** send( client请求拆分背包物品 ) */
		public function sendSplitItemInBagReq_C2G(itemUid:Long, spNum:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, SPLIT_ITEM_IN_BAG_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, itemUid);
			EndianFacade.writeInt(mb.bytes, spNum);
			mb.send();
		}
		
		/** send( client请求脱下装备 ) */
		public function sendTakeOffEquipReq_C2G(srcUid:Long, index:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, TAKE_OFF_EQUIP_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, srcUid);
			EndianFacade.writeInt(mb.bytes, index);
			mb.send();
		}
		
		/** send( client请求使用物品 ) */
		public function sendUseItemReq_C2G(itemUid:Long, useNum:int):void
		{
			var mb:MsgBuffer = new MsgBuffer(MID, USE_ITEM_REQ_C2G);
			EndianFacade.writeLong(mb.bytes, itemUid);
			EndianFacade.writeInt(mb.bytes, useNum);
			mb.send();
		}
		
	}
}