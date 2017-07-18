package ui.ctrls{
	
	import flash.filters.GlowFilter;
	
	public class StrokeLabel extends Label{
		
		private var _uiTxtStrokeColor:int = 0x0e0600;
		
		public function set uiTxtStrokeColor(value:String):void{
			_uiTxtStrokeColor = parseInt(value,16);
			//加描边滤镜
			textField.filters = [new GlowFilter(_uiTxtStrokeColor, 1, _uiTxtStrokeBlur, _uiTxtStrokeBlur, _uiTxtStrokeStrength)];
			fresh();
		}
		public function get uiTxtStrokeColor():String{
			return _uiTxtStrokeColor.toString(16);
		}
		
		//---------------------------------------------------------------------------------
		
		private var _uiTxtStrokeBlur:int = 3;
		
		public function set uiTxtStrokeBlur(value:String):void{
			_uiTxtStrokeBlur = parseInt(value);
			//加描边滤镜
			textField.filters = [new GlowFilter(_uiTxtStrokeColor, 1, _uiTxtStrokeBlur, _uiTxtStrokeBlur, _uiTxtStrokeStrength)];
			fresh();
		}
		public function get uiTxtStrokeBlur():String{
			return _uiTxtStrokeBlur.toString();
		}
		
		//---------------------------------------------------------------------------------
		
		private var _uiTxtStrokeStrength:int = 3;
		
		public function set uiTxtStrokeStrength(value:String):void{
			_uiTxtStrokeStrength = parseInt(value);
			//加描边滤镜
			textField.filters = [new GlowFilter(_uiTxtStrokeColor, 1, _uiTxtStrokeBlur, _uiTxtStrokeBlur, _uiTxtStrokeStrength)];
			fresh();
		}
		public function get uiTxtStrokeStrength():String{
			return _uiTxtStrokeStrength.toString();
		}
		
		//---------------------------------------------------------------------------------
		
		
		public function StrokeLabel(width:Number = 120, height:Number = 23){
			super(width, height);
			this.uiSubType = UIInfo.STROKELABEL;
			//加描边滤镜
			textField.filters = [new GlowFilter(_uiTxtStrokeColor,1, _uiTxtStrokeBlur, _uiTxtStrokeBlur, _uiTxtStrokeStrength)];
		}
		
	}	
}