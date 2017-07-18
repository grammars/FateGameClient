package comm.loading
{
	import central.Centre;
	
	import com.anstu.jcommon.geom.IntDimension;
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.events.JBaseEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import gamekit.layer.Layer;
	
	import ui.parts.Picture;
	import ui.parts.ProgressMask;
	import ui.skin.font.DefaultFont;
	
	public class LoadingScreen extends Sprite
	{
		private static var instance:LoadingScreen;
		public static function getInstance():LoadingScreen
		{
			if(instance == null) { instance = new LoadingScreen(); }
			return instance;
		}
		
		private var screen:Picture;
		private var loadingBg:Picture;
		private var loadingFg:Picture;
		private var label:JLabel;
		
		private const LOADING_SIZE:IntDimension = new IntDimension(756, 179);
		private var loadingMask:ProgressMask;
		
		public function LoadingScreen()
		{
			super();
			screen = new Picture(Centre.RES_ROOT + "loading/screen.jpg");
			loadingBg = new Picture(Centre.RES_ROOT + "loading/loadingBg.png", false);
			loadingFg = new Picture(Centre.RES_ROOT + "loading/loadingFg.png", false);
			this.addChild(screen);
			this.addChild(loadingBg);
			this.addChild(loadingFg);
			
			loadingMask = new ProgressMask().setup(loadingFg, ProgressMask.LEFT, LOADING_SIZE.width, LOADING_SIZE.height);
			
			label = new JLabel("");
			label.textFormat = DefaultFont.instance;
			label.align = JuiConst.CENTER;
			label.setSize(400, 30);
			label.useStroke = true;
			this.addChild(label);
			
			Centre.stage.addEventListener(Event.RESIZE, setPos);
			setPos();
			
		}
		
		private function setPos(e:Event=null):void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x0);
			this.graphics.drawRect(0, 0, Centre.stage.stageWidth, Centre.stage.stageHeight);
			this.graphics.endFill();
			
			screen.x = Centre.stage.stageWidth/2;
			screen.y = Centre.stage.stageHeight/2;
			
			loadingFg.x = loadingBg.x = (Centre.stage.stageWidth-LOADING_SIZE.width)/2;
			loadingFg.y = loadingBg.y = Centre.stage.stageHeight * 0.65;
			
			label.x = (Centre.stage.stageWidth - label.width)/2;
			label.y = Centre.stage.stageHeight * 0.9;
		}
		
		public function setInfo(info:String):void
		{
			label.text = info;
		}
		
		public function setProgress(loaded:Number, total:Number):void
		{
			var scale:Number = total <= 0 ? 1 : loaded/total;
			loadingMask.setProgress(scale);
		}
		
		public function show():void
		{
			Layer.loading.addChild(this);
		}
		
		public function hide():void
		{
			if(this.parent) { this.parent.removeChild(this); }
		}
		
	}
}