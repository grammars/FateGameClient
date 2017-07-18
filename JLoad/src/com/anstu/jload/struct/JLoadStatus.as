package com.anstu.jload.struct
{
	public class JLoadStatus
	{
		
		/** 任务是否已被启动 */
		public var started:Boolean = false;
		/** 任务加载完毕 */
		public var loaded:Boolean = false;
		/** 任务失败 */
		public var failed:Boolean = false;
		/** bytesLoaded */
		public var bytesLoaded:Number = 0;
		/** bytesLoaded */
		public var bytesTotal:Number = 0;
		/** 最大尝试次数 */
		public var maxTry:int = 3;
		/** 已经尝试次数 */
		public var curTry:int = 0;
		/** 响应以 URLRequestHeader 对象的数组形式返回的响应标头。@see flash.net.URLRequestHeader<br>
		 * 在 Flash Player 中，只有一种类型的 HTTPStatus 事件：httpStatus。在 AIR 运行时中，FileReference、URLLoader 或 URLStream 可以注册侦听 httpResponseStatus，该事件包括 responseURL 和 responseHeaders 属性。这些属性在 httpStatus 事件中不进行定义。 */
		public var responseHeaders:Array;
		/** 从中返回响应的 URL。对于重定向，这将与请求 URL 不同 */
		public var responseURL:String;
		/** 由服务器返回的 HTTP 状态代码。例如，值为 404 表示服务器尚未找到所请求 URI 的匹配项。可以在 http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html 上的 HTTP 规范的第 10.4 和 10.5 节中找到 HTTP 状态代码。 <br>
		 如果 Flash Player 或 AIR 无法从服务器获取状态代码或无法与服务器进行通信，则会将默认值 0 传递到您的代码。在任何播放器中都可生成值 0（例如，如果请求的 URL 格式不正确），并且当 Flash Player 插件在以下不将 HTTP 状态代码传递到播放器的浏览器中运行时，值 0 始终由 Flash Player 插件生成：Netscape、Mozilla、Safari、Opera 和用于 Macintosh 的 Internet Explorer<br>
		 * 在 Flash Player 中，只有一种类型的 HTTPStatus 事件：httpStatus。在 AIR 运行时中，FileReference、URLLoader 或 URLStream 可以注册侦听 httpResponseStatus，该事件包括 responseURL 和 responseHeaders 属性。这些属性在 httpStatus 事件中不进行定义。
		 */
		public var httpStatus:int;
		
		public function JLoadStatus()
		{
		}
		
		public function toString():String
		{
			var info:String = "{status}=> ";
			info += "started=" + started + " ";
			info += "loaded=" + loaded + " ";
			info += "failed=" + failed + " ";
			info += "curTry=" + curTry + " ";
			info += "maxTry=" + maxTry + " ";
			info += bytesLoaded + "/" + bytesTotal + "(byte) " + (100*bytesLoaded/bytesTotal).toFixed(2) + "% \r";
			info += "httpStatus=" + httpStatus + " ";
			info += "responseURL=" + responseURL + " ";
			info += "responseHeaders=>";
			if(responseHeaders != null)
			{
				for(var i:int = 0; i < responseHeaders.length; i++)
				{
					info += responseHeaders[i] + " ";
				}
			}
			info += "\r";
			return info;
		}
		
	}
}