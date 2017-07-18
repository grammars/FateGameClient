package ui.view.heroCorner
{
	import comm.L;
	
	import comm.define.PkModeType;

	public class StPkMode
	{
		/** PK模式:取自PkModeType.PEACE/FREE/FAMILY */
		public var type:int;
		/** 用于显示的label属性 */
		public var label:String;
		
		public function StPkMode(type:int=0, label:String="")
		{
			this.type = type;
			this.label = label;
		}
		
		/** 罗列出所有选项Array中是所有的StPKMode */
		public static function options():Array
		{
			var opt:Array = [];
			opt.push(new StPkMode(PkModeType.PEACE, L.T("和平模式")));
			opt.push(new StPkMode(PkModeType.FREE,  L.T("自由模式")));
			opt.push(new StPkMode(PkModeType.FAMILY,  L.T("家族模式")));
			return opt;
		}
		
	}
}