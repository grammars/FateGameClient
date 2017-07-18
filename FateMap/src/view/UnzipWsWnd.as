package view
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipFile;
	
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JSlider;
	import org.aswing.JTextField;
	import org.aswing.border.BevelBorder;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;
	import org.aswing.geom.IntRectangle;
	
	public class UnzipWsWnd
	{
		private static var _me:UnzipWsWnd;
		public static function me():UnzipWsWnd
		{
			if(_me == null) { _me = new UnzipWsWnd(); }
			return _me;
		}
		
		private var frame:JFrame;
		
		private const WND_W:int = 320;
		private const WND_H:int = 200;
		
		private var inFileAddrLabel:JLabel;
		private var outFileAddrLabel:JLabel;
		
		public function UnzipWsWnd()
		{
			frame = new JFrame(Global.getMainFrm(), "解压ws", true);
			frame.setSizeWH(WND_W, WND_H);
			frame.setResizable(false);
			var content:JPanel = new JPanel();
			//content.setBorder(new LineBorder(null, ASColor.RED, 1));
			content.setLayout(new EmptyLayout());
			frame.getContentPane().append(content);
			
			var selectFileBtn:JButton = new JButton("选择ws文件...");
			selectFileBtn.setBounds(new IntRectangle(0, 10, WND_W-10, 24));
			selectFileBtn.addActionListener(__selectFileBtn);
			content.append(selectFileBtn);
			
			var inFileAddrDescLabel:JLabel = new JLabel("ws文件地址：");
			inFileAddrDescLabel.setBounds(new IntRectangle(0, 40, WND_W-10, 24));
			content.append(inFileAddrDescLabel);
			
			inFileAddrLabel = new JLabel("...");
			inFileAddrLabel.setBounds(new IntRectangle(0, 70, WND_W-10, 24));
			inFileAddrLabel.setBorder(new BevelBorder());
			content.append(inFileAddrLabel);
			
			var outFileAddrDescLabel:JLabel = new JLabel("导出文件地址：");
			outFileAddrDescLabel.setBounds(new IntRectangle(0, 100, WND_W-10, 24));
			content.append(outFileAddrDescLabel);
			
			outFileAddrLabel = new JLabel("...");
			outFileAddrLabel.setBounds(new IntRectangle(0, 130, WND_W-10, 24));
			outFileAddrLabel.setBorder(new BevelBorder());
			content.append(outFileAddrLabel);
		}
		
		private function __selectFileBtn(e:AWEvent):void
		{
			var f:File = new File();
			f.addEventListener(Event.SELECT, __wsFileSelected);
			f.browseForOpen("ws文件");
		}
		
		private function __wsFileSelected(e:Event):void
		{
			var f:File = e.target as File;
			inFileAddrLabel.setText(f.nativePath);
			//
			var ifs:FileStream = new FileStream();
			ifs.open(f, FileMode.READ);
			var ibs:ByteArray = new ByteArray();
			ifs.readBytes(ibs);
			trace("ibs.bytesAvailable=", ibs.bytesAvailable);
			
			var zipFile:ZipFile = new ZipFile(ibs);
			var entry:ZipEntry;
			var text:ByteArray;
			var list:Array = [];
			var total : int = zipFile.entries.length;
			trace("total=", total);
			for(var i:int = 0; i < zipFile.entries.length; i++)
			{
				entry = zipFile.entries[i];
				text  = zipFile.getInput(entry);
				var fileName : String = entry.name;
				trace("fileName :",fileName);
				var key : String = fileName.slice(0,fileName.lastIndexOf("."));
				var fileType : String = fileName.slice(fileName.lastIndexOf(".")+1,fileName.length);
				trace("key",key,"fileType",fileType,"fileName",fileName,"text",String(text).substr(0,100));
				if(fileType == "xml")
				{
					//Engine.app.xmlManager.addXml(key,XML(text));
				}
				else if(fileType == "txt" || fileType == "properties")
				{
					/*					if(fileType == "txt")
					trace("key",key,"fileType",fileType,"fileName",fileName,"text",text);*/
					//Engine.app.xmlManager.addTxt(key,String(text));
				}
				else if(fileType == "swf") 
				{
					var url:String = "story/"+key+".swf"
					
				}
			}
		}
		
		public function open():void
		{
			var posX:int = Global.getMainFrm().getX() + (Global.getMainFrm().getWidth() - WND_W) / 2;
			var posY:int = Global.getMainFrm().getY() + (Global.getMainFrm().getHeight() - WND_H) / 2;
			frame.setLocationXY(posX, posY);
			frame.show();
		}
		
		public function close():void
		{
			frame.hide();
		}
		
	}
}