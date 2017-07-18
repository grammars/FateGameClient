package ui.view.operate
{
	import central.Game;
	
	import comm.component.skill.SkillItem;
	
	import comm.define.SkillDef;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import res.Res;
	
	import ui.view.icon.Icon;
	import ui.view.tip.SkillTip;
	
	public class OperIcon extends Icon
	{
		private static const W:int = 40;
		private static const H:int = 40;
		
		public function OperIcon()
		{
			super();
			
			this.graphics.beginFill(0x00ff00, 0.001);
			this.graphics.drawRect(0,0,W,H);
			this.graphics.endFill();
			
			this.addEventListener(MouseEvent.CLICK, __mouseClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, __mouseOver);
			this.addEventListener(MouseEvent.MOUSE_MOVE, __mouseMove);
			this.addEventListener(MouseEvent.MOUSE_OUT, __mouseOut);
		}
		
		override protected function paint():void
		{
			if(!skillData().config) { return; }
			var bg:Bitmap = new Bitmap();
			bg.scaleX = bg.scaleY = W/36;
			var bgPath:String = "skill/36/" + skillData().config.icon + ".jpg";
			Res.fillIcon(bg, bgPath);
			this.addChild(bg);
		}
		
		/** 使用 */
		public function apply():void
		{
			if(this.type == Icon.TYPE_SKILL)
			{
				//trace("使用技能",skillData().config);
				var skillType:int = skillData().config.type;
				if(skillType == SkillDef.TYPE_AIM)
				{
					Game.fight.skillAim(skillData());
				}
				else if(skillType == SkillDef.TYPE_AOE)
				{
					Game.fight.skillAoe(skillData());
				}
				else if(skillType == SkillDef.TYPE_PATH)
				{
					Game.fight.skillPath(skillData());
				}
			}
			else if(this.type == Icon.TYPE_GOODS)
			{
				trace("使用道具");
			}
		}
		
		private function __mouseClick(e:MouseEvent):void
		{
			apply();
		}
		
		private function __mouseOver(e:MouseEvent):void
		{
			SkillTip.instance.update(skillData());
			SkillTip.instance.show();
		}
		
		private function __mouseMove(e:MouseEvent):void
		{
			SkillTip.instance.put();
		}
		
		private function __mouseOut(e:MouseEvent):void
		{
			SkillTip.instance.hide();
		}
		
	}
}