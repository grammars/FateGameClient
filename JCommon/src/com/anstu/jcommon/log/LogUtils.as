package com.anstu.jcommon.log
{
	import flash.utils.Dictionary;

	public class LogUtils
	{
		public function LogUtils()
		{
		}
		
		/** 打印出数据结构 */
		public static function varDump(obj:*, thisLev:int=LogLevel.ALL):void 
		{
			if(thisLev < Log.getLevel()) { return; }
			switch (typeof(obj))
			{
				case "object":
				{
					if(obj is Dictionary)
					{
						dealVar("【Dictionary*】");
						for(var word:* in obj)
						{
							dealVar("【key*】" + word + "【*key】");
							dealVar("【val*】");
							varDump(obj[word]);
							dealVar("【*val】");
						}
						dealVar("【*Dictionary】");
					}
					else if(obj is Array)
					{
						dealVar("【Array*】");
						var arr:Array = obj as Array;
						for(var i:int = 0; i < arr.length; i++)
						{
							dealVar("【" + i + "】");
							varDump(arr[i]);
						}
						dealVar("【*Array】");
					}
					else
					{
						dealVar("【Object*】");
						for(var key:* in obj)
						{
							dealVar("【key*】" + key + "【*key】");
							dealVar("【val*】");
							varDump(obj[key]);
							dealVar("【*val】");
						}
						dealVar("【*Object】");
					}
				}
					break;
				case "xml":
				{
					dealVar("【xml*】" + obj + "【*xml】");
				}
					break;
				default:
				{
					dealVar("【" + typeof(obj) + "*】" + obj + "【*" + typeof(obj) + "】");
				}
					break;
			}
		}
		/** dealVar */
		private static function dealVar(obj:*):void
		{
			trace(obj);
		}
		
	}
}