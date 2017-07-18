package view
{
	import org.aswing.JLabel;
	import org.aswing.JPanel;

	public class StatPanel
	{
		private static var _me:StatPanel;
		public static function me():StatPanel
		{
			if(_me == null) { _me = new StatPanel(); }
			return _me;
		}
		
		private var root:JPanel;
		public function getRootPane():JPanel { return root; }
		
		public function StatPanel()
		{
			root = new JPanel();
			root.append(new JLabel("状态:"));
		}
	}
}