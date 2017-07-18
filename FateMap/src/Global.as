package
{
	import flash.display.NativeWindow;
	import flash.display.Stage;
	
	import org.aswing.JFrame;

	public class Global
	{
		private static var stage:Stage;
		public static function setStage(s:Stage):void { stage = s; }
		public static function getStage():Stage { return stage; }
		
		private static var mainFrm:JFrame;
		public static function setMainFrm(f:JFrame):void { mainFrm = f; }
		public static function getMainFrm():JFrame { return mainFrm; }
		
		private static var mainWnd:NativeWindow;
		public static function setMainWnd(w:NativeWindow):void { mainWnd = w; }
		public static function getMainWnd():NativeWindow { return mainWnd; }
		
		public function Global()
		{
		}
	}
}