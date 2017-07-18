package ui.ctrls{
	import ui.ctrls.UIInfo;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	public class RadioButton extends StateButton{
		
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
		
		public function RadioButton(width:Number = 40, height:Number = 30){
			super(width , height);
			//initButton();
		}
		
		
		override protected function initButton():void{
			this.uiSubType = UIInfo.RADIOBUTTON;
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