package ui.ctrls.Advanced{
	
	import ui.ctrls.UIInfo;
	import ui.ctrls.UISupervise;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	public class ScaleRadioButton extends ScaleStateButton{
		
		//------------------------------------------------------------------------
		
		private var _group:String = "self";
		
		public function set group(value:String):void{
			_group = value;
			fresh();
		}
		
		public function get group():String{
			return _group;
		}
		
		//------------------------------------------------------------------------
		
		public function ScaleRadioButton(width:Number=75, height:Number=23){
			super(width, height);
		}
		
		override protected function initButton():void{
			this.uiSubType = UIInfo.SCALE_RADIOBUTTON; 
			this.addEventListener(MouseEvent.CLICK, onClick);
			UISupervise.getInstance().addToRadioGroup(this);
		}
		
		//------------------------------------------------------------------------------------------
		
		override protected function onClick(event:MouseEvent):void{
			this._chosen = true;
			UISupervise.getInstance().correctRadioByGroup(this);
			fresh();
		}
		
		//------------------------------------------------------------------------------------------
		
	}
}