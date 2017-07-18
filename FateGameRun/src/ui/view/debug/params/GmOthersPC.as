package ui.view.debug.params
{
	import ui.view.debug.GmParamCmd;
	
	public class GmOthersPC extends GmParamCmd
	{
		/** 测试收到值 */
		private static const DEBUG:int = 0;
		
		public function GmOthersPC(label:String="", mainCmdId:int=0, subCmdId:int=0)
		{
			super(label, mainCmdId, subCmdId);
		}
		
		override protected function cmdHandler():void
		{
			switch(this.subCmdId)
			{
			case DEBUG:
				byte0Label = "byte0:";
				byte0Input = "-128";
				byte1Label = "byte1:";
				byte1Input = "127";
				int0Label = "int0:";
				int0Input = "-2147483648";
				int1Label = "int1:";
				int1Input = "2147483647";
				int2Label = "int2:";
				int2Input = "10086";
				float0Label = "float0:";//Float.MIN_VALUE(1.4E-45) Float.MAX_VALUE(3.4028235E38)
				float0Input = "-3.4028235";
				double0Label = "double:";//Double.MIN_VALUE(4.9E-324) Double.MAX_VALUE(1.7976931348623157E308)
				double0Input = "-1.7976931348623157";
				long0Label = "long0:";
				long0Input = "-1280000111122";//-17173
				long1Label = "long1:";
				long1Input = "0xFFFFFFFFffffffff";
				str0Label = "str0:";
				str0Input = "";
				str1Label = "str1:";
				str1Input = "上一个字符串是空";
				break;
			}
		}
		
		/** 获得所有选项值 */
		public static function items():Array
		{
			var arr:Array = [];
			arr.push(new GmOthersPC("测试收到值", GmParamCmd.TYPE_OTHERS, DEBUG));
			return arr;
		}
		
	}
}