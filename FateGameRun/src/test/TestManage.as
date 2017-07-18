package test
{
	import central.AbstractManage;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.Long;
	import com.anstu.jui.JUIDemo;
	
	import gamekit.layer.Layer;
	
	import test.ctrls.GameConsole;
	
	import ui.view.chatBox.ChatBoxPane;
	
	public class TestManage extends AbstractManage
	{
		public function TestManage()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			Log.print("TestManage::startup()");
			super.startup();
			
			startupComplete();
			
			//ChatBoxPane.instance.visible = false;
			Layer.alert.addChild(GameConsole.getInstance());
			//var l:Long = new Long(-9982100000000);
			
		}
		
	}
}