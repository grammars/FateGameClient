package ui.view.debug
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jui.assets.JResource;
	import com.anstu.jui.controls.JPanel;
	import com.anstu.jui.controls.JPushButton;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gamekit.avatar.ActionType;
	import gamekit.layer.Layer;
	
	import run.scene.avatar.NpcAvt;
	
	import ui.skin.pushButton.CommOrangeBtnSkin;
	import ui.view.IBasePane;
	
	public class ActionDebugger extends JPanel implements IBasePane
	{
		private static var _instance:ActionDebugger;
		public static function get instance():ActionDebugger
		{
			if(_instance == null) { _instance = new ActionDebugger(); }
			return _instance;
		}
		
		
		public function ActionDebugger()
		{
			super();
			setup();
		}
		
		private function setup():void
		{
			const base_ns:String = "base";
			this.setSize(140, 585);
			JResource.fill(this.fillBackground, "bg_miniRndBrdGrey.png", base_ns);
			
			var btnSkin:CommOrangeBtnSkin = new CommOrangeBtnSkin();
			
			var standBtn:JPushButton = new JPushButton("STAND", __standBtn);
			standBtn.setSize(100, 30);
			standBtn.move(20, 20);
			btnSkin.apply(standBtn);
			this.addChild(standBtn);
			
			var runBtn:JPushButton = new JPushButton("RUN", __runBtn);
			runBtn.setSize(100, 30);
			runBtn.move(20, 60);
			btnSkin.apply(runBtn);
			this.addChild(runBtn);
			
			var walkBtn:JPushButton = new JPushButton("WALK", __walkBtn);
			walkBtn.setSize(100, 30);
			walkBtn.move(20, 100);
			btnSkin.apply(walkBtn);
			this.addChild(walkBtn);
			
			var hitBtn:JPushButton = new JPushButton("HIT", __hitBtn);
			hitBtn.setSize(100, 30);
			hitBtn.move(20, 140);
			btnSkin.apply(hitBtn);
			this.addChild(hitBtn);
			
			var bangBtn:JPushButton = new JPushButton("BANG", __bangBtn);
			bangBtn.setSize(100, 30);
			bangBtn.move(20, 180);
			btnSkin.apply(bangBtn);
			this.addChild(bangBtn);
			
			var jumpCutBtn:JPushButton = new JPushButton("JUMP_CUT", __jumpCutBtn);
			jumpCutBtn.setSize(100, 30);
			jumpCutBtn.move(20, 220);
			btnSkin.apply(jumpCutBtn);
			this.addChild(jumpCutBtn);
			
			var magicSweepBtn:JPushButton = new JPushButton("MAGIC_SWEEP", __magicSweepBtn);
			magicSweepBtn.setSize(100, 30);
			magicSweepBtn.move(20, 260);
			btnSkin.apply(magicSweepBtn);
			this.addChild(magicSweepBtn);
			
			var magicSingBtn:JPushButton = new JPushButton("MAGIC_SING", __magicSingBtn);
			magicSingBtn.setSize(100, 30);
			magicSingBtn.move(20, 300);
			btnSkin.apply(magicSingBtn);
			this.addChild(magicSingBtn);
			
			var beatenBtn:JPushButton = new JPushButton("BEATEN", __beatenBtn);
			beatenBtn.setSize(100, 30);
			beatenBtn.move(20, 340);
			btnSkin.apply(beatenBtn);
			this.addChild(beatenBtn);
			
			var dieBtn:JPushButton = new JPushButton("DIE", __dieBtn);
			dieBtn.setSize(100, 30);
			dieBtn.move(20, 380);
			btnSkin.apply(dieBtn);
			this.addChild(dieBtn);
			
			var sitBtn:JPushButton = new JPushButton("SIT", __sitBtn);
			sitBtn.setSize(100, 30);
			sitBtn.move(20, 420);
			btnSkin.apply(sitBtn);
			this.addChild(sitBtn);
			
			var singleBtn:JPushButton = new JPushButton("单人模式", __singleBtn);
			singleBtn.setSize(100, 30);
			singleBtn.move(20, 460);
			btnSkin.apply(singleBtn);
			this.addChild(singleBtn);
			
			var rideBtn:JPushButton = new JPushButton("骑乘模式", __rideBtn);
			rideBtn.setSize(100, 30);
			rideBtn.move(20, 500);
			btnSkin.apply(rideBtn);
			this.addChild(rideBtn);
			
			var runSpeedBtn:JPushButton = new JPushButton("RUN加速", __runSpeedBtn);
			runSpeedBtn.setSize(100, 30);
			runSpeedBtn.move(20, 540);
			btnSkin.apply(runSpeedBtn);
			this.addChild(runSpeedBtn);
			
			putDefaultPos();
			Centre.stage.addEventListener(Event.RESIZE, putDefaultPos);
			this.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, __mouseUp);
		}
		
		private function __standBtn(e:MouseEvent):void
		{
			Game.scene.hero.setAction(ActionType.STAND);
		}
		
		private function __runBtn(e:MouseEvent):void
		{
			Game.scene.hero.setAction(ActionType.RUN);
		}
		
		private function __walkBtn(e:MouseEvent):void
		{
			Game.scene.hero.setAction(ActionType.WALK);
		}
		
		private function __hitBtn(e:MouseEvent):void
		{
			//Game.scene.hero.setAction(ActionType.HIT);
			Game.scene.hero.playAction(ActionType.HIT);
		}
		
		private function __bangBtn(e:MouseEvent):void
		{
			//Game.scene.hero.setAction(ActionType.BANG);
			Game.scene.hero.playAction(ActionType.BANG);
		}
		
		private function __jumpCutBtn(e:MouseEvent):void
		{
			//Game.scene.hero.setAction(ActionType.JUMP_CUT);
			Game.scene.hero.playAction(ActionType.JUMP_CUT);
		}
		
		private function __magicSweepBtn(e:MouseEvent):void
		{
			//Game.scene.hero.setAction(ActionType.MAGIC_SWEEP);
			Game.scene.hero.playAction(ActionType.MAGIC_SWEEP);
		}
		
		private function __magicSingBtn(e:MouseEvent):void
		{
			//Game.scene.hero.setAction(ActionType.MAGIC_SING);
			Game.scene.hero.playAction(ActionType.MAGIC_SING);
		}
		
		private function __beatenBtn(e:MouseEvent):void
		{
			//Game.scene.hero.setAction(ActionType.BEATEN);
			Game.scene.hero.playAction(ActionType.BEATEN);
		}
		
		private function __dieBtn(e:MouseEvent):void
		{
			Game.scene.hero.setAction(ActionType.DIE);
		}
		
		private function __sitBtn(e:MouseEvent):void
		{
			Game.scene.hero.setAction(ActionType.SIT);
		}
		
		private function __singleBtn(e:MouseEvent):void
		{
			Game.scene.hero.changeSelfLook("0000", false);
			Game.scene.hero.changeWeaponLook("0000",false);
			Game.scene.hero.changeHorseLook(null);
		}
		
		private function __rideBtn(e:MouseEvent):void
		{
			Game.scene.hero.changeSelfLook("0000", true);
			Game.scene.hero.changeWeaponLook("0000", true);
			Game.scene.hero.changeHorseLook("1000");
		}
		
		private function __runSpeedBtn(e:MouseEvent):void
		{
			Game.scene.hero.actionSpeed.setActionTime(ActionType.RUN, 3000);
			const CX:int = 30;
			const CY:int = 20;
			for(var i:int = 0; i < CY; i++)
			{
				for(var j:int = 0; j < CX; j++)
				{
					var avt:NpcAvt = new NpcAvt();
					avt.changeNpcLook("1001");
					avt.setAction(ActionType.STAND);
					avt.setDirection(4);
					avt.setGridX(Game.scene.hero.getGridX() + (j-CY/2));
					avt.setGridY(Game.scene.hero.getGridY() + (i-CX/2));
					avt.syncPxyAtGxy();
					
					avt.name = i + "_" + j;
					avt.updateName();
					
					Layer.avatar.append(avt);
				}
			}
		}
		
		private function __mouseDown(e:MouseEvent):void
		{
			this.startDrag();
		}
		
		private function __mouseUp(e:MouseEvent):void
		{
			this.stopDrag();
		}
		
		private function __btn(e:MouseEvent):void
		{
			
		}
		
		public function putDefaultPos(e:Event=null):void
		{
			this.x = Centre.stage.stageWidth - 300;
			this.y = 0;
		}
		
		public function show():void
		{
			Layer.ui.addChild(this);
		}
		
		public function hide():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
		
		public function showOrHide():void
		{
			if(this.parent) { hide(); }
			else { show(); }
		}
		
	}
}