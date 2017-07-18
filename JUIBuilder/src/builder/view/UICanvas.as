package builder.view
{
	import builder.Builder;
	import builder.view.base.BFrame;
	
	import com.adobe.images.PNGEncoder;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.ctrls.base.ICShell;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.controls.JScrollPanel;
	import com.anstu.jui.skin.JScrollPanelSkin;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class UICanvas extends BFrame implements ICShell
	{
		private static var _instance:UICanvas;
		public static function get instance():UICanvas
		{
			if(_instance == null) { _instance = new UICanvas(); }
			return _instance;
		}
		
		override public function get W():int
		{
			var w:int = Builder.stage.stageWidth - UIBox.instance.W;
			if(w <= 0) { w = 1; }
			return w;
		}
		
		override public function get H():int
		{
			var h:int = Builder.stage.stageHeight - MenuBar.instance.H - StatusBar.instance.H;
			if(h <= 0) { h = 1; }
			return h;
		}
		
		private var scroll:JScrollPanel = new JScrollPanel();
		
		private var shellChildren:Vector.<CShell> = new Vector.<CShell>();
		public function getChildren():Vector.<CShell> { return shellChildren; }
		
		public function UICanvas()
		{
			super();
			new JScrollPanelSkin().apply(scroll);
			scroll.autoHideScrollBar = false;
			scroll.move(5,5);
			scroll.frameLineColor = Builder.LAKE_BLUE;
			scroll.frameLineAlpha = 1;
			scroll.frameLineThick = 3;
			scroll.frameFillColor = 0xffffff;
			scroll.frameFillAlpha = 1;
			scroll.frameRound = 10;
			scroll.useFrame = true;
			this.addChild(scroll);
			scroll.addEventListener(MouseEvent.CLICK, __canvasClick);
			scroll.addEventListener(MouseEvent.MOUSE_UP, __canvasUp);
		}
		
		override protected function paint():void
		{
			super.paint();
			scroll.setSize(W-25,H-25);
		}
		
		private function __canvasClick(e:MouseEvent):void
		{
			Builder.setTarget(null);
		}
		
		private function __canvasUp(e:MouseEvent):void
		{
			scroll.draw();
		}
		
		public function clear():void
		{
			scroll.clearContent();
			shellChildren.length = 0;
		}
		
		public function addShell(child:CShell):void
		{
			child.removeSelf();
			
			scroll.addChild(child);
			if(shellChildren.indexOf(child) == -1)
			{
				shellChildren.push(child);
			}
			child.shellParent = this;
		}
		
		public function removeShell(child:CShell):void
		{
			if(child.parent) { child.parent.removeChild(child); }
			var chInd:int = this.shellChildren.indexOf(child);
			if(chInd >= 0)
			{
				this.shellChildren.splice(chInd, 1);
			}
			child.shellParent = null;
		}
		
		/** 保存截图 */
		public function snapshot():void
		{
			if(!Builder.doc) { return; }
			var bmd:BitmapData = new BitmapData(PInt(scroll.content.width), PInt(scroll.content.height), true, 0x0);
			trace("scroll.content xy ", scroll.content.x, scroll.content.y, scroll.content.width, scroll.content.height);
			//bmd.draw(scroll.content, null, null, null, null, true);
			
			for(var i:int = 0; i < shellChildren.length; i++)
			{
				var shell:CShell = shellChildren[i];
				var mat:Matrix = new Matrix();
				mat.tx = shell.x;
				mat.ty = shell.y;
				bmd.draw(shell, mat, null, null, null, true);
			}
			
			var rect:Rectangle = bmd.getColorBoundsRect(0xFF000000,0x0,false);
			var cutBmd:BitmapData = new BitmapData(PInt(rect.width), PInt(rect.height), true);
			cutBmd.copyPixels(bmd, rect, new Point(0,0));
			
			var bytes:ByteArray = PNGEncoder.encode(cutBmd);
			var snapAddr:String = Builder.snapDirFull() + Builder.doc.fileName + ".png";
			var file:File = new File(snapAddr);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeBytes(bytes);
			fs.close();
		}
		
		private function PInt(num:int):int
		{
			return Math.max(1, num);
		}
		
	}
}