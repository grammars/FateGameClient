package com.anstu.jload.past
{
	public class LoadTarType
	{
		/** 二进制 */
		public static const BINARY:String = "binary";//URLLoaderDataFormat.BINARY
		/** 纯文本 */
		public static const TEXT:String = "text";//URLLoaderDataFormat.TEXT
		/** URL变量 */
		public static const VARIABLES:String = "variables";//URLLoaderDataFormat.VARIABLES
		/** 显示对象(为了获得应用程序域)[适用于有链接名的] */
		public static const APP_DOMAIN:String = "appDomain";
		/** 显示对象(为了直接获得显示对象)[适用于无链接名的] */
		public static const DIS_CONTENT:String = "disContent";
		
		public function LoadTarType()
		{
		}
	}
}