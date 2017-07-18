package builder.view.open
{
	import builder.Builder;
	import builder.view.OpenPop;
	import builder.view.StatusBar;
	import builder.view.base.BFrame;
	
	import com.anstu.jui.controls.JLabel;
	import com.anstu.jui.define.JuiConst;
	
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	public class DocSnap extends BFrame
	{
		public static const SPRING_W:int = 180;
		public static const SPRING_VG:int = 10;//垂直间隔
		
		override public function get W():int { return 170; }
		
		private var varH:int = 40;
		override public function get H():int { return varH; }
		
		private var nameLabel:JLabel = new JLabel();
		
		private var juiFile:File;
		
		public function DocSnap(task:DocSnapTask)
		{
			super();
			
			this.mouseChildren = false;
			
			this.juiFile = task.juiFile;
			
			nameLabel.text = task.juiFile.name.replace("."+Builder.EXT, "");
			nameLabel.align = JuiConst.CENTER;
			nameLabel.useStroke = true;
			nameLabel.textFormat.color = Builder.LAKE_BLUE;
			nameLabel.setSize(W, 40);
			this.addChild(nameLabel);
			
			if(task.hasSnap)
			{
				var scW:Number = Number(W-20)/task.loader.width;
				var scH:Number = 100/task.loader.width;
				var sc:Number = Math.min(scW, scH);
				if(sc > 1) { sc = 1; }
				task.loader.scaleX = task.loader.scaleY = sc;
				varH = 35 + task.loader.height;
				task.loader.x = 10;
				task.loader.y = 30;
				this.addChild(task.loader);
			}
			else
			{
				nameLabel.text += "\r没有预览";
			}
			
			this.lineColor = Builder.DARK_GREY;
			this.fillColor = Builder.MILK_WHITE;
			paint();
			
			this.addEventListener(MouseEvent.MOUSE_OVER, __mouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, __mouseOut);
			this.doubleClickEnabled = true;
			this.addEventListener(MouseEvent.DOUBLE_CLICK, __doubleClick);
		}
		
		private function __mouseOver(e:MouseEvent):void
		{
			this.lineColor = 0xcaae34;
			paint();
		}
		
		private function __mouseOut(e:MouseEvent):void
		{
			this.lineColor = Builder.DARK_GREY;
			paint();
		}
		
		private function __doubleClick(e:MouseEvent):void
		{
			OpenPop.instance.hide();
			
			StatusBar.instance.show("编辑" + juiFile.name);
			
			var fs:FileStream = new FileStream();
			fs.open(juiFile, FileMode.READ);
			var docText:String = fs.readMultiByte(fs.bytesAvailable, "UTF-8");
			var pureName:String = juiFile.name.replace("."+Builder.EXT, "");
			
			Builder.openDoc(pureName, docText);
		}
		
	}
}