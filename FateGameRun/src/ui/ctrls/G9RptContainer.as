package ui.ctrls
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class G9RptContainer extends Ape
	{
		private var gridsNine:BmpScale9Rpt;
		
		//----------------------------------------------------------------------
		
		/**根据背景图片路径加载背景图片完成之后的处理函数*/
		override protected function onBgLoaded(event:Event):void{trace("九宫容器onBgLoaded");
			var loader:Loader = event.target.loader;
			this.uiBgBitmap = new BitmapData(loader.width, loader.height, true, 0x00000000);
			uiBgBitmap.draw(loader);
			gridsNine.assign(uiBgBitmap);
			gridsNine.width = this._uiWidth;
			gridsNine.height = this._uiHeight;
			fresh();
		}
		
		//------------------------------------------------------------------------------
		
		[Bindable]
		override public function set uiWidth(value:uint):void{
			if (value >= 0 && this._uiWidth != value){
				this._uiWidth = value;
				if(gridsNine != null && uiBgBitmap != null){
					gridsNine.width = value;
				}
			}
			fresh();
		}
		
		override public function get uiWidth():uint{
			return this._uiWidth;
		}
		
		//------------------------------------------------------------------------------
		
		[Bindable]
		override public function set uiHeight(value:uint):void{
			if (value >= 0 && this._uiHeight != value){
				this._uiHeight = value;
				if(gridsNine != null && uiBgBitmap != null){
					gridsNine.height = value;
				}
			}
			fresh();
		}
		
		override public function get uiHeight():uint{
			return this._uiHeight;
		}
		
		//------------------------------------------------------------------------------	
		
		private var _HRepeat:uint = 1;
		/** 水平重复像素值 */
		public function set HRepeat(value:uint):void
		{
			if(value >= 1)
			{
				_HRepeat = value;
				gridsNine.HRepeat = value;
			}
			else
			{
				trace("水平重复像素值小于1像素，这是一个不合理的值");
			}
		}
		public function get HRepeat():uint
		{
			return _HRepeat;
		}
		
		private var _VRepeat:uint = 1;
		/** 垂直重复像素值 */
		public function set VRepeat(value:uint):void
		{
			if(value >= 1)
			{
				_VRepeat = value;
				gridsNine.VRepeat = value;
			}
			else
			{
				trace("垂直重复像素值小于1像素，这是一个不合理的值");
			}
		}
		public function get VRepeat():uint
		{
			return _VRepeat;
		}
		
		//------------------------------------------------------------------------------
		
		public function G9RptContainer(width:Number = 230, height:Number = 320){
			gridsNine = new BmpScale9Rpt();
			super(width, height);
			this.uiType 	= UIInfo.TYPE_CONTAINER;
			this.uiSubType 	= UIInfo.G9RPTCONTAINER;
			this.addChild(gridsNine);
		}
		
		
		
		
		/** 覆盖 刷新【重绘】 */
		override protected function fresh():void{
			gridsNine.graphics.clear();
			this.preRender();
			this.render();
		}
		
		/**预渲染*/
		override protected function preRender():void{
			//trace("hello");
		}
		
		
		/**渲染方法*/
		override protected function render():void{
			gridsNine.graphics.lineStyle(1, 0xFFFF00FF);
			if (uiBgBitmap != null){
				
			}else{
				gridsNine.graphics.beginFill(_uiBgColor);
			}
			gridsNine.graphics.drawRoundRect(0, 0, uiWidth, uiHeight, 5);
			gridsNine.graphics.endFill();
			gridsNine.alpha = uiAlpha;
		}
	}
}