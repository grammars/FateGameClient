package ui.parts
{
	import central.View;
	
	import com.anstu.jui.controls.JLabel;
	
	import comm.struct.cd.StCDInfo;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import gamekit.paint.Sector;
	import gamekit.utils.Utils;
	
	import ui.view.utils.ViewUtils;
	
	public class CDRender extends Sprite
	{
		//private var label:JLabel;
		
		private var sector:Sector;
		
		private var _width:Number = 36;
		private var _height:Number = 36;
		
		private var bound:Shape;
		
		public function setWH(w:Number, h:Number):void
		{
			_width = w;
			_height = h;
			sector.x = _width/2;
			sector.y = _height/2;
			setBound();
		}
		
		public function CDRender()
		{
			super();
			
			//label = ViewUtils.label("cd", true);
			//this.addChild(label);
			
			sector = new Sector();
			sector.setLineAlpha(0, false);
			sector.setFillColor(0x0, false);
			sector.setFillAlpha(0.5, false);
			this.addChild(sector);
			
			bound = new Shape();
			this.addChild(bound);
			this.mask = bound;
			setWH(_width, _height);
			
			//this.graphics.lineStyle(1, 0xff0000);
			//this.graphics.drawRect(0,0,_width,_height);
			this.mouseEnabled = false;
		}
		
		private function setBound():void
		{
			bound.graphics.clear();
			bound.graphics.beginFill(0x0, 1);
			bound.graphics.drawRect(0, 0, _width, _height);
		}
		
		private var finishTime:Number = 0;
		private var totalTime:Number = 0;
		
		/** 更新 */
		public function update(cdi:StCDInfo):void
		{
			if(cdi == null)
			{
				kill();
				return;
			}
			var leftTime:int = cdi.finishTime - Utils.now();
			if(leftTime <= 0)
			{
				kill();
				return;
			}
			
			this.totalTime = cdi.cdTime;
			this.finishTime = cdi.finishTime;
			this.addEventListener(Event.ENTER_FRAME, __enterFrame);
		}
		
		private function __enterFrame(e:Event):void
		{
			var leftTime:int = this.finishTime - Utils.now();
			if(leftTime <= 0)
			{
				kill();
				return;
			}
			var angle:Number = 360 * leftTime/totalTime;
			var r:Number = Math.max(_width, _height);
			sector.paint(r, angle, 360-angle);
			//label.text = leftTime + "/" + totalTime;
		}
		
		private function kill():void
		{
			this.removeEventListener(Event.ENTER_FRAME, __enterFrame);
			sector.clear();
			//label.text = "已完成CD";
		}
		
	}
}