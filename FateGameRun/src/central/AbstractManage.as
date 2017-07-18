package central
{
	public class AbstractManage
	{
		/** startup完成之后的回调 */
		public var startupCompleteCallback:Function;
		
		public function AbstractManage()
		{
			initialize();
		}
		
		/** 执行初始化必要的工作(构造时)[尽可能的不要依赖其他模块] */
		protected function initialize():void
		{
			//TODO
		}
		
		/** 启动运行 */
		public function startup():void
		{
			//TODO
		}
		
		/** 完成启动之后的回调 */
		protected function startupComplete():void	
		{
			if(startupCompleteCallback != null)
			{
				startupCompleteCallback.call();
				startupCompleteCallback = null;
			}
		}
		
	}
}