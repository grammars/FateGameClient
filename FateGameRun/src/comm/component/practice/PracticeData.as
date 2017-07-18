package comm.component.practice
{
	import comm.struct.practice.StPracticeData;
	
	public class PracticeData extends StPracticeData
	{
		public function PracticeData()
		{
			super();
		}
		
		private function build():void
		{
			//
		}
		
		/** 导入结构数据 */
		public function importData(data:StPracticeData):void
		{
			this.exp = data.exp;
			this.lev = data.lev;
			build();
		}
		
	}
}