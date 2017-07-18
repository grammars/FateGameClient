package run.login
{
	import central.Centre;
	
	import com.anstu.jcommon.log.Log;
	import com.anstu.jsock.utils.EndianFacade;
	import com.anstu.jsock.utils.Long;
	
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import net.msg.login.LoginMsg;
	import net.msg.login.PlayerListPack;
	
	import run.AbstractRunHandler;
	
	import ui.view.login.CreateRolePane;
	import ui.view.login.DisConnPane;
	import ui.view.login.LoginPane;
	import ui.view.login.SelectRolePane;
	
	/** 登录相关 */
	public class LoginRun extends AbstractRunHandler
	{
		public var info:StLoginInfo = new StLoginInfo();
		
		private var loginPane:LoginPane;
		private var createRolePane:CreateRolePane;
		private var selectRolePane:SelectRolePane;
		private var disConnPane:DisConnPane;
		
		public function LoginRun()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function startup():void
		{
			super.startup();
			if(loginPane == null) { loginPane = new LoginPane(); }
			if(createRolePane == null) { createRolePane = new CreateRolePane(); }
			if(selectRolePane == null) { selectRolePane = new SelectRolePane(); }
			if(disConnPane == null) { disConnPane = new DisConnPane(); }
			loginPane.show();
		}
		
		/** 处理角色列表 */
		public function handlePlayerList(pList:PlayerListPack):void
		{
			hideAllPanes();
			if(pList.list.length == 0)
			{
				//新玩家，没有角色
				createRolePane.show();
			}
			else
			{
				//老玩家，有角色
				selectRolePane.addRoles(pList);
				selectRolePane.show();
			}
		}
		
		/** 显示创建角色 */
		public function showCreatePane():void
		{
			hideAllPanes();
			if(createRolePane) { createRolePane.show(); }
		}
		
		/** 显示掉线面板 */
		public function showDisConnPane():void
		{
			disConnPane.show();
		}
		
		/** 选择了某个角色进入游戏 */
		public function selectPlayer(playerUid:Long):void
		{
			LoginMsg.getInstance().sendPlayerSelectReq_C2L(playerUid);
		}
		
		/** 关闭所有面板 */
		private function hideAllPanes():void
		{
			if(loginPane) { loginPane.hide(); }
			if(createRolePane) { createRolePane.hide(); }
			if(selectRolePane) { selectRolePane.hide(); }
			if(disConnPane) { disConnPane.hide(); }
		}
		
		/** 销毁所有登录相关的资源，因为已经完成登录了 */
		public function dispose():void
		{
			hideAllPanes();
			loginPane = null;
			createRolePane = null;
			selectRolePane = null;
		}
	}
}