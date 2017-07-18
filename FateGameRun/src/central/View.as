package central
{
	import ui.view.chatBox.ChatBoxPane;
	import ui.view.goods.GoodsDiscardFrame;
	import ui.view.goods.GoodsFrame;
	import ui.view.goods.GoodsSplitFrame;
	import ui.view.goods.WarehouseFrame;
	import ui.view.heroAttri.HeroAttriFrame;
	import ui.view.heroCorner.HeroCornerPane;
	import ui.view.mapRadar.MapRadarPane;
	import ui.view.npcTalk.NpcTalkFrame;
	import ui.view.operate.OperPane;
	import ui.view.task.TaskFrame;
	import ui.view.topTar.TopTarPane;

	public class View
	{
		/** 操作栏面板 */
		public static var operPane:OperPane;
		/** 左上角英雄信息面板 */
		public static var heroCornerPane:HeroCornerPane;
		/** 英雄属性窗体 */
		public static var heroAttriFrame:HeroAttriFrame;
		/** 顶端目标对象面板 */
		public static var topTarPane:TopTarPane;
		/** 聊天盒子面板 */
		public static var chatBoxPane:ChatBoxPane;
		/** 小地图雷达面板 */
		public static var mapRadarPane:MapRadarPane;
		/** 背包道具窗体 */
		public static var goodsFrame:GoodsFrame;
		/** 拆分物品窗体 */
		public static var goodsSplitFrame:GoodsSplitFrame;
		/** 丢弃物品窗体 */
		public static var goodsDiscardFrame:GoodsDiscardFrame;
		/** 仓库窗体 */
		public static var warehouseFrame:WarehouseFrame;
		/** npc对话窗体 */
		public static var npcTalkFrame:NpcTalkFrame;
		/** 任务窗体 */
		public static var taskFrame:TaskFrame;
		
		public function View()
		{
		}
		
		public static function startup():void
		{
			operPane = new OperPane();
			heroCornerPane = new HeroCornerPane();
			heroAttriFrame = new HeroAttriFrame();
			topTarPane = new TopTarPane();
			chatBoxPane = new ChatBoxPane();
			mapRadarPane = new MapRadarPane();
			goodsFrame = new GoodsFrame();
			goodsSplitFrame = new GoodsSplitFrame();
			goodsDiscardFrame = new GoodsDiscardFrame();
			warehouseFrame = new WarehouseFrame();
			npcTalkFrame = new NpcTalkFrame();
			taskFrame = new TaskFrame();
		}
		
	}
}