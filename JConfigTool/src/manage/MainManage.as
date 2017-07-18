package manage
{
	
	import flash.filesystem.File;
	
	import manage.main.MainView;
	
	import mx.collections.ArrayList;
	
	import data.FileInfo;

	public class MainManage
	{
		private static var mainView:MainView;
		
		public function MainManage()
		{
		}
		
		public static function startup():void
		{
			mainView = new MainView();
			CentreManage.winApp.addElement(mainView);
		}
		
		/** 刷新文件列表 */
		public static function updateFileList():void
		{
			updateFileListByType(CentreManage.getXlsxDir(), 0);
			updateFileListByType(CentreManage.getBufDir(), 1);
			updateFileListByType(CentreManage.getBinDir(), 2);
		}
		/** 根据类型更新文件列表 */
		private static function updateFileListByType(dir:String, type:int):void
		{
			var fis:Vector.<FileInfo> = new Vector.<FileInfo>();
			try
			{
				var df:File = new File(dir);
				if(df.exists)
				{
					var subFiles:Array = df.getDirectoryListing();
					for(var i:int = 0; i < subFiles.length; i++)
					{
						var file:File = subFiles[i];
						var fi:FileInfo = new FileInfo(file.nativePath, file.name, file.extension, file.size);
						fis.push(fi);
					}
				}
			}
			catch(e:Error)
			{
				//trace("目录不存在");
			}
			finally
			{
				mainView.updateFileList(fis, type);
			}
		}
		
		/** 获取当前全部任务 */
		public static function getTasks():ArrayList
		{
			return mainView.fileList.getTasks();
		}
		
		/** 移除指定任务 */
		public static function removeTask(task:Object):void
		{
			mainView.fileList.removeTask(task);
		}
		
		/** 更新进度 */
		public static function updateProgress(value:Number, total:Number, label:String=""):void
		{
			mainView.fileList.updateProgress(value, total, label);
		}
		
	}
}