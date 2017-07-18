package
{
	import com.anstu.jui.components.JTextFormat;
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import imp.XGrid;
	
	import ui.Alert;
	import ui.EditorView;
	import ui.GridsCanvas;
	import ui.ctrls.CrystalInput;

	public class Editor
	{
		public static var root:Sprite;
		public static var stage:Stage;
		
		public static var gridW:int = 40;
		public static var gridH:int = 30;
		
		
		public static const OPER_DRAW:int = 0;
		public static const OPER_ERASE:int = 1;
		public static const OPER_CENTRE:int = 2;
		/** 操作方式*/
		public static var oper:int = 0;
		
		public static var grids:Vector.<XGrid> = new Vector.<XGrid>();
		public static var centre:Point = new Point();
		
		public static var loaderFrame:Sprite = new Sprite();
		public static var loader:Loader = new Loader();
		
		public static var output:CrystalInput;
		
		public function Editor()
		{
		}
		
		public static function defaultFont():JTextFormat
		{
			return new JTextFormat("微软雅黑", 14, FONT_COLOR);
		}
		public static const FONT_COLOR:uint = 0x62fdb1;
		public static const STROKE_COLOR:uint = 0x2b2b2b;
		public static const FL_COLOR:uint = 0x623db1;
		public static const FF_COLOR:uint = 0xdefecc;
		
		public static function initialize(pRoot:Sprite, pStage:Stage):void
		{
			root = pRoot;
			stage = pStage;
		}
		
		public static function setup():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, __keyUp);
			
			output = new CrystalInput("", 180, GridsCanvas.HEIGHT);
			
			loaderFrame.addChild(loader);
		}
		
		private static function __keyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
			case Keyboard.LEFT:
				loaderFrame.x -= 1;
				break;
			case Keyboard.RIGHT:
				loaderFrame.x += 1;
				break;
			case Keyboard.UP:
				loaderFrame.y -= 1;
				break;
			case Keyboard.DOWN:
				loaderFrame.y += 1;
				break;
			}
		}
		
		private static function __keyUp(e:KeyboardEvent):void
		{
			
		}
		
		
		public static function clear():void
		{
			XGrid.counter = 0;
			grids.length = 0;
			GridsCanvas.instance.paint();
		}
		
		public static function addGrid(x:int, y:int):void
		{
			for(var i:int = 0; i < grids.length; i++)
			{
				var g:XGrid = grids[i];
				if(g.x == x && g.y == y)
				{
					return;
				}
			}
			var ng:XGrid = new XGrid();
			ng.x = x;
			ng.y = y;
			grids.push(ng);
			GridsCanvas.instance.paint();
		}
		
		public static function removeGrid(x:int, y:int):void
		{
			for(var i:int = grids.length-1; i >= 0; i--)
			{
				var g:XGrid = grids[i];
				if(g.x == x && g.y == y)
				{
					grids.splice(i,1);
				}
			}
			GridsCanvas.instance.paint();
		}
		
		public static function centreGrid(x:int, y:int):void
		{
			centre.x = x;
			centre.y = y;
			GridsCanvas.instance.paint();
		}
		
		public static function handleGrid(x:int, y:int):void
		{
			switch(oper)
			{
			case OPER_DRAW:
				addGrid(x,y);
				break;
			case OPER_ERASE:
				removeGrid(x,y);
				break;
			case OPER_CENTRE:
				centreGrid(x,y);
				break;
			}
		}
		
		public static function exportLocate():String
		{
			var ret:String = "";
			for(var i:int = 0; i < grids.length; i++)
			{
				var g:XGrid = grids[i];
				ret += (g.x-centre.x) + "," + (g.y-centre.y);
				if(i != grids.length-1) { ret += ";" }
			}
			return ret;
		}
		
		public static function exportRoute():String
		{
			var ret:String = "";
			for(var i:int = 0; i < grids.length; i++)
			{
				var g:XGrid = grids[i];
				ret += (g.x-centre.x) + "," + (g.y-centre.y);
				if(i != grids.length-1) { ret += ";" }
			}
			return ret;
		}
		
	}
}