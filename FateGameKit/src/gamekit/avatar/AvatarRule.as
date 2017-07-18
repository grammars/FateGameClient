package gamekit.avatar
{
	public class AvatarRule
	{
		public function AvatarRule()
		{
		}
		
		/** getLinkName<br>
		 * action:ActionType <br> */
		public static function getLinkName(action:String, dir:uint, ind:int):String
		{
			if(ind < 1) 
			{
				trace("图片序号必须从1开始");
				throw new Error("图片序号必须从1开始");
			}
			dir = getResDirection(dir);
			var indStr:String = "";
			if(ind < 10) { indStr = "000" + ind; }
			else if(ind < 100) { indStr = "00" + ind; }
			else if(ind < 1000) { indStr = "0" + ind; }
			else if(ind < 10000) { indStr = ind.toString(); }
			
			if(action == ActionType.EFFECT)
			{
				return action + "_" + indStr + ".png";
			}
			return action + "_" + dir + indStr + ".png";
		}
		
		/** 获取资源方向 */
		public static function getResDirection(dir:int):int
		{
			if(dir == 7) { dir = 1; }
			else if(dir == 6) { dir = 2; }
			else if(dir == 5) { dir = 3; }
			else if(dir >= 8) { dir = 0; }
			else if(dir < 0) { dir = 0; }
			else { dir = dir; }
			return dir;
		}
		
		/** 根据方向获取翻转值 */
		public static function getScaleXByDir(dir:int):int
		{
			if(dir <= 4) return 1;
			return -1;
		}
		
		/** 链接名0号方向连接标识符 */
		public static const LINK_0_DIR_MARK:String = "_0";
		
		/** 基准移动速度[对应RUN/WALK] */
		public static const BASE_MOVE_SPEED:int = 150;
		/** 基准攻击速度[对应HIT] */
		public static const BASE_HIT_SPEED:Number = 1.667;
		
		/** 通过动作获取标准播放时长[毫秒] */
		public static function getStdPlayTimeByAction(action:String):int
		{
			switch(action)
			{
			case ActionType.STAND: return 1200;
			case ActionType.RUN: return 800;
			case ActionType.WALK: return 1200;
			case ActionType.HIT: return 1000/BASE_HIT_SPEED;
			case ActionType.BANG: return 800;
			case ActionType.JUMP_CUT: return 1800;
			case ActionType.MAGIC_SWEEP: return 1000;
			case ActionType.MAGIC_SING: return 1300;
			case ActionType.BEATEN: return 400;
			case ActionType.DIE: return 400;
			case ActionType.SIT: return 1300;
			case ActionType.EFFECT: return 800;
			}
			return 1000;
		}
		
		/** 通过 目标点-当前点 的 delt X/Y 来计算应该面向的方向 */
		public static function countFaceDir(deltX:int, deltY:int):int
		{
			if(deltX != 0 && deltY != 0)
			{
				var rad:Number = Math.atan2(-deltY, deltX);
				var degree:Number = rad / Math.PI * 180;
				//trace("计算的角度是,", degree, " 弧度是", rad / Math.PI, "PI");
				if(degree >= 67.5 && degree < 112.5) { return 0; }
				else if(degree >= 22.5 && degree < 67.5) { return 1; }
				else if(degree >= -22.5 && degree < 22.5) { return 2; }
				else if(degree >= -67.5 && degree < -22.5) { return 3; }
				else if(degree >= -112.5 && degree < -67.5) { return 4; }
				else if(degree >= -157.5 && degree < -112.5) { return 5; }
				else if(degree >= -180 && degree < -157.5) { return 6; }
				else if(degree >= 157.5 && degree <= 180) { return 6; }
				else if(degree >= 112.5 && degree < 157.5) { return 7; }
				else { return -1; }
			}
			else if(deltX != 0 && deltY == 0)
			{
				//trace("deltX != 0 && deltY == 0");
				if(deltX > 0) { return 2; }
				else { return 6; }
			}
			else if(deltX == 0 && deltY != 0)
			{
				//trace("deltX == 0 && deltY != 0");
				if(deltY > 0) { return 4; }
				else { return 0; }
			}
			else
			{
				return -1;
			}
		}
		
	}
}