package ui.view.debug
{
	public class GmParamCmd
	{
		public static const TYPE_OTHERS:int = 0;
		public static const TYPE_PLAYER:int = 1;
		public static const TYPE_FIGHT:int = 2;
		public static const TYPE_GOODS:int = 3;
		public static const TYPE_TASK:int = 4;
		
		public var label:String = "";
		
		public var mainCmdId:int = 0;
		public var subCmdId:int = 0;
		
		public var byte0Label:String = "";
		public var byte1Label:String = "";
		public var int0Label:String = "";
		public var int1Label:String = "";
		public var int2Label:String = "";
		public var float0Label:String = "";
		public var double0Label:String = "";
		public var long0Label:String = "";
		public var long1Label:String = "";
		public var str0Label:String = "";
		public var str1Label:String = "";
		
		public var byte0Input:String = "";
		public var byte1Input:String = "";
		public var int0Input:String = "";
		public var int1Input:String = "";
		public var int2Input:String = "";
		public var float0Input:String = "";
		public var double0Input:String = "";
		public var long0Input:String = "";
		public var long1Input:String = "";
		public var str0Input:String = "";
		public var str1Input:String = "";
		
		public function GmParamCmd(label:String="", mainCmdId:int=0, subCmdId:int=0)
		{
			this.label = label;
			this.mainCmdId = mainCmdId;
			this.subCmdId = subCmdId;
			
			cmdHandler();
		}
		
		/** to be override */
		protected function cmdHandler():void
		{
//			switch(this.subCmdId)
//			{
//				
//			}
		}
		
		
	}
}