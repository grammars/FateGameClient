package comm.define
{
	public class GoodsType
	{
		/** 系统预留 */
		public static const SYSTEM:int = 0;
		/** 药剂 */
		public static const DRUG:int = 1;
		/** 任务道具 */
		public static const TASK:int = 2;
		/** 装备 */
		public static const EQUIP:int = 3;
		/** 宝石 */
		public static const GEM:int = 4;
		/** 礼赠 */
		public static const GIFT:int = 5;
		
		public function GoodsType()
		{
		}
		
		/** Str */
		public static function Str(type:int):String
		{
			switch(type)
			{
			case SYSTEM: return "系统预留";
			case DRUG: return "药剂";
			case TASK: return "任务道具";
			case EQUIP: return "装备";
			case GEM: return "宝石";
			case GIFT: return "礼赠";
			default: return "未定义";
			}
		}
	}
}