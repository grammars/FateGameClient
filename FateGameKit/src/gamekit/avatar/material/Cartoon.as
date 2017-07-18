package gamekit.avatar.material
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.system.ApplicationDomain;
	
	import gamekit.avatar.material.struct.StAvatarCfg;
	import gamekit.avatar.material.struct.StAvatarPicAttri;
	
	public class Cartoon extends Shape
	{
		
		public function Cartoon()
		{
			super();
		}
		
		private var curBmd:BitmapData;
		private var curApa:StAvatarPicAttri;
		
		public function paint(bmd:BitmapData, apa:StAvatarPicAttri, sx:int=1):void
		{
			this.curBmd = bmd;
			this.curApa = apa;
			this.scaleX = sx;
			if(bmd && apa)
			{
				const OFX:int = apa.offsetX - apa.width/2;
				const OFY:int = apa.offsetY - apa.height/2;
				
				var mat:Matrix = new Matrix(1, 0, 0, 1, OFX, OFY);
				graphics.clear();
				//graphics.lineStyle(1, 0xff0000);
				graphics.beginBitmapFill(bmd, mat);
				graphics.drawRect(OFX, OFY, bmd.width, bmd.height);
				graphics.endFill();
				//绘制中心点
				graphics.beginFill(0x000000);
				graphics.drawRect(-2, -2, 4, 4);
				graphics.beginFill(0xff0000);
				graphics.drawRect(-1, -1, 2, 2);
				graphics.endFill();
			}
		}
		
		
		/** 是否包含该local点 */
		public function includeLP(lp:Point):Boolean
		{
			if(curBmd && curApa)
			{
				const OFX:int = curApa.offsetX - curApa.width/2;
				const OFY:int = curApa.offsetY - curApa.height/2;
				return 0 != curBmd.getPixel32(lp.x*this.scaleX-OFX, lp.y-OFY);
			}
			return false;
		}
		
	}
}