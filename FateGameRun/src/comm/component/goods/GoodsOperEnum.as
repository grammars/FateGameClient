package comm.component.goods
{
	public class GoodsOperEnum
	{
		/** 成功 */
		public static const SUCC:int = 0;
		/** 默认失败 */
		public static const FAIL:int = 1;
		/** 已满 */
		public static const FULL:int = 2;
		/** 超过容量 */
		public static const OVER_CAPACITY:int = 3;
		/** 指定位置已存在物品,请选择空格位置放置 */
		public static const POS_OCCUPY:int = 4;
		/** 物品不存在 */
		public static const ITEM_NULL:int = 5;
		/** 这不是一件装备，请选择装备类物品进行穿戴 */
		public static const NOT_EQUIP:int = 6;
		/** 物品数量不足 */
		public static const NUM_LESS:int = 7;
		/** 物品CD中 */
		public static const CD_ING:int = 8;
		/** 玩家等级太低 */
		public static const PLAYER_LEV_TOO_MIN:int = 9;
		/** 玩家等级太高 */
		public static const PLAYER_LEV_TOO_MAX:int = 10;
		/** 玩家职业不符合 */
		public static const PLAYER_VOC_DENY:int = 11;
		
		public function GoodsOperEnum()
		{
		}
		
		public static function errMsg(errCode:int, containerType:int):String
		{
			switch(errCode)
			{
			case SUCC: return "成功";
			case FAIL: return "默认失败";
			case FULL: return "已满";
			case OVER_CAPACITY: return "超过容量";
			case POS_OCCUPY: return "指定位置已存在物品,请选择空格位置放置";
			case ITEM_NULL: return "物品不存在";
			case NOT_EQUIP: return "这不是一件装备，请选择装备类物品进行穿戴";
			case NUM_LESS: return "物品数量不足";
			case CD_ING: return "物品CD中";
			case PLAYER_LEV_TOO_MIN: return "玩家等级太低";
			case PLAYER_LEV_TOO_MAX: return "玩家等级太高";
			case PLAYER_VOC_DENY: return "玩家职业不符合";
			}
			return "未知错误";
		}
	}
}