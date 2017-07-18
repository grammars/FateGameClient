package ui.ctrls.Advanced{
	
	import ui.ctrls.UIInfo;
	import ui.ctrls.Ape;
	import ui.ctrls.UISupervise;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ScaleTabButton extends ScaleRadioButton{
		
		private var partnerApe:Ape;
		
		//----------------------------------------------
		
		private var _partner:String = "none";
		
		public function set partner(value:String):void{
			this._partner = value;
			partnerApe = UISupervise.getInstance().findPartner(this,value);
			fresh();
		}
		
		public function get partner():String{
			return this._partner;
		}
		
		//------------------------------------------------------------------------
		
		override public function set chosen(value:String):void{
			if(value == "true"){
				_chosen = true;
				if(partnerApe != null){
					partnerApe.parent.parent.visible = true;
				}
			}else if(value == "false"){
				_chosen = false;
				if(partnerApe != null){
					partnerApe.parent.parent.visible = false;
				}
			}
			fresh();
		}
		
		override public function get chosen():String{
			return _chosen.toString();
		}
		
		
		//----------------------------------------------
		
		public function ScaleTabButton(width:Number=40, height:Number=30){
			super(width, height);
		}
		
		override protected function initButton():void{
			this.uiSubType = UIInfo.SCALE_TABBUTTON;
			UISupervise.getInstance().addToRadioGroup(this);
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(Event.ENTER_FRAME , checkPartner);
		}
		
		//----------------------------------------------
		
		/** 强制校正 合作者 */
		protected function checkPartner(event:Event):void{
			var tmpPartner:String = this.partner;
			this.partner = tmpPartner;
			var tmpChosen:String = this.chosen;
			this.chosen = tmpChosen;
			if(this.partner != "none"){
				this.removeEventListener(Event.ENTER_FRAME , checkPartner);
			}
			fresh();
		}
		
		
	}
}