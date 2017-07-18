package run.fight.aoe
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jload.JLoadTask;
	import com.anstu.jload.JLoader;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	import gamekit.FateGameKit;
	import gamekit.layer.Layer;
	
	public class AoePreview extends Sprite
	{
		private var curFileName:String;
		
		private var dis:DisplayObject;
		
		public function AoePreview()
		{
			super();
		}
		
		public function show(fileName:String):void
		{
			this.curFileName = fileName;
			dispose();
			var jl:JLoader = new JLoader();
			var url:String = Centre.RES_ROOT + "mouse" + Centre.FS + "float" + Centre.FS + fileName;
			var task:JLoadTask = new JLoadTask(JLoadTask.TYPE_DISPLAY_CONTENT, url, FateGameKit.SAME_DOMAIN);
			task.name = fileName;
			task.onComplete = __picLoaded;
			jl.add(task);
			jl.start();
			
			this.addEventListener(Event.ENTER_FRAME, __enterFrame);
			this.addEventListener(MouseEvent.CLICK, __mouseClick);
			Centre.stage.addChild(this);
		}
		
		public function dispose():void
		{
			this.removeEventListener(Event.ENTER_FRAME, __enterFrame);
			if(this.dis && this.dis.parent)
			{
				this.dis.parent.removeChild(this.dis);
			}
			this.dis = null;
		}
		
		private function __picLoaded(task:JLoadTask):void
		{
			if(task.name == this.curFileName)
			{
				this.dis = task.result.getBmp();
				this.dis.x = -this.dis.width/2;
				this.dis.y = -this.dis.height/2;
				this.addChild(this.dis);
			}
		}
		
		private function __enterFrame(e:Event):void
		{
			this.x = Centre.stage.mouseX;
			this.y = Centre.stage.mouseY;
		}
		
		private function __mouseClick(e:MouseEvent):void
		{
			hide();
			
			var pt:Point = Game.scene.hero.localToGlobal(new Point(0,0));
			//Game.info.notice("此时主角在" + pt.x + "," + pt.y);
			var px2heroX:int = Centre.stage.mouseX - pt.x;
			var px2heroY:int = Centre.stage.mouseY - pt.y;
			Game.fight.aoe.fireOn(px2heroX, px2heroY);
		}
		
		public function hide():void
		{
			if(this.parent) { this.parent.removeChild(this); }
			dispose();
		}
		
	}
}