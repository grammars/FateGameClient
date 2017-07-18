package ui.ctrls{
	
	import ui.ctrls.Advanced.ScaleRadioButton;
	
	public class UISupervise{
		
		private static var _instance:UISupervise = null;
		
		public static function getInstance():UISupervise{
			if(_instance == null){
				_instance = new UISupervise();
			}
			return _instance;
		}
		
		//----------------------------------------------------------------------------
		
		public function UISupervise(){
			
		}
		
		//----------------------------------------------------------------------------
		
		private var radioGroup:Array = new Array();
		
		/**添加到group组中去*/
		public function addToRadioGroup(item:ButtonBase):void{
			radioGroup.push(item);
		}
		
		/**根据组名校准同组单选按钮*/
		public function correctRadioByGroup(item:ButtonBase):void{
			switch(item.uiSubType){
				case UIInfo.RADIOBUTTON:
				case UIInfo.TABBUTTON:
					for(var key:String in radioGroup){
						if(radioGroup[key].group == RadioButton(item).group){
							radioGroup[key].chosen = "false";
						}
					}
					RadioButton(item).chosen = "true";
					break;
				case UIInfo.SCALE_RADIOBUTTON:
				case UIInfo.SCALE_TABBUTTON:
					for(var skey:String in radioGroup){
						if(radioGroup[skey].group == ScaleRadioButton(item).group){
							radioGroup[skey].chosen = "false";
						}
					}
					ScaleRadioButton(item).chosen = "true";
					break;
			}
			
		}
		
		//----------------------------------------------------------------------------
		
		public function findPartner(item:ButtonBase, partner:String):Ape{
			for(var key:* in UIDic.dic){
				if(Ape(UIDic.dic[key]).uiName == partner){
					return UIDic.dic[key];
				}	
			}
			return null;
		}
		
	}
}