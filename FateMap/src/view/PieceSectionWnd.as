package view
{
	import com.adobe.images.JPGEncoder;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import org.aswing.EmptyLayout;
	import org.aswing.JButton;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	import org.aswing.JTextField;
	import org.aswing.event.AWEvent;
	import org.aswing.geom.IntRectangle;
	import org.bytearray.decoder.JPEGDecoder;

	public class PieceSectionWnd
	{
		private static var _me:PieceSectionWnd;
		public static function me():PieceSectionWnd
		{
			if(_me == null) { _me = new PieceSectionWnd(); }
			return _me;
		}
		
		private var frame:JFrame;
		
		private const WND_W:int = 320;
		private const WND_H:int = 280;
		
		private var tileYRangeBegInput:JTextField;
		private var tileYRangeEndInput:JTextField;
		private var tileXRangeBegInput:JTextField;
		private var tileXRangeEndInput:JTextField;
		private var delimiterInput:JTextField;
		private var extensionInput:JTextField;
		private var dirInput:JTextField;
		private var exeBtn:JButton;
		
		public function PieceSectionWnd()
		{
			frame = new JFrame(Global.getMainFrm(), "整合切片", true);
			frame.setSizeWH(WND_W, WND_H);
			frame.setResizable(false);
			
			var content:JPanel = new JPanel();
			//content.setBorder(new LineBorder(null, ASColor.RED, 1));
			content.setLayout(new EmptyLayout());
			frame.getContentPane().append(content);
			
			var tileYRangeLabel:JLabel = new JLabel("切片y范围:");
			tileYRangeLabel.setBounds(new IntRectangle(0, 10, 80, 24));
			content.append(tileYRangeLabel);
			
			var tileXRangeLabel:JLabel = new JLabel("切片x范围:");
			tileXRangeLabel.setBounds(new IntRectangle(0, 40, 80, 24));
			content.append(tileXRangeLabel);
			
			tileYRangeBegInput = new JTextField("0");
			tileYRangeBegInput.setRestrict("0-9");
			tileYRangeBegInput.setBounds(new IntRectangle(90, 10, 40, 24));
			content.append(tileYRangeBegInput);
			
			tileYRangeEndInput = new JTextField("0");
			tileYRangeEndInput.setRestrict("0-9");
			tileYRangeEndInput.setBounds(new IntRectangle(140, 10, 40, 24));
			content.append(tileYRangeEndInput);
			
			tileXRangeBegInput = new JTextField("0");
			tileXRangeBegInput.setRestrict("0-9");
			tileXRangeBegInput.setBounds(new IntRectangle(90, 40, 40, 24));
			content.append(tileXRangeBegInput);
			
			tileXRangeEndInput = new JTextField("0");
			tileXRangeEndInput.setRestrict("0-9");
			tileXRangeEndInput.setBounds(new IntRectangle(140, 40, 40, 24));
			content.append(tileXRangeEndInput);
			
			var delimiterLabel:JLabel = new JLabel("分隔符:");
			delimiterLabel.setBounds(new IntRectangle(0, 70, 80, 24));
			content.append(delimiterLabel);
			
			delimiterInput = new JTextField("_");
			delimiterInput.setBounds(new IntRectangle(90, 70, 40, 24));
			content.append(delimiterInput);
			
			var extensionLabel:JLabel = new JLabel("后缀名:");
			extensionLabel.setBounds(new IntRectangle(0, 100, 80, 24));
			content.append(extensionLabel);
			
			extensionInput = new JTextField(".jpg");
			extensionInput.setBounds(new IntRectangle(90, 100, 40, 24));
			content.append(extensionInput);
			
			var dirLabel:JLabel = new JLabel("目录:");
			dirLabel.setBounds(new IntRectangle(0, 130, 80, 24));
			content.append(dirLabel);
			
			var dirBrowseBtn:JButton = new JButton("浏览...");
			dirBrowseBtn.setBounds(new IntRectangle(90, 130, 90, 24));
			dirBrowseBtn.addActionListener(__dirBrowseBtn);
			content.append(dirBrowseBtn);
			
			dirInput = new JTextField(File.applicationDirectory.nativePath);
			dirInput.setBounds(new IntRectangle(0, 160, WND_W-10, 24));
			content.append(dirInput);
			
			exeBtn = new JButton("执行");
			exeBtn.setBounds(new IntRectangle(0, 190, WND_W-10, 24));
			exeBtn.addActionListener(__exeBtn);
			content.append(exeBtn);
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
		
		private function __dirBrowseBtn(e:AWEvent):void
		{
			var f:File = new File();
			f.addEventListener(Event.SELECT, __sectionDirSelected);
			f.browseForDirectory("切片所在目录");
		}
		
		private function __sectionDirSelected(e:Event):void
		{
			var f:File = e.target as File;
			dirInput.setText(f.nativePath);
		}
		
		private function __exeBtn(e:AWEvent):void
		{
			exeBtn.setEnabled(false);
			
			var tileYRangeBeg:int = parseInt(tileYRangeBegInput.getText());
			var tileYRangeEnd:int = parseInt(tileYRangeEndInput.getText());
			var tileXRangeBeg:int = parseInt(tileXRangeBegInput.getText());
			var tileXRangeEnd:int = parseInt(tileXRangeEndInput.getText());
			var delimiter:String = delimiterInput.getText();
			var extension:String = extensionInput.getText();
			var dir:String = dirInput.getText();
			trace("tileYRangeBeg=" + tileYRangeBeg + " tileYRangeEnd=" + tileYRangeEnd + 
			" tileXRangeBeg=" + tileXRangeBeg + " tileXRangeEnd=" + tileXRangeEnd + 
			" delimiter=" + delimiter + " extension=" + extension + " dir=" + dir);
			//
			var secW:int = 0;
			var secH:int = 0;
			var totalW:int = 0;
			var totalH:int = 0;
			var bmdCache:Object = new Object();
			var y:int = 0;
			var x:int = 0;
			for(y = tileYRangeBeg; y <= tileYRangeEnd; y++)
			{
				for(x = tileXRangeBeg; x <= tileXRangeEnd; x++)
				{
					var szFile:String = dir + File.separator + y + delimiter + x + extension;
					var file:File = new File(szFile);
					if(file.exists)
					{
						var fs:FileStream = new FileStream();
						fs.open(file, FileMode.READ);
						var bytes:ByteArray = new ByteArray();
						fs.readBytes(bytes);
						var decoder:JPEGDecoder = new JPEGDecoder(bytes);
						var bmd:BitmapData = new BitmapData(decoder.width, decoder.height, true, 0x0);
						trace("decoder.width=", decoder.width, "decoder.height=", decoder.height);
						for(var i:int = 0; i < decoder.pixels.length; i++)
						{
							var px:int = i % decoder.width;
							var py:int = Math.floor(i / decoder.width);
							bmd.setPixel32(px, py, decoder.pixels[i]);
						}
						//
//						var bmp:Bitmap = new Bitmap(bmd);
//						bmp.x = x * 256;
//						bmp.y = y * 256;
//						Global.getStage().addChild(bmp);
						//
						var key:String = y + "_" + x;
						bmdCache[key] = bmd;
						if(y == tileYRangeBeg)
						{
							totalW += bmd.width;
							if(secW <= 0)
							{
								secW = bmd.width;
							}
						}
						if(x == tileXRangeBeg)
						{
							totalH += bmd.height;
							if(secH <= 0)
							{
								secH = bmd.height;
							}
						}
					}
				}
			}
			
			if(totalW <= 0 || totalH <= 0)
			{
				AlertWnd.me().show("未找到切片");
				exeBtn.setEnabled(true);
				return;
			}
			
			trace("totalW=", totalW, "totalH=", totalH);
			var resultBmd:BitmapData = new BitmapData(totalW, totalH, true, 0x0);
			for(y = tileYRangeBeg; y <= tileYRangeEnd; y++)
			{
				for(x = tileXRangeBeg; x <= tileXRangeEnd; x++)
				{
					var eachKey:String = y + "_" + x;
					var eachBmd:BitmapData = bmdCache[eachKey];
					var rect:Rectangle = new Rectangle(0, 0, secW, secH);
					var dp:Point = new Point(secW*(x-tileXRangeBeg), secH*(y-tileYRangeBeg));
					resultBmd.copyPixels(eachBmd, rect, dp);
				}
			}
			//Global.getStage().addChild(new Bitmap(resultBmd));
			var encoder:JPGEncoder = new JPGEncoder(100);
			var resultBytes:ByteArray = encoder.encode(resultBmd);
			var szOutputFile:String = dir + File.separator + "source.jpg"
			var outputFile:File = new File(szOutputFile);
			var os:FileStream = new FileStream();
			os.open(outputFile, FileMode.WRITE);
			os.writeBytes(resultBytes);
			os.close();
			AlertWnd.me().show("输出原图到" + szOutputFile);
			exeBtn.setEnabled(true);
		}
		
	}
}
