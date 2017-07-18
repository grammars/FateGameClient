package builder.view.prop
{
	import com.anstu.jui.build.ctrls.base.CShell;
	
	public class PropContainer extends PropBase
	{
		private static var _instance:PropContainer;
		public static function get instance():PropContainer
		{
			if(_instance == null) { _instance = new PropContainer(); }
			return _instance;
		}
		
		public function PropContainer()
		{
			super();
		}
		
		override public function apply():void
		{
		}
		
		override public function print(shell:CShell=null):void
		{
		}
	}
}