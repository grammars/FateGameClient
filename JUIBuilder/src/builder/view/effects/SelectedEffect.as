package builder.view.effects
{
	import com.anstu.jui.build.ctrls.base.CShell;

	public class SelectedEffect
	{
		private static var _instance:SelectedEffect;
		public static function get instance():SelectedEffect
		{
			if(_instance == null) { _instance = new SelectedEffect(); }
			return _instance;
		}
		
		private var shell:CShell;
		
		public function SelectedEffect()
		{
		}
		
		public function apply(shell:CShell):void
		{
		}
		
	}
}