package ui.ctrls{
	/**UI相关信息，如控件类型、控件子类型*/
	public class UIInfo{
		
		public static const TYPE_CONTAINER:String = "容器类";
			public static const CONTAINER:String 	= "Container";
			public static const TILE_CONTAINER:String = "TileContainer"
			public static const GRIDS9CONTAINER:String = "Grids9Container";
			public static const GRIDS3CONTAINER:String = "Grids3Container";
			public static const G9RPTCONTAINER:String = "G9RptContainer";
			public static const ZCHANGE_CONTAINER:String = "ZchangeContainer";
			public static const ZCHANGE_TILE_CONTAINER:String = "ZchangeTileContainer";
			public static const ZCHANGE_GRIDS9CONTAINER:String = "ZchangeGrids9Container";
			public static const ZCHANGE_G9RPTCONTAINER:String = "ZchangeG9RptContainer";
			
		public static const TYPE_CONTROL:String = "控件类";
			public static const LINK:String = "Link";
			public static const STROKELINK:String = "StrokeLink";
			public static const BUTTON:String = "Button";
			public static const RADIOBUTTON:String = "RadioButton";
			public static const STATEBUTTON:String = "StateButton";
			public static const TABBUTTON:String = "TabButton";
			public static const LABEL:String = "Label";
			public static const TITLE:String = "Title";
			public static const STROKELABEL:String = "StrokeLabel";
			public static const NORMALINPUT:String = "NormalInput";
			
			//高级类 也属于 控件类，所以高级类的 type 也都是 type_control
			public static const SCROLL_FIELD_RIGHT:String	= "ScrollFieldRight";
			public static const SCROLL_FIELD_LEFT:String	= "ScrollFieldLeft";
			
			public static const SCALE_BUTTON:String = "ScaleButton";
			public static const SCALE_STATEBUTTON:String = "ScaleStateButton";
			public static const SCALE_RADIOBUTTON:String = "ScaleRadioButton";
			public static const SCALE_TABBUTTON:String = "ScaleTabButton";
			
			public static const COMBO_SCALE_BUTTON:String = "ComboScaleButton";
			public static const COMBO_SCALE_STATEBUTTON:String = "ComboScaleStateButton";
			
			public static const LIST_BUTTON:String = "ListButton";
			
			public static const SELECT_LIST:String = "SelectList";
			
		public static const TYPE_CUSTOM:String = "自定义类";
			public static const GONGJULAN:String = "GongJuLan";
			
		
		public function UIInfo(){
			//construct
		}
		
	}
}