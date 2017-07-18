package view
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import model.MapConfig;
	import model.StGrid;
	import model.WorkConfig;
	
	import org.aswing.Component;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JScrollPane;
	import org.aswing.geom.IntRectangle;

	public class CanvasPanel
	{
		private static var _me:CanvasPanel;
		public static function me():CanvasPanel
		{
			if(_me == null) { _me = new CanvasPanel(); }
			return _me;
		}
		
		private var root:JScrollPane;
		public function getRootPane():JScrollPane { return root; }
		
		private var mapPic:DisplayObject;
		private var cover:Sprite;
		private var pack:Component;
		
		public function getCover():Sprite { return cover; }
		
		private var _isDrawing:Boolean = false;
		public function set isDrawing(b:Boolean):void
		{
			if(_isDrawing != b)
			{
				_isDrawing = b;
				if(_isDrawing) { Global.getStage().addEventListener(Event.ENTER_FRAME, __enterFrame); }
				else { Global.getStage().removeEventListener(Event.ENTER_FRAME, __enterFrame); }
			}
		}
		public function get isDrawing():Boolean { return _isDrawing; }
		
		public function CanvasPanel()
		{
			root = new JScrollPane();
			cover = new Sprite();
		}
		
		public function setMapPic(pic:DisplayObject):void
		{
			mapPic = pic;
			if(pack) { root.remove(pack); }
			pack = new Component();
			pack.addChild(pic);
			pack.addChild(cover);
			pack.setBounds(new IntRectangle(0, 0, pic.width, pic.height));
			root.append(pack);
			cover.addEventListener(MouseEvent.MOUSE_DOWN, __coverMouseDown);
			cover.addEventListener(MouseEvent.MOUSE_UP, __coverMouseUp);
			cover.addEventListener(MouseEvent.MOUSE_OUT, __coverMouseOut);
			cover.addEventListener(MouseEvent.MOUSE_MOVE, __coverMouseMove);
			//
			paint();
		}
		
		private function __coverMouseDown(e:MouseEvent):void
		{
			isDrawing = true;
			var gx:uint = Math.floor(e.localX / WorkConfig.me().getGridW());
			var gy:uint = Math.floor(e.localY / WorkConfig.me().getGridH());
			assignmentWithBrush(gx, gy);
			__enterFrame();//paint();
		}
		
		private function __coverMouseUp(e:MouseEvent):void
		{
			isDrawing = false;
			__enterFrame();//paint();
		}
		
		private function __coverMouseOut(e:MouseEvent):void
		{
			isDrawing = false;
			__enterFrame();//paint();
		}
		
		private function __coverMouseMove(e:MouseEvent):void
		{
			if(isDrawing == true)
			{
				var gx:uint = Math.floor(e.localX / WorkConfig.me().getGridW());
				var gy:uint = Math.floor(e.localY / WorkConfig.me().getGridH());
				assignmentWithBrush(gx, gy);
			}
		}
		
		private function assignmentWithBrush(gx:int, gy:int):void
		{
			const size:int = WorkConfig.me().BRUSH_SIZE;
			for(var ox:int = gx-size; ox <=gx+size; ox++)
			{
				for(var oy:int = gy-size; oy <=gy+size; oy++)
				{
					if(ox >= 0 && ox < MapConfig.me().getGridCountX() && oy >= 0 && oy < MapConfig.me().getGridCountY())
					{
						assignment(ox, oy);
					}
				}
			}
		}
		
		private function assignment(gx:int, gy:int):void
		{
			var ind:int = MapConfig.me().getGridCountX() * gy + gx;
			var g:StGrid = MapConfig.me().getGrids()[ind];
			g.isBlock = WorkConfig.me().IS_BLOCK_BRUSH;
			g.isMask = WorkConfig.me().IS_MASK_BRUSH;
			g.isStall = WorkConfig.me().IS_STALL_BRUSH;
			g.isDeliver = WorkConfig.me().IS_DELIVER_BRUSH;
			g.deliverVal = WorkConfig.me().DELIVER_BRUSH_VAL;
			g.isNumTag = WorkConfig.me().IS_NUM_TAG_BRUSH;
			g.numTagVal = WorkConfig.me().NUM_TAG_BRUSH_VAL;
		}
		
		private const PAINT_INTERVAL:int = 3;
		private var frameCount:int = 0;
		private function __enterFrame(e:Event=null):void
		{
			if(WorkConfig.me().HIGH_PERFORM)
			{
				paint();
			}
			else
			{
				frameCount++;
				if(frameCount >= PAINT_INTERVAL)
				{
					paint();
					frameCount = 0;
				}
			}
		}
		
		public function paint():void
		{
			trace("painting");
			if(mapPic == null) { return; }
			const BG_COLOR:int = 0x000000;
			var ALPHA:Number = 0;
			cover.graphics.clear();
			if(WorkConfig.me().VIEW_BG)
			{
				ALPHA = WorkConfig.me().DRAW_ALPHA;
			}
			cover.graphics.beginFill(BG_COLOR, ALPHA);
			cover.graphics.drawRect(0, 0, mapPic.width, mapPic.height);
			for(var gx:int = 0; gx < MapConfig.me().getGridCountX(); gx++)
			{
				for(var gy:int = 0; gy < MapConfig.me().getGridCountY(); gy++)
				{
					var ind:int = MapConfig.me().getGridCountX() * gy + gx;
					var grids:Vector.<StGrid> = MapConfig.me().getGrids();
					var g:StGrid = grids[ind];
					g.paint(cover.graphics, gx*WorkConfig.me().getGridW(), gy*WorkConfig.me().getGridH(),
						WorkConfig.me().getGridW(), WorkConfig.me().getGridH());
				}
			}
			if(WorkConfig.me().VIEW_NET)
			{
				cover.graphics.lineStyle(1, 0xff0000, 1);
				for(var i:int = 1; i <= MapConfig.me().getGridCountX(); ++i)
				{
					cover.graphics.moveTo(i*WorkConfig.me().getGridW(), 0);
					cover.graphics.lineTo(i*WorkConfig.me().getGridW(), WorkConfig.me().getMapHeight());
				}
				for(var j:int = 1; j <= MapConfig.me().getGridCountY(); ++j)
				{
					cover.graphics.moveTo(0, j*WorkConfig.me().getGridH());
					cover.graphics.lineTo(WorkConfig.me().getMapWidth(), j*WorkConfig.me().getGridH());
				}
			}
			cover.graphics.endFill();
		}
		
		public function clear():void
		{
			if(pack) { pack.removeFromContainer(); }
			cover.graphics.clear();
			cover.removeEventListener(MouseEvent.MOUSE_DOWN, __coverMouseDown);
			cover.removeEventListener(MouseEvent.MOUSE_UP, __coverMouseUp);
			cover.removeEventListener(MouseEvent.MOUSE_OUT, __coverMouseOut);
			isDrawing = false;
			mapPic = null;
		}
		
	}
}