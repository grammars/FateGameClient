package run.scene.avatar
{
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import comm.define.SpriteType;
	import comm.effects.EffectFilters;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import gamekit.FateGameKit;
	import gamekit.avatar.ActionType;
	import gamekit.avatar.material.AvatarDisplay;
	import gamekit.utils.DisObjSelect;
	
	import res.Res;
	
	import run.scene.avatar.vo.*;
	
	public class SpriteAvt extends AvatarDisplay
	{
		/** 临时id */
		public function getTid():int { return spriteVO.tid; }
		/** 唯一id */
		public function getUid():Long { return spriteVO.uid; }
		/** 精灵类型 */
		public function getType():int { return spriteVO.type; }
		
		protected var vo:SpriteVO;
		public function setVO(value:SpriteVO):void
		{
			this.vo = value;
		}
		public function get spriteVO():SpriteVO { return this.vo; }
		public function get doorVO():DoorVO { return this.vo as DoorVO; }
		public function get dropVO():DropVO { return this.vo as DropVO; }
		public function get effectVO():EffectVO { return this.vo as EffectVO; }
		public function get aoeSkillVO():AoeSkillVO { return this.vo as AoeSkillVO; }
		public function get pathSkillVO():PathSkillVO { return this.vo as PathSkillVO; }
		public function get creatureVO():CreatureVO { return this.vo as CreatureVO; }
		public function get monsterVO():MonsterVO { return this.vo as MonsterVO; }
		public function get npcVO():NpcVO { return this.vo as NpcVO; }
		public function get playerVO():PlayerVO { return this.vo as PlayerVO; }
		
		public function SpriteAvt(pBornTime:Object=null)
		{
			super(pBornTime);
			createParts();
			//this.scaleX = this.scaleY = 0.3;
		}
		
		/** 构造部件 */
		protected function createParts():void
		{
			
		}
		
		/** isDoor */
		public function get isDoor():Boolean { return (this is DoorAvt); }
		/** isDrop */
		public function get isDrop():Boolean { return (this is DropAvt); }
		/** isEffect */
		public function get isEffect():Boolean { return (this is EffectAvt); }
		/** isAoeSkill */
		public function get isAoeSkill():Boolean { return (this is AoeSkillAvt); }
		/** isPathSkill */
		public function get isPathSkill():Boolean { return (this is PathSkillAvt); }
		/** isCreature */
		public function get isCreature():Boolean { return (this is CreatureAvt); }
		/** isMonster */
		public function get isMonster():Boolean { return (this is MonsterAvt); }
		/** isNpc */
		public function get isNpc():Boolean { return (this is NpcAvt); }
		/** isPlayer */
		public function get isPlayer():Boolean { return (this is PlayerAvt); }
		/** isOtherPlayer是否是其他玩家 */
		public function get isOtherPlayer():Boolean
		{
			return (isPlayer && (!this.isHero));
		}
		
		public function toAoeSkill():AoeSkillAvt { return this as AoeSkillAvt; }
		public function toPathSkill():PathSkillAvt { return this as PathSkillAvt; }
		public function toDoor():DoorAvt { return this as DoorAvt; }
		public function toDrop():DropAvt { return this as DropAvt; }
		public function toEffect():EffectAvt { return this as EffectAvt; }
		public function toCreature():CreatureAvt { return this as CreatureAvt; }
		public function toNpc():NpcAvt { return this as NpcAvt; }
		public function toMonster():MonsterAvt { return this as MonsterAvt; }
		public function toPlayer():PlayerAvt { return this as PlayerAvt; }
		
		/** clickHandler */
		override public function clickHandler(e:MouseEvent):void
		{
			super.clickHandler(e);
		}
		
		/** overHandler */
		override public function overHandler(e:MouseEvent):void
		{
			super.overHandler(e);
			
			if(this.self) this.self.getCartoon().filters = [EffectFilters.AvtOver];
			if(this.weapon) this.weapon.getCartoon().filters = [EffectFilters.AvtOver];
			if(this.horse) this.horse.getCartoon().filters = [EffectFilters.AvtOver];
		}
		
		/** outHandler */
		override public function outHandler(e:MouseEvent):void
		{
			super.outHandler(e);
			
			if(this.self) this.self.getCartoon().filters = [];
			if(this.weapon) this.weapon.getCartoon().filters = [];
			if(this.horse) this.horse.getCartoon().filters = [];
		}
		
		/** 改变自身外观 */
		public function changeSelfLook(value:String, riding:Boolean=false):void
		{
			var subDir:String = riding == true ? "ride" : "std";
			var cfgAddr:String = FateGameKit.RES_ROOT + "player/"+subDir+"/"+value+"/"+value+".zip";
			var swfAddr:String = FateGameKit.RES_ROOT + "player/"+subDir+"/"+value+"/"+value+".swf";
			this.setSelf(cfgAddr, swfAddr);
		}
		
		/** 改变武器外观 */
		public function changeWeaponLook(value:String, riding:Boolean=false):void
		{
			if(Res.isNull(value))
			{
				this.setWeapon(null, null);
				return;
			}
			var subDir:String = riding == true ? "ride" : "std";
			var cfgAddr:String = FateGameKit.RES_ROOT + "weapon/"+subDir+"/"+value+"/"+value+".zip";
			var swfAddr:String = FateGameKit.RES_ROOT + "weapon/"+subDir+"/"+value+"/"+value+".swf";
			this.setWeapon(cfgAddr, swfAddr);
		}
		
		/** 改变坐骑外观 */
		public function changeHorseLook(value:String):void
		{
			if(Res.isNull(value))
			{
				this.setHorse(null,null);
				return;
			}
			var cfgAddr:String = FateGameKit.RES_ROOT + "horse/"+value+"/"+value+".zip";
			var swfAddr:String = FateGameKit.RES_ROOT + "horse/"+value+"/"+value+".swf";
			this.setHorse(cfgAddr, swfAddr);
		}
		
		/** NPC的改变自身外观 */
		public function changeNpcLook(value:String):void
		{
			var cfgAddr:String = FateGameKit.RES_ROOT + "npc/"+value+"/"+value+".zip";
			var swfAddr:String = FateGameKit.RES_ROOT + "npc/"+value+"/"+value+".swf";
			this.setSelf(cfgAddr, swfAddr);
		}
		
		/** monster的改变自身外观 */
		public function changeMonsterLook(value:String):void
		{
			var cfgAddr:String = FateGameKit.RES_ROOT + "monster/"+value+"/"+value+".zip";
			var swfAddr:String = FateGameKit.RES_ROOT + "monster/"+value+"/"+value+".swf";
			this.setSelf(cfgAddr, swfAddr);
		}
		
		/** effect的改变效果 */
		public function changeEffectLook(value:String, category:String):void
		{
			var cfgAddr:String = FateGameKit.RES_ROOT + "effect/"+category+"/"+value+"/"+value+".zip";
			var swfAddr:String = FateGameKit.RES_ROOT + "effect/"+category+"/"+value+"/"+value+".swf";
			this.setSelf(cfgAddr, swfAddr);
			this.setAction(ActionType.EFFECT);
		}
		/** 场景特效设置 */
		public function changeSceneEffect(value:String):void
		{
			changeEffectLook(value, "scene");
		}
		/** 技能特效设置 */
		public function changeSkillEffect(value:String):void
		{
			changeEffectLook(value, "skill");
		}
		/** 技能特效设置 */
		public function changeUiEffect(value:String):void
		{
			changeEffectLook(value, "ui");
		}
		
		/** 根据最新的VO进行更新 */
		public function update():void
		{
			this.setDirection(spriteVO.direction);
			this.setGridX(spriteVO.mapX);
			this.setGridY(spriteVO.mapY);
		}
		
	}
}