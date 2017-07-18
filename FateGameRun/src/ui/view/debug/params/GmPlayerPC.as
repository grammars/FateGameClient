package ui.view.debug.params
{
	import ui.view.debug.GmParamCmd;
	
	public class GmPlayerPC extends GmParamCmd
	{
		/** 改变玩家职业 */
		private static const CHANGE_VOC:int = 1;
		/** 改变玩家等级 */
		private static const CHANGE_LEVEL:int = 2;
		/** 改变当前生命值 */
		private static const CHANGE_CUR_HP:int = 3;
		/** 改变当前魔法值 */
		private static const CHANGE_CUR_MP:int = 4;
		/** 改变生命值 */
		private static const CHANGE_HP:int = 5;
		/** 改变魔法值 */
		private static const CHANGE_MP:int = 6;
		/** 改变移动速度 */
		private static const CHANGE_MOVE_SPEED:int = 7;
		/** 改变攻击力 */
		private static const CHANGE_ATTACK:int = 8;
		/** 改变攻击速度 */
		private static const CHANGE_ATTACK_SPEED:int = 9;
		/** 改变护甲值 */
		private static const CHANGE_ARMOR:int = 10;
		/** 改变护甲穿透 */
		private static const CHANGE_ARMOR_PENETRATION:int = 11;
		/** 改变法术强度 */
		private static const CHANGE_SPELL_POWER:int = 12;
		/** 改变法术免疫 */
		private static const CHANGE_SPELL_IMMUNITY:int = 13;
		/** 改变法术穿透 */
		private static const CHANGE_SPELL_PENETRATION:int = 14;
		
		public function GmPlayerPC(label:String="", mainCmdId:int=0, subCmdId:int=0)
		{
			super(label, mainCmdId, subCmdId);
		}
		
		override protected function cmdHandler():void
		{
			switch(subCmdId)
			{
			case CHANGE_VOC:
				byte0Label = "职业类型:";
				byte0Input = "0";
				break;
			case CHANGE_LEVEL:
				int0Label = "等级:";
				int0Input = "24";
				break;
			case CHANGE_CUR_HP:
				int0Label = "当前生命值:";
				int0Input = "3000";
				break;
			case CHANGE_CUR_MP:
				int0Label = "当前魔法值:";
				int0Input = "2000";
				break;
			case CHANGE_HP:
				int0Label = "生命值:";
				int0Input = "3500";
				break;
			case CHANGE_MP:
				int0Label = "魔法值:";
				int0Input = "2500";
				break;
			case CHANGE_MOVE_SPEED:
				int0Label = "移动速度:";
				int0Input = "250";
				break;
			case CHANGE_ATTACK:
				int0Label = "攻击力:";
				int0Input = "90";
				break;
			case CHANGE_ATTACK_SPEED:
				float0Label = "攻击速度:";
				float0Input = "1.6";
				break;
			case CHANGE_ARMOR:
				int0Label = "护甲值:";
				int0Input = "90";
				break;
			case CHANGE_ARMOR_PENETRATION:
				int0Label = "护甲穿透:";
				int0Input = "30";
				break;
			case CHANGE_SPELL_POWER:
				int0Label = "法术强度:";
				int0Input = "120";
				break;
			case CHANGE_SPELL_IMMUNITY:
				int0Label = "法术免疫:";
				int0Input = "60";
				break;
			case CHANGE_SPELL_PENETRATION:
				int0Label = "法术穿透:";
				int0Input = "30";
				break;
			}	
		}
		
		/** 获得所有选项值 */
		public static function items():Array
		{
			var arr:Array = [];
			arr.push(new GmPlayerPC("改变玩家职业", GmParamCmd.TYPE_PLAYER, CHANGE_VOC));
			arr.push(new GmPlayerPC("改变玩家等级", GmParamCmd.TYPE_PLAYER, CHANGE_LEVEL));
			arr.push(new GmPlayerPC("改变当前生命值", GmParamCmd.TYPE_PLAYER, CHANGE_CUR_HP));
			arr.push(new GmPlayerPC("改变当前魔法值", GmParamCmd.TYPE_PLAYER, CHANGE_CUR_MP));
			arr.push(new GmPlayerPC("改变生命值", GmParamCmd.TYPE_PLAYER, CHANGE_HP));
			arr.push(new GmPlayerPC("改变魔法值", GmParamCmd.TYPE_PLAYER, CHANGE_MP));
			arr.push(new GmPlayerPC("改变移动速度", GmParamCmd.TYPE_PLAYER, CHANGE_MOVE_SPEED));
			arr.push(new GmPlayerPC("改变攻击力", GmParamCmd.TYPE_PLAYER, CHANGE_ATTACK));
			arr.push(new GmPlayerPC("改变攻击速度", GmParamCmd.TYPE_PLAYER, CHANGE_ATTACK_SPEED));
			arr.push(new GmPlayerPC("改变护甲值", GmParamCmd.TYPE_PLAYER, CHANGE_ARMOR));
			arr.push(new GmPlayerPC("改变护甲穿透", GmParamCmd.TYPE_PLAYER, CHANGE_ARMOR_PENETRATION));
			arr.push(new GmPlayerPC("改变法术强度", GmParamCmd.TYPE_PLAYER, CHANGE_SPELL_POWER));
			arr.push(new GmPlayerPC("改变法术免疫", GmParamCmd.TYPE_PLAYER, CHANGE_SPELL_IMMUNITY));
			arr.push(new GmPlayerPC("改变法术穿透", GmParamCmd.TYPE_PLAYER, CHANGE_SPELL_PENETRATION));
			return arr;
		}
		
	}
}