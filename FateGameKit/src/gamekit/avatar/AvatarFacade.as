package gamekit.avatar
{
	import com.anstu.jcommon.struct.HashSet;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import gamekit.avatar.material.AvatarLayer;
	import gamekit.avatar.material.AvatarProxy;
	import gamekit.layer.Layer;

	public class AvatarFacade
	{
		private static var instance:AvatarFacade;
		
		public static function getInstance():AvatarFacade
		{
			if(instance == null) { instance = new AvatarFacade(); }
			return instance;
		}
		
		/** AvatarProxy实例的注册表 */
		private var regTable:HashSet = new HashSet();
		/** 注册AvatarProxy实例 */
		public function register(proxy:AvatarProxy):void
		{
			regTable.add(proxy);
		}
		/** 注销AvatarProxy实例 */
		public function unregister(proxy:AvatarProxy):void
		{
			regTable.remove(proxy);
		}
		
		public function AvatarFacade()
		{
			if(instance != null) { throw new Error("AvatarFacade should be single!"); }
			instance = this;
		}
		
		/** 初始化 */
		public function initialize():void
		{
			//
		}
		
		/** ENTER_FRAME */
		public function nextFrame():void
		{
			regTable.eachDo(proxyNext);
			Layer.avatar.nextFrame();
		}
		private function proxyNext(proxy:AvatarProxy):void
		{
			proxy.nextFrame();
		}
		
	}
}