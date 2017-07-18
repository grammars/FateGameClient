package gamekit.avatar.material.struct
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	
	import gamekit.avatar.ActionType;
	import gamekit.avatar.AvatarRule;
	
	public class StAvatarBmd
	{
		private var domain:ApplicationDomain;
		private var cfg:StAvatarCfg;
		
		/** 动作类型：站立 */
		private var standBmds:Array = new Array();
		
		/** 动作类型：玩家行走 */
		private var runBmds:Array = new Array();
		
		/** 动作类型：怪物行走 */
		private var walkBmds:Array = new Array();
		
		/** 动作类型：轻砍 */
		private var hitBmds:Array = new Array();
		
		/** 动作类型：重击 */
		private var bangBmds:Array = new Array();
		
		/** 动作类型：跳砍 */
		private var jumpCutBmds:Array = new Array();
		
		/** 动作类型：魔法技 横推 */
		private var magicSweepBmds:Array = new Array();
		
		/** 动作类型：魔法技 上举 */
		private var magicSingBmds:Array = new Array();
		
		/** 动作类型：受伤 */
		private var beatenBmds:Array = new Array();
		
		/** 动作类型：死亡 */
		private var dieBmds:Array = new Array();
		
		/** 动作类型：打坐 */
		private var sitBmds:Array = new Array();
		
		/** 动作类型：特效 */
		private var effectBmds:Array = new Array();
		
		public function StAvatarBmd(domain:ApplicationDomain, cfg:StAvatarCfg)
		{
			this.domain = domain;
			this.cfg = cfg;
			prepare();
			this.domain = null;
			this.cfg = null;
		}
		
		private function prepare():void
		{
			const NEED_DIR_COUNT:int = 5;//01234共五种需求方向
			var i:int = 0;
			var j:int = 0;
			for(i = 0; i < cfg.getStandNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					standBmds.push(getDirArr(ActionType.STAND, j));
				}
			}
			for(i = 0; i < cfg.getRunNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					runBmds.push(getDirArr(ActionType.RUN, j));
				}
			}
			for(i = 0; i < cfg.getWalkNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					walkBmds.push(getDirArr(ActionType.WALK, j));
				}
			}
			for(i = 0; i < cfg.getHitNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					hitBmds.push(getDirArr(ActionType.HIT, j));
				}
			}
			for(i = 0; i < cfg.getBangNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					bangBmds.push(getDirArr(ActionType.BANG, j));
				}
			}
			for(i = 0; i < cfg.getJumpCutNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					jumpCutBmds.push(getDirArr(ActionType.JUMP_CUT, j));
				}
			}
			for(i = 0; i < cfg.getMagicSweepNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					magicSweepBmds.push(getDirArr(ActionType.MAGIC_SWEEP, j));
				}
			}
			for(i = 0; i < cfg.getMagicSingNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					magicSingBmds.push(getDirArr(ActionType.MAGIC_SING, j));
				}
			}
			for(i = 0; i < cfg.getBeatenNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					beatenBmds.push(getDirArr(ActionType.BEATEN, j));
				}
			}
			for(i = 0; i < cfg.getDieNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					dieBmds.push(getDirArr(ActionType.DIE, j));
				}
			}
			for(i = 0; i < cfg.getSitNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					sitBmds.push(getDirArr(ActionType.SIT, j));
				}
			}
			for(i = 0; i < cfg.getEffectNum(); i++)
			{
				for(j = 0; j < NEED_DIR_COUNT; j++)
				{
					effectBmds.push(getDirArr(ActionType.EFFECT, j));
				}
			}
		}
		
		private function getDirArr(action:String, needDir:int):Array
		{
			var ret:Array = new Array();
			var picNum:int;
			if(action == ActionType.STAND)
			{
				picNum = cfg.getStandNum();
			}
			else if(action == ActionType.RUN)
			{
				picNum = cfg.getRunNum();
			}
			else if(action == ActionType.WALK)
			{
				picNum = cfg.getWalkNum();
			}
			else if(action == ActionType.HIT)
			{
				picNum = cfg.getHitNum();
			}
			else if(action == ActionType.BANG)
			{
				picNum = cfg.getBangNum();
			}
			else if(action == ActionType.JUMP_CUT)
			{
				picNum = cfg.getJumpCutNum();
			}
			else if(action == ActionType.MAGIC_SWEEP)
			{
				picNum = cfg.getMagicSweepNum();
			}
			else if(action == ActionType.MAGIC_SING)
			{
				picNum = cfg.getMagicSingNum();
			}
			else if(action == ActionType.BEATEN)
			{
				picNum = cfg.getBeatenNum();
			}
			else if(action == ActionType.DIE)
			{
				picNum = cfg.getDieNum();
			}
			else if(action == ActionType.SIT)
			{
				picNum = cfg.getSitNum();
			}
			else if(action == ActionType.EFFECT)
			{
				picNum = cfg.getEffectNum();
			}
			for(var i:int = 1; i <= picNum; i++)
			{
				ret.push(createBmd(AvatarRule.getLinkName(action, needDir, i)));
			}
			return ret;
		}
		
		private function createBmd(linkName:String):BitmapData
		{
			if(domain.hasDefinition(linkName))
			{
				var C:Class = domain.getDefinition(linkName) as Class;
				return new C(0,0) as BitmapData;
			}
			return null;
		}
		
		public function getFrameBmd(action:String, dir:int, ind:int):BitmapData
		{
			var tarArr:Array;
			switch(action)
			{
			case ActionType.STAND: tarArr = standBmds; break;
			case ActionType.RUN: tarArr = runBmds; break;
			case ActionType.WALK: tarArr = walkBmds; break;
			case ActionType.HIT: tarArr = hitBmds; break;
			case ActionType.BANG: tarArr = bangBmds; break;
			case ActionType.JUMP_CUT: tarArr = jumpCutBmds; break;
			case ActionType.MAGIC_SWEEP: tarArr = magicSweepBmds; break;
			case ActionType.MAGIC_SING: tarArr = magicSingBmds; break;
			case ActionType.BEATEN: tarArr = beatenBmds; break;
			case ActionType.DIE: tarArr = dieBmds; break;
			case ActionType.SIT: tarArr = sitBmds; break;
			case ActionType.EFFECT: tarArr = effectBmds; break;
			default: tarArr = standBmds; break;
			}
			if(tarArr.length == 0) { return null; }
			return tarArr[AvatarRule.getResDirection(dir)][ind-1];
		}
		
	}
}