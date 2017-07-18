package  com.anstu.jcommon.utils
{
	import com.anstu.jcommon.struct.RefStr;
	
	import flash.utils.Dictionary;
	
	public class Analyze
	{
		public function Analyze()
		{
			trace("Analyze Constructor");
		}
		
		/** 打印出数据结构 */
		public static function varDump(obj:*):void 
		{
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
		
		private static function dealVar(obj:*):void
		{
			trace(obj);
		}
		
		
		/** 将Object转换为XML风格的字符串【只与本类中的xml2obj可逆】
		 * obj2xml xml2obj 配合示例
		 * var input:Object = {...};
		 * var rs:RefStr = new RefStr();
		 * obj2xml(input, rs);
		 * var xml:XML = XML(rs.str);
		 * var xl:XMLList = xml.children();
		 * var output:* = new Dictionary/Array/Object();
		 * 根据xml.name().toString()来决定output的类型是Dic,Array还是Obj
		 * xml2obj(xl, output); */
		public static function obj2xml(input:Object, output:RefStr):void
		{
			switch (typeof(input))
			{
				case "object":
				{
					if(input is Dictionary)
					{
						output.val += "<Dictionary>";
						for(var word:* in input)
						{
							output.val += "<" + word + ">";
							obj2xml(input[word], output);
							output.val += "</" + word + ">";
						}
						output.val += "</Dictionary>";
					}
					else if(input is Array)
					{
						output.val += "<Array>";
						var arr:Array = input as Array;
						for(var i:int = 0; i < arr.length; i++)
						{
							output.val += "<item>";
							obj2xml(arr[i], output);
							output.val += "</item>";
						}
						output.val += "</Array>";
					}
					else
					{
						output.val += "<Object>";
						for(var key:* in input)
						{
							output.val += "<" + key + ">";
							obj2xml(input[key], output);
							output.val += "</" + key + ">";
						}
						output.val += "</Object>";
					}
				}
					break;
				case "output":
				{
					output.val += XML(input).toXMLString();
				}
					break;
				default:
				{
					output.val += input;
				}
					break;
			}
		}
		
		
		/** 将XMLList(去掉根类型节点之后的部分)转换为Object【只与本类中的obj2xml可逆】
		 * 仅用来根据obj2xml生成的XML来生成对象
		 * obj2xml xml2obj 配合示例
		 * var input:Object = {...};
		 * var rs:RefStr = new RefStr();
		 * obj2xml(input, rs);
		 * var xml:XML = XML(rs.str);
		 * var xl:XMLList = xml.children();
		 * var output:* = new Dictionary/Array/Object();
		 * 根据xml.name().toString()来决定output的类型是Dic,Array还是Obj
		 * xml2obj(xl, output); */
		public static function xml2obj(input:XMLList, output:Object):void
		{
			for each(var node:XML in input)
			{
				if(node.children().toString() == "")
				{
					trace("遭遇空节点继续");
					continue;
				}
				if(node.children().length() > 1)
				{
					trace("不符合解析规范，退出");
					break;
				}
				var condition:String = node.children().name() ? node.children().name().toString() : "null";
				switch( condition )
				{
					case "Dictionary":
						var dic:Dictionary = new Dictionary();
						output[node.name()] = dic;
						xml2obj(node.children().children(), dic);
						break;
					case "Array":
						var arr:Array = new Array();
						output[node.name()] = arr;
						xml2obj(node.children().children(), arr);
						break;
					case "Object":
						var obj:Object = new Object();
						output[node.name()] = obj;
						xml2obj(node.children().children(), obj);
						break;
					default:
						if(output is Array)
						{
							(output as Array).push(node.toString());
						}
						else
						{
							output[node.name()] = node.toString();
						}
				}
			}
		}
		
	}
}