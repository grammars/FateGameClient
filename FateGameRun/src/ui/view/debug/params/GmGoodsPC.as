package ui.view.debug.params
{
	import ui.view.debug.GmParamCmd;
	
	public class GmGoodsPC extends GmParamCmd
	{
		/** 制造物品 */
		private static const MAKE_GOODS:int = 1;
		/** 清空包裹 */
		private static const CLEAR_BAG:int = 2;
		/** 领取一套装备 */
		private static const GET_EQUIPS:int = 3;
		
		
		public function GmGoodsPC(label:String="", mainCmdId:int=0, subCmdId:int=0)
		{
			super(label, mainCmdId, subCmdId);
		}
		
		override protected function cmdHandler():void
		{
			switch(subCmdId)
			{
			case MAKE_GOODS:
				int0Label = "物品id:";
				int0Input = "86010001";
				int1Label = "物品数量:";
				int1Input = "3";
				break;
			case CLEAR_BAG:
				break;
			case GET_EQUIPS:
				byte0Label = "职业类型:";
				byte0Input = "1";
				int0Label = "装备等级:";
				int0Input = "10";
				break;
			}
		}
		
		
		/** 获得所有选项值 */
		public static function items():Array
		{
			var arr:Array = [];
			arr.push(new GmGoodsPC("制造物品", GmParamCmd.TYPE_GOODS, MAKE_GOODS));
			arr.push(new GmGoodsPC("清理包裹", GmParamCmd.TYPE_GOODS, CLEAR_BAG));
			arr.push(new GmGoodsPC("领取一套装备", GmParamCmd.TYPE_GOODS, GET_EQUIPS));
			return arr;
		}
		
	}
}