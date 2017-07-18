package com.anstu.jcommon.log
{
	/** OFF > FATAL > ERROR > WARN > INFO > DEBUG > ALL */
	public class LogLevel
	{
		/** 是最高等级的，用于关闭所有日志记录。 */
		public static const OFF:int = 0;
		/** 指出每个严重的错误事件将会导致应用程序的退出。 */
		public static const FATAL:int = 1;
		/** 指出虽然发生错误事件，但仍然不影响系统的继续运行。 */
		public static const ERROR:int = 2;
		/** 表明会出现潜在错误的情形。 */
		public static const WARN:int = 4;
		/** 表明 消息在粗粒度级别上突出强调应用程序的运行过程。 */
		public static const INFO:int = 8;
		/** 指出细粒度信息事件对调试应用程序是非常有帮助的。 */
		public static const DEBUG:int = 16;
		/** 是最低等级的，用于打开所有日志记录。 */
		public static const ALL:int = 32;
		
		public function LogLevel()
		{
		}
	}
} 