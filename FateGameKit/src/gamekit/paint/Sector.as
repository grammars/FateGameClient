package gamekit.paint
{
	import flash.display.Shape;
	
	public class Sector extends Shape
	{
		protected var lineThick:Number = 1;
		public function setLineThick(value:Number, needRepaint:Boolean=true):void
		{
			this.lineThick = value;
			if(needRepaint) repaint();
		}
		public function getLineThick():Number { return this.lineThick; }
		
		protected var lineColor:uint = 0x0;
		public function setLineColor(value:uint, needRepaint:Boolean=true):void
		{
			this.lineColor = value;
			if(needRepaint) repaint();
		}
		public function getLineColor():uint { return this.lineColor; }
		
		protected var lineAlpha:Number = 1;
		public function setLineAlpha(value:Number, needRepaint:Boolean=true):void
		{
			this.lineAlpha = value;
			if(needRepaint) repaint();
		}
		public function getLineAlpha():Number { return this.lineAlpha; }
		
		protected var fillColor:uint = 0xffffff;
		public function setFillColor(value:uint, needRepaint:Boolean=true):void
		{
			this.fillColor = value;
			if(needRepaint) repaint();
		}
		public function getFillColor():uint { return this.fillColor; }
		
		protected var fillAlpha:Number = 1;
		public function setFillAlpha(value:Number, needRepaint:Boolean=true):void
		{
			this.fillAlpha = value;
			if(needRepaint) repaint();
		}
		public function getFillAlpha():Number { return this.fillAlpha; }
		
		protected var radius:Number = 100;
		public function setRadius(value:Number, needRepaint:Boolean=true):void
		{
			this.radius = value;
			if(needRepaint) repaint();
		}
		public function getRadius():Number { return this.radius; }
		
		protected var angle:Number = 60;
		public function setAngle(value:Number, needRepaint:Boolean=true):void
		{
			this.angle = value;
			if(needRepaint) repaint();
		}
		public function getAngle():Number { return this.angle; }
		
		protected var startFrom:Number = 0;
		public function setStartFrom(value:Number, needRepaint:Boolean=true):void
		{
			this.startFrom = value;
			if(needRepaint) repaint();
		}
		public function getStartFrom():Number { return this.startFrom; }
		
		public function Sector()
		{
			super();
		}
		
		public function clear():void
		{
			angle = 0;
			this.graphics.clear();
		}
		
		public function repaint():void
		{
			paint(radius, angle, startFrom);
		}
		
		/** 绘制扇形 */
		public function paint(radius:Number=100 , angle:Number=60 , startFrom:Number=0):void
		{
			this.radius = radius;
			this.angle = angle;
			this.startFrom = startFrom;
			
			this.graphics.clear(); 
			this.graphics.lineStyle(lineThick , lineColor, lineAlpha);
			this.graphics.beginFill(fillColor ,fillAlpha);
			this.graphics.moveTo(0 , 0); 
			angle = (Math.abs(angle) > 360) ? 360 : angle;
			var n:Number = Math.ceil(Math.abs(angle) / 45);
			var angleA:Number = angle / n;
			angleA = angleA * Math.PI / 180;
			var startFromRad:Number = (startFrom+270) * Math.PI / 180;
			this.graphics.lineTo(radius * Math.cos(startFromRad) , radius * Math.sin(startFromRad));   
			for(var i:int = 1 ; i<=n ; i++){   
				startFromRad += angleA;
				var angleMid:Number = startFromRad - angleA/2;
				var controlX:Number = radius / Math.cos(angleA/2) * Math.cos(angleMid);   
				var controlY:Number = radius / Math.cos(angleA/2) * Math.sin(angleMid);   
				var anchorX:Number = radius * Math.cos(startFromRad);   
				var anchorY:Number = radius * Math.sin(startFromRad);   
				this.graphics.curveTo(controlX , controlY , anchorX , anchorY);   
			}
			if(angle!=360)
				this.graphics.lineTo(0, 0);
			this.graphics.endFill();
		}
		
	}
}