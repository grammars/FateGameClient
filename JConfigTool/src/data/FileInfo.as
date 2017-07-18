package data
{
	public class FileInfo
	{
		public var nativePath:String = "";
		
		public var name:String = "";
		
		public var extension:String = "";
		
		public var size:int = 0;
		
		public function FileInfo(nativePath:String="", name:String="", extension:String="", size:int=0)
		{
			this.nativePath = nativePath;
			this.name = name;
			this.extension = extension;
			this.size = size;
		}
		
		/** 提供给s:List控件的接口属性 */
		public function get label():String
		{
			return name;
		}
	}
}