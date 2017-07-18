package net
{
	import central.AbstractManage;
	import central.Centre;
	import central.Game;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.JSock;
	import com.anstu.jsock.filter.ProtocolCodecFilter;
	import com.anstu.jsock.proxy.filter.ByteBufferCodecFactory;
	import com.anstu.jsock.proxy.filter.FreeByteCodecFactory;
	import com.anstu.jsock.service.SocketService;
	import com.anstu.jsock.utils.ByteBuffer;
	import com.anstu.jsock.utils.Long;
	
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import net.msg.MsgRecvMap;
	import net.msg.login.LoginMsg;
	
	/** 管理网络通讯 */
	public class NetManage extends AbstractManage
	{
		/** clientBundleId,客户端的自我标识 */
		public var clientBundleId:Long = new Long();
		
		private var service:SocketService;
		
		public function NetManage()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			var factory:FreeByteCodecFactory = new FreeByteCodecFactory();
			//var factory:ByteBufferCodecFactory = new ByteBufferCodecFactory();
			var handler:ConnLoginHandler = new ConnLoginHandler();
			service = JSock.createService(factory, handler);
		}
		
		override public function startup():void
		{
			Log.print("NetManage::startup()");
			super.startup();
			
			MsgRecvMap.initHandlers();
			
			startupComplete();
		}
		
		/** 连接 */
		public function connect(ip:String, port:int):void
		{
			Security.loadPolicyFile("xmlsocket://"+ip+":843");
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			service.connect(ip, port);
		}
		
		/** 发送消息内容到服务器 */
		public function send(msgBody:ByteArray):void
		{
			service.sendMessage(msgBody);
		}
		
		/** 断开连接 */
		public function disconnect():void
		{
			service.disconnect();
		}
		
		/** 连接游戏网关服 */
		public function connectGateSrv():void
		{
			disconnect();
			var handler:ConnGameHandler = new ConnGameHandler();
			service.registerHandler(handler);//替换掉ConnLoginHandler
			service.connect(Game.login.info.srvIP, 8004);
		}
		
	}
}
