package com.anstu.jui.build.ctrls.base
{
	public class CShellContext
	{
		private static var _instance:CShellContext;
		public static function get instance():CShellContext
		{
			if(_instance == null) { _instance = new CShellContext(); }
			return _instance;
		}
		
		/** 资源填充器 */
		public var assetFiller:IAssetFiller;
		/** CShell 被 mouse click 之后的处理器 */
		public var clickHandler:ICShellClickHandler;
		
		
		public function CShellContext()
		{
		}
		
	}
}