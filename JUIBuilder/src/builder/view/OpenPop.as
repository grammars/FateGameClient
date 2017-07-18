package builder.view
{
	import builder.Builder;
	import builder.view.base.Popup;
	import builder.view.open.DocSnap;
	import builder.view.open.DocSnapTask;
	
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class OpenPop extends Popup
	{
		private static var _instance:OpenPop;
		public static function get instance():OpenPop
		{
			if(_instance == null) { _instance = new OpenPop(); }
			return _instance;
		}
		
		private var scroll:JScrollPanel = new JScrollPanel();
		
		public function OpenPop()
		{
			super();
			
			new JScrollPanelSkin().apply(scroll);
			scroll.autoHideScrollBar = false;
			scroll.frameLineColor = Builder.LAKE_BLUE;
			scroll.frameLineAlpha = 1;
			scroll.frameLineThick = 3;
			scroll.frameFillColor = 0xffffff;
			scroll.frameFillAlpha = 1;
			scroll.frameRound = 10;
			//scroll.useFrame = true;
			scroll.move(20,50);
			this.addChild(scroll);
			
			this.setNormalSize(600, 400);
			this.setMaximizeSize(1000, 700);
			this.setSize(600, 400);
			this.iconifiedBtn.enabled = false;
			this.setTitle("打开文档");
			
			this.addEventListener(Event.RESIZE, __resize);
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			scroll.width = w - 60;
		}
		
		override public function set height(h:Number):void
		{
			super.height = h;
			scroll.height = h - 90;
		}
		
		override public function show():void
		{
			if(isScanning == false)
			{
				scanDir();
			}
			super.show();
		}
		
		private function __resize(e:Event):void
		{
			springPos();
		}
		
		private var isScanning:Boolean = false;
		private var loadingItem:int = 0;
		
		private function scanDir():void
		{
			items.length = 0;
			scroll.clearContent();
			
			var docDir:File = new File(Builder.docDirFull());
			var arr:Array = docDir.getDirectoryListing();
			for(var i:int = 0; i < arr.length; i++)
			{
				var file:File = arr[i];
				if(false == file.isDirectory && file.extension==Builder.EXT)
				{
					loadingItem++;
					new DocSnapTask(file);
				}
			}
			if(loadingItem > 0)
			{
				isScanning = true;
			}
		}
		
		private var items:Vector.<DocSnap> = new Vector.<DocSnap>();
		
		public function addDocSnap(task:DocSnapTask):void
		{
			var ds:DocSnap = new DocSnap(task);
			items.push(ds);
			scroll.addChild(ds);
			springPos();
			
			loadingItem--;
			if(loadingItem <= 0)
			{
				isScanning = false;
			}
		}
		
		/** 瀑布流放置 */
		private function springPos():void
		{
			const MARGIN:int = 5;
			var countX:int = Math.floor(this.scroll.width / DocSnap.SPRING_W);
			if(countX < 1) { countX = 1; }
			var posYs:Array = new Array();
			var n:int = 0; 
			for(n = 0; n < countX; n++)
			{
				posYs.push(MARGIN);
			}
			for(var i:int = 0; i < items.length; i++)
			{
				var ds:DocSnap = items[i];
				var mid:int = minIndex(posYs);
				var minY:int = posYs[mid];
				ds.x = MARGIN + mid * DocSnap.SPRING_W;
				ds.y = minY;
				posYs[mid] = ds.y + ds.H + DocSnap.SPRING_VG;
			}
		}
		
		private function minIndex(posYs:Array):int
		{
			var minInd:int = 0;
			var minVal:int = 0;
			var i:int = 0;
			for(i = 0; i < posYs.length; i++)
			{
				minVal += posYs[i];
			}
			for(i = 0; i < posYs.length; i++)
			{
				if(posYs[i] < minVal)
				{
					minVal = posYs[i];
					minInd = i;
				}
			}
			return minInd;
		}
	}
}