package builder.view.prop.rc
{
	import com.anstu.jui.build.ctrls.CsCalendar;
	import com.anstu.jui.build.ctrls.base.CShell;
	import builder.view.prop.PropBase;

	public class PropCalendar extends PropBase
	{
		private static var _instance:PropCalendar;
		public static function get instance():PropCalendar
		{
			if(_instance == null) { _instance = new PropCalendar(); }
			return _instance;
		}	
		
		public function PropCalendar()
		{
			super();
		}
		
		override public function apply():void
		{
			super.apply();
			var calendar:CsCalendar = shell as CsCalendar;
		}
		
		override public function print(shell:CShell=null):void
		{
			super.print(shell);
			var calendar:CsCalendar = shell as CsCalendar;
		}
		
	}
}