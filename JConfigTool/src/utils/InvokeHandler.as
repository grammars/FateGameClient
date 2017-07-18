package utils
{
	import data.Tag;
	
	import flash.desktop.NativeApplication;
	import flash.events.InvokeEvent;
	import flash.filesystem.File;
	
	import manage.CentreManage;
	
	import mx.controls.Alert;

	public class InvokeHandler
	{
		public function InvokeHandler()
		{
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, __invoke);
		}
		
		protected function __invoke(event:InvokeEvent):void
		{
			for(var i:int = 0; i < event.arguments.length; i++)
			{
				handleNativePath( event.arguments[i] );
			}
		}
		
		/** 处理本地invoke路径 */
		protected function handleNativePath(path:String):void
		{
			trace("handleNativePath(" + path + ")");
			try
			{
				var startFile:File = new File(path);
				if(startFile.extension == Tag.PROJ_CFG_EXT)
				{
					CentreManage.readProjCfgFile(startFile);
				}
			}
			catch(e:Error)
			{
				Alert.show("启动参数错误", "警告");
			}
		}
		
	}
}