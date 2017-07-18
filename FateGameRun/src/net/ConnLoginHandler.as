package net
{
	import central.Centre;
	import central.Game;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.handler.IoHandler;
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.utils.EndianFacade;
	
	import flash.utils.ByteArray;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import net.msg.MsgRecvMap;
	import net.msg.login.LoginMsg;
	
	import test.ctrls.GameConsole;
	
	public class ConnLoginHandler implements IoHandler
	{
		public function ConnLoginHandler()
		{
		}
		
		
		public function sessionOpened(service:SocketService):void
		{
			Log.debug("ConnLoginHandler::sessionOpened");		
			GameConsole.getInstance().log("ConnLoginHandler::sessionOpened");
			LoginMsg.getInstance().sendAccountVerifyReq_C2L(Game.login.info.account,
				Game.login.info.timestamp, Game.login.info.createSign());
		}
		
		
		public function sessionClosed(service:SocketService):void
		{
			Log.debug("ConnLoginHandler::sessionClosed");
			GameConsole.getInstance().log("ConnLoginHandler::sessionClosed");
		}
		
		public function exceptionCaught(service:SocketService, err:Error):void
		{
			Log.debug("ConnLoginHandler::exceptionCaught");
			GameConsole.getInstance().log("ConnLoginHandler::exceptionCaught" + err.getStackTrace());
		}
		
		public function messageReceived(service:SocketService, message:Object):void
		{
			Log.debug("ConnLoginHandler::messageReceived");
			GameConsole.getInstance().log("ConnLoginHandler::messageReceived");
			MsgRecvMap.handle(message as ByteArray);
		}
		
	}
}