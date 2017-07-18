package ui.view.debug.params
{
	import ui.view.debug.GmParamCmd;
	
	public class GmFightPC extends GmParamCmd
	{
		private static const TEST:int = 0;
		
		public function GmFightPC(label:String="", mainCmdId:int=0, subCmdId:int=0)
		{
			super(label, mainCmdId, subCmdId);
		}
		
		override protected function cmdHandler():void
		{
			switch(this.subCmdId)
			{
				
			}
		}
		
		/** 获得所有选项值 */
		public static function items():Array
		{
			var arr:Array = [];
			arr.push(new GmFightPC("fight测试", GmParamCmd.TYPE_FIGHT, TEST));
			return arr;
		}
		
	}
}