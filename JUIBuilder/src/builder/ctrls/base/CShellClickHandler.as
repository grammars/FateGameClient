package builder.ctrls.base
{
	import builder.Builder;
	
	import com.anstu.jui.build.ctrls.base.ICShellClickHandler;
	
	import flash.events.MouseEvent;
	import com.anstu.jui.build.ctrls.base.CShell;
	
	public class CShellClickHandler implements ICShellClickHandler
	{
		private static var _instance:CShellClickHandler;
		public static function get instance():CShellClickHandler
		{
			if(_instance == null) { _instance = new CShellClickHandler(); }
			return _instance;
		}
		
		public function CShellClickHandler()
		{
		}
		
		public function handle(e:MouseEvent, shell:Object):void
		{
			if(shell.onlyModel) { return; }
			Builder.setTarget(shell as CShell);
			e.stopImmediatePropagation();
		}
	}
}