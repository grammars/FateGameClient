package net
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.handler.IoHandler;
	import com.anstu.jsock.service.SocketService;
	
	import comm.loading.LoadingScreen;
	
	import flash.utils.ByteArray;
	
	import net.msg.MsgRecvMap;
	import net.msg.player.PlayerEventMsg;
	import net.msg.scene.SceneMsg;
	
	public class ConnGameHandler implements IoHandler
	{
		public function ConnGameHandler()
		{
		}
		
		public function sessionOpened(service:SocketService):void
		{
			Log.debug("ConnGameHandler::sessionOpened");
			
			PlayerEventMsg.getInstance().sendPlayerLoginGateReq_C2G();
			
			LoadingScreen.getInstance().setInfo("加载场景");
			LoadingScreen.getInstance().show();
			Centre.UI.showBaseUI();
		}
		
		public function sessionClosed(service:SocketService):void
		{
			Log.debug("ConnGameHandler::sessionClosed");
			Game.login.showDisConnPane();
		}
		
		public function exceptionCaught(service:SocketService, err:Error):void
		{
			Log.debug("ConnGameHandler::exceptionCaught");
		}
		
		public function messageReceived(service:SocketService, message:Object):void
		{
			Log.debug("ConnGameHandler::messageReceived");
			MsgRecvMap.handle(message as ByteArray);
		}
	}
}