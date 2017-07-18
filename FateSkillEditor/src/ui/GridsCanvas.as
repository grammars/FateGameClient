package ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import imp.XGrid;
	
	public class GridsCanvas extends Sprite
	{
		private static var _instance:GridsCanvas;
		public static function get instance():GridsCanvas
		{
			if(_instance == null) { _instance = new GridsCanvas(); }
			return _instance;
		}
		
		public static const WIDTH:int = 800;
		public static const HEIGHT:int = 660;
		
		private var centre:Point = new Point();
		
		public function GridsCanvas()
		{
			super();
			paint();
			
			this.addEventListener(MouseEvent.CLICK, __mouseClick);
		}
		
		public function paint():void
		{
			this.graphics.clear();
			this.graphics.beginFill(0xffff00, 0.3);
			this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			this.graphics.endFill();
			
			for(var i:int = 0; i <= Math.floor(WIDTH/Editor.gridW); i++)
			{
				this.graphics.lineStyle(1, 0xff0000);
				this.graphics.moveTo(Editor.gridW*i, 0);
				this.graphics.lineTo(Editor.gridW*i, HEIGHT);
			}
			for(var j:int = 0; j <= Math.floor(HEIGHT/Editor.gridH); j++)
			{
				this.graphics.lineStyle(1, 0xff0000);
				this.graphics.moveTo(0,  Editor.gridH*j);
				this.graphics.lineTo(WIDTH, Editor.gridH*j);
			}
			
			this.graphics.lineStyle(1, 0x0000ff);
			this.graphics.drawCircle(0,0,5);
			
			for(var m:int = 0; m < Editor.grids.length; m++)
			{
				var g:XGrid = Editor.grids[m];
				this.graphics.beginFill(0x00ff00, 0.7);
				this.graphics.drawRect(g.x*Editor.gridW, g.y*Editor.gridH, Editor.gridW, Editor.gridH);
				this.graphics.endFill();
			}
			
			this.graphics.beginFill(0xff0000, 0.7);
			this.graphics.drawRect(Editor.gridW*Editor.centre.x+Editor.gridW/4,  Editor.gridH*Editor.centre.y+Editor.gridH/4, Editor.gridW/2, Editor.gridH/2);
			this.graphics.endFill();
		}
		
		private function __mouseClick(e:MouseEvent):void
		{
			var gx:int = Math.floor(e.localX/Editor.gridW);
			var gy:int = Math.floor(e.localY/Editor.gridH);
			Editor.handleGrid(gx, gy);
		}
		
	}
}