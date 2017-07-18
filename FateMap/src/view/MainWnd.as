package view
{
	import controller.MainCtrl;
	
	import flash.desktop.NativeApplication;
	
	import org.aswing.BorderLayout;
	import org.aswing.ButtonGroup;
	import org.aswing.JButton;
	import org.aswing.JCheckBoxMenuItem;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JMenu;
	import org.aswing.JMenuBar;
	import org.aswing.JMenuItem;
	import org.aswing.JPanel;
	import org.aswing.JRadioButtonMenuItem;
	import org.aswing.JSeparator;
	import org.aswing.JSplitPane;
	import org.aswing.KeySequence;
	import org.aswing.KeyStroke;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;

	public class MainWnd
	{
		private static var _me:MainWnd;
		public static function me():MainWnd
		{
			if(_me == null) { _me = new MainWnd(); }
			return _me;
		}
		
		private var frame:JFrame;
		
		public function MainWnd()
		{
		}
		
		public function install(frm:JFrame):void
		{
			this.frame = frm;
			
			frame.getContentPane().append(MenuBar.me().getRootPane(), BorderLayout.NORTH);
			
			var midPane:JSplitPane = new JSplitPane();
			midPane.setLeftComponent(SidePanel.me().getRootPane());
			midPane.setRightComponent(CanvasPanel.me().getRootPane());
			midPane.setResizeWeight(0.2);
			frame.getContentPane().append(midPane, BorderLayout.CENTER);
			
			frame.getContentPane().append(StatPanel.me().getRootPane(), BorderLayout.SOUTH);
			
			frame.getKeyboardManager().registerKeyAction(new KeySequence(KeyStroke.VK_CONTROL, KeyStroke.VK_S), __saveAction);
			//test
			//CreateStdMapWnd.me().open();
		}
		
		private function __saveAction():void
		{
			MainCtrl.me().saveMapConfig();
		}
		
	}
}