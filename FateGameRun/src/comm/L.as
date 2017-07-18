package comm
{
	import gamekit.utils.StrUtils;

	/** Localization */
	public class L
	{	
		/** 简体中文 */
		public static const zh_cn:String = "zh_cn";
		/** 繁体中文(中国香港) */
		public static const zh_hk:String = "zh_hk";
		/** 繁体中文(中国台湾地区) */
		public static const zh_tw:String = "zh_tw";
		/** 英语(香港) */
		public static const en_hk:String = "en_hk";
		/** 英语(美国) */
		public static const en_us:String = "en_us";
		/** 英语(英国) */
		public static const en_gb:String = "en_gb";
		/** 英语(全球) */
		public static const en_ww:String = "en_ww";
		/** 日语(日本) */
		public static const ja_jp:String = "ja_jp";
		/** 韩文(韩国) */
		public static const ko_kr:String = "ko_kr";

		/** 语言类型 */
		public static var lang:String = zh_cn;
		
		public function L()
		{
		}
		
		/** TestDictionary */
		private static var TD:Object = new Object();
		
		/** Translation */
		public static function T(str:String):String
		{
			if(TD[str]) { return TD[str]; }
			return str;
		}
		
		/** 输出日期
		 * @param date 日期
		 * @param mode 模式 Y-M-D hh:mm:ss(ms) */
		public static function Tdate(date:Date, mode:String="Y-M-D hh:mm:ss(ms)"):String
		{
			mode = mode.replace("Y", date.fullYear.toString());
			mode = mode.replace("M", (date.month+1).toString());
			mode = mode.replace("D", date.date.toString());
			mode = mode.replace("hh", StrUtils.uintFixLen(date.hours,2));
			mode = mode.replace("mm", StrUtils.uintFixLen(date.minutes,2));
			mode = mode.replace("ss", StrUtils.uintFixLen(date.seconds,2));
			mode = mode.replace("ms", StrUtils.uintFixLen(date.milliseconds,2));
			return mode;
		}
		
		/** 初始化 */
		public static function initialize():void
		{
			switch(lang)
			{
			case en_hk:
			case en_us:
			case en_gb:
				TD_EN();
				break;
			case ja_jp:
				TD_JP();
				break;
			case ko_kr:
				TD_KR();
				break;
			}
		}
		
		private static function TD_EN():void
		{
			TD["角色名长度不能大于10个字"] = "Role name cann't be longer than 10 characters";
			TD["创建"] = "Create";
			TD["创建角色"] = "Create Role";
			TD["角色名"] = "Role name";
			TD["剑侠客"] = "Knight Sword";
			TD["性别:"] = "Sex:";
			TD["男"] = "Boy";
			TD["【男】"] = "【Boy】";
			TD["女"] = "Girl";
			TD["【女】"] = "【Girl】";
			TD["选择"] = "Select";
			TD["删除"] = "Delete";
			TD["您已掉线"] = "You have disconnected";
			TD["重新登录"] = "Relogin";
			TD["命运"] = "Fate";
			TD["用户名"] = "Username";
			TD["进入游戏"] = "Enter Game";
			TD["选择角色"] = "Select Role";
			TD["新建"] = "Create";
			TD["场景构建中..."] = "Scene is building...";
			TD["构建地图"] = "Building map";
			TD["目标已经死亡"] = "target has been dead";
			TD["你阵亡了"] = "You're dead";
			TD["原地复活"] = "rebirth here";
			TD["回城复活"] = "rebirth home";
			TD["综合"] = "All";
			TD["私聊"] = "Private";
			TD["队伍"] = "Team";
			TD["家族"] = "Family";
			TD["系统"] = "System";
			TD["世界"] = "World";
			TD["公告"] = "Pub";
			TD["和平模式"] = "PeaceMode";
			TD["自由模式"] = "FreeMode";
			TD["家族模式"] = "FamilyMode";
			TD["GM控制台"] = "GM Console";
			TD[""] = "";
		}
		
		private static function TD_JP():void
		{
			TD["角色名长度不能大于10个字"] = "キャラ名ない長さより10文字";
			TD["创建"] = "創建";
			TD["创建角色"] = "キャラクターの作成";
			TD["角色名"] = "キャラ名";
			TD["剑侠客"] = "剣侠客";
			TD["性别:"] = "性別：";
			TD["男"] = "男";
			TD["【男】"] = "【男】";
			TD["女"] = "女";
			TD["【女】"] = "【女】";
			TD["选择"] = "選択";
			TD["删除"] = "削除";
			TD["您已掉线"] = "あなたはすでに掉線";
			TD["重新登录"] = "再登録";
			TD["命运"] = "運命";
			TD["用户名"] = "ユーザー名";
			TD["进入游戏"] = "ゲームに入る";
			TD["选择角色"] = "キャラを選択して";
			TD["新建"] = "新築";
			TD["场景构建中..."] = "シーンを構築中…";
			TD["构建地图"] = "構築地図";
			TD["目标已经死亡"] = "目標はすでに死亡";
			TD["你阵亡了"] = "あなたが戦死した";
			TD["原地复活"] = "原地復活";
			TD["回城复活"] = "解除されるとＵターン復活";
			TD["综合"] = "総合";
			TD["私聊"] = "私の話を";
			TD["队伍"] = "チーム";
			TD["家族"] = "家族";
			TD["系统"] = "システム";
			TD["世界"] = "世界";
			TD["公告"] = "公告";
			TD["和平模式"] = "平和モード";
			TD["自由模式"] = "自由モード";
			TD["家族模式"] = "家族モード";
			TD["GM控制台"] = "ＧＭコンソール";
			TD[""] = "";
		}
		
		private static function TD_KR():void
		{
			TD["角色名长度不能大于10个字"] = "역할 이름 길이를 못 크다 10 글자";
			TD["创建"] = "생성";
			TD["创建角色"] = "캐릭터 생성";
			TD["角色名"] = "역할 이름";
			TD["剑侠客"] = "검객. 손님";
			TD["性别:"] = "성별:";
			TD["男"] = "남자";
			TD["【男】"] = "【남자】";
			TD["女"] = "여자";
			TD["【女】"] = "【여자】";
			TD["选择"] = "선택";
			TD["删除"] = "삭제";
			TD["您已掉线"] = "당신은 이미 접속";
			TD["重新登录"] = "다시 등록";
			TD["命运"] = "운명";
			TD["用户名"] = "사용자 이름";
			TD["进入游戏"] = "게임 접속";
			TD["选择角色"] = "캐릭터 선택";
			TD["新建"] = "새";
			TD["场景构建中..."] = "장면 업데이트 중...";
			TD["构建地图"] = "빌드 지도";
			TD["目标已经死亡"] = "목표 이미 사망한";
			TD["你阵亡了"] = "너 전사했다";
			TD["原地复活"] = "제자리에서 부활";
			TD["回城复活"] = "도시로 돌아가다 부활";
			TD["综合"] = "종합";
			TD["私聊"] = "사적인 얘기";
			TD["队伍"] = "대오";
			TD["家族"] = "가족";
			TD["系统"] = "시스템";
			TD["世界"] = "세계";
			TD["公告"] = "공고";
			TD["和平模式"] = "평화 모드";
			TD["自由模式"] = "자유 모드";
			TD["家族模式"] = "가족 모드";
			TD["GM控制台"] = "이를 고치지 못하면 콘솔";
			TD[""] = "";
		}
		
	}
}