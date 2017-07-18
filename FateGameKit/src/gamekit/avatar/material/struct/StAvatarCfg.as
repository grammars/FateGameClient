package gamekit.avatar.material.struct
{
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarRule;

	public class StAvatarCfg
	{
		private var src:XMLList;
		
		private var config:Object = new Object();
		
		public function getPicAttriByLinkName(linkName:String):StAvatarPicAttri
		{
			return config[linkName];
		}
		
		public function StAvatarCfg(src:XMLList)
		{
			this.src = src;
			const LEN:int = src.length();
			for(var i:int = 0; i < LEN; i++)
			{
				var part:XML = src[i];
				if("head" == part.name())
				{
					//
				}
				else if("seq" == part.name())
				{
					var links:XMLList = part.elements();
					for(var x:int = 0; x < links.length(); x++)
					{
						var link:XML = links[x];
						var linkName:String = link.name();
						//
						var apa:StAvatarPicAttri = new StAvatarPicAttri(link.@width, link.@height, link.@offx, link.@offy);
						config[linkName] = apa;
						//trace(apa);
						//
						const FMT:String = AvatarRule.LINK_0_DIR_MARK;
						if(linkName.indexOf(ActionType.STAND+FMT) != -1)
						{
							standNum++;
						}
						else if(linkName.indexOf(ActionType.RUN+FMT) != -1)
						{
							runNum++;
						}
						else if(linkName.indexOf(ActionType.WALK+FMT) != -1)
						{
							walkNum++;
						}
						else if(linkName.indexOf(ActionType.HIT+FMT) != -1)
						{
							hitNum++;
						}
						else if(linkName.indexOf(ActionType.BANG+FMT) != -1)
						{
							bangNum++;
						}
						else if(linkName.indexOf(ActionType.JUMP_CUT+FMT) != -1)
						{
							jumpCutNum++;
						}
						else if(linkName.indexOf(ActionType.MAGIC_SWEEP+FMT) != -1)
						{
							magicSweepNum++;
						}
						else if(linkName.indexOf(ActionType.MAGIC_SING+FMT) != -1)
						{
							magicSingNum++;
						}
						else if(linkName.indexOf(ActionType.BEATEN+FMT) != -1)
						{
							beatenNum++;
						}
						else if(linkName.indexOf(ActionType.DIE+FMT) != -1)
						{
							dieNum++;
						}
						else if(linkName.indexOf(ActionType.SIT+FMT) != -1)
						{
							sitNum++;
						}
						else if(linkName.indexOf(ActionType.EFFECT+FMT) != -1)
						{
							effectNum++;
						}
					}
				}
			}
		}
		
		/** 站立[张数] */
		private var standNum:int = 0;
		/** 站立[张数] */
		public function getStandNum():int { return standNum; }
		
		/** 玩家行走[张数] */
		private var runNum:int = 0;
		/** 玩家行走[张数] */
		public function getRunNum():int { return runNum; }
		
		/** 怪物行走[张数] */
		private var walkNum:int = 0;
		/** 怪物行走[张数] */
		public function getWalkNum():int { return walkNum; }
		
		/** 轻砍[张数] */
		private var hitNum:int = 0;
		/** 轻砍[张数] */
		public function getHitNum():int { return hitNum; }
		
		/** 重击[张数] */
		private var bangNum:int = 0;
		/** 重击[张数] */
		public function getBangNum():int { return bangNum; }
		
		/** 跳砍[张数] */
		public var jumpCutNum:int = 0;
		/** 跳砍[张数] */
		public function getJumpCutNum():int { return jumpCutNum; }
		
		/** 魔法技 横推[张数] */
		private var magicSweepNum:int = 0;
		/** 魔法技 横推[张数] */
		public function getMagicSweepNum():int { return magicSweepNum; }
		
		/** 魔法技 上举[张数] */
		private var magicSingNum:int = 0;
		/** 魔法技 上举[张数] */
		public function getMagicSingNum():int { return magicSingNum; }
		
		/** 受伤[张数] */
		private var beatenNum:int = 0;
		/** 受伤[张数] */
		public function getBeatenNum():int { return beatenNum; }
		
		/** 死亡[张数] */
		private var dieNum:int = 0;
		/** 死亡[张数] */
		public function getDieNum():int { return dieNum; }
		
		/** 打坐[张数] */
		private var sitNum:int = 0;
		/** 打坐[张数] */
		public function getSitNum():int { return sitNum; }
		
		/** 特效[张数] */
		private var effectNum:int = 0;
		/** 特效[张数] */
		public function getEffectNum():int { return effectNum; }
		
		/** 根据动作名获取该动作的总张数 */
		public function getPicNumByAction(action:String):int
		{
			switch(action)
			{
			case ActionType.STAND: return standNum;
			case ActionType.RUN: return runNum;
			case ActionType.WALK: return walkNum;
			case ActionType.HIT: return hitNum;
			case ActionType.BANG: return bangNum;
			case ActionType.JUMP_CUT: return jumpCutNum;
			case ActionType.MAGIC_SWEEP: return magicSweepNum;
			case ActionType.MAGIC_SING: return magicSingNum;
			case ActionType.BEATEN: return beatenNum;
			case ActionType.DIE: return dieNum;
			case ActionType.SIT: return sitNum;
			case ActionType.EFFECT: return effectNum;
			}
			return 0;
		}
		
	}
}

