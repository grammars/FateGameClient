package builder
{
	import builder.view.UICanvas;
	import builder.view.radio.RadioGroupEditor;
	import builder.view.tab.TabPairEditor;
	
	import com.anstu.jui.build.ctrls.base.CShell;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.dns.AAAARecord;
	import flash.utils.ByteArray;

	public class Document
	{
		/** 文件名 */
		public var fileName:String = "default";
		
		/** 节点文本 */
		public var nodesText:String = "";
		
		public function Document(fileName:String="default")
		{
			this.fileName = fileName;
		}
		
		/** 保存当前 */
		public function save():void
		{
			nodesText = "<jui>\r";
			nodesText += "<head version='1.0'>\r";
			
			nodesText += "<radiogroup>\r";
			nodesText += RadioGroupEditor.instance.createNodes();
			nodesText += "</radiogroup>\r";
			
			nodesText += "<tabpair>\r";
			nodesText += TabPairEditor.instance.createNodes();
			nodesText += "</tabpair>\r";
			
			nodesText += "</head>\r";
			nodesText += "<body>\r";
			for(var i:int = 0; i < UICanvas.instance.getChildren().length; i++)
			{
				createNode(UICanvas.instance.getChildren()[i]);
			}
			nodesText += "</body>\r";
			nodesText += "</jui>";
			//trace("nodesText=" + nodesText);
			
			writeToFile();
		}
		
		private function writeToFile():void
		{
			var file:File = new File(Builder.docDirFull()+fileName+"."+Builder.EXT);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeMultiByte(nodesText, "UTF-8");
			fs.close();
		}
		
		private function createNode(shell:CShell):void
		{
			nodesText += shell.nodeBeg() + "\r";
			for(var i:int = 0; i < shell.getChildren().length; i++)
			{
				createNode(shell.getChildren()[i]);
			}
			nodesText += shell.nodeEnd() + "\r";
		}
		
	}
}