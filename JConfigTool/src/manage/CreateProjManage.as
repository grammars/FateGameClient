package manage
{
	import data.Tag;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import manage.createProj.CreateProjView;
	
	import mx.managers.PopUpManager;

	public class CreateProjManage
	{
		private static var pane:CreateProjView;
		
		public function CreateProjManage()
		{
		}
		
		public static function startup():void
		{
			pane = new CreateProjView();	
		}
		
		public static function show():void
		{
			PopUpManager.addPopUp(pane, CentreManage.winApp);
			PopUpManager.centerPopUp(pane);
		}
		
		public static function hide():void
		{
			PopUpManager.removePopUp(pane);
		}
		
		/** 创建一个新的项目 */
		public static function create(projName:String, projSpace:String):void
		{
			CentreManage.projName = projName;
			CentreManage.projSpace = projSpace;
			
			var projConfigFileFullPath:String = projSpace + "\\" + projName + "." + Tag.PROJ_CFG_EXT;//项目配置文件完整路径
			var projConfigFile:File = new File(projConfigFileFullPath);
			var projConfigStream:FileStream = new FileStream();
			projConfigStream.open(projConfigFile, FileMode.WRITE);
			projConfigStream.writeMultiByte(CentreManage.makeProjCfgContent(), "UTF-8");
			projConfigStream.close();
			
			CentreManage.makeProjStruct();
			CentreManage.updateProjSpace();
		}
		
	}
}