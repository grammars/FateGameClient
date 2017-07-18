package net.msg.login
{
	public class LoginEC
	{
		
		/** 账号验证成功 */
		public static const ACCOUNT_VERIFY_SUCC:int = 1;
		/** 账号验证失败:sign错误 */
		public static const ACCOUNT_SIGN_ERR:int = 2;
		
		/** 创建角色成功 */
		public static const PLAYER_CREATE_SUCC:int = 20;
		/** 创建角色失败:该角色名已存在 */
		public static const PLAYER_NAME_EXIST:int = 21;
		/** 创建角色失败:角色数量已达到上限 */
		public static const PLAYER_NUM_TOP:int = 22;
		/** 创建角色失败:对应的账户不存在 */
		public static const PLAYER_NO_ACCOUNT:int = 23;
		/** 创建角色失败:插入数据库player表失败 */
		public static const PLAYER_INS_T_PLAYER_FAIL:int = 24;
		/** 创建角色失败:更新数据库account表失败 */
		public static const PLAYER_UPDATE_T_ACCOUNT_FAIL:int = 25;
		
		public function LoginEC()
		{
		}
		
		public static function print(errorCode:int, needTrace:Boolean=true):String
		{
			var debugStr:String = "[LoginEC]";
			switch(errorCode)
			{
			case LoginEC.ACCOUNT_VERIFY_SUCC:
				debugStr = "账号验证成功";
				break;
			case LoginEC.ACCOUNT_SIGN_ERR:
				debugStr = "账号验证失败:sign错误";
				break;
			case LoginEC.PLAYER_CREATE_SUCC:
				debugStr = "创建角色成功";
				break;
			case LoginEC.PLAYER_NAME_EXIST:
				debugStr = "创建角色失败:该角色名已存在";
				break;
			case LoginEC.PLAYER_NUM_TOP:
				debugStr = "创建角色失败:角色数量已达到上限";
				break;
			case LoginEC.PLAYER_NO_ACCOUNT:
				debugStr = "创建角色失败:对应的账户不存在";
				break;
			case LoginEC.PLAYER_INS_T_PLAYER_FAIL:
				debugStr = "创建角色失败:插入数据库player表失败";
				break;
			case LoginEC.PLAYER_UPDATE_T_ACCOUNT_FAIL:
				debugStr = "创建角色失败:更新数据库account表失败";
				break;
			default:
				debugStr = "未知错误:"+errorCode;
				break;
			}
			if(needTrace) { trace(debugStr); }
			return debugStr;
		}
		
	}
}