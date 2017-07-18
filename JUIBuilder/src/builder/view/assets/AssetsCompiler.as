package builder.view.assets
{
	import builder.Builder;
	import builder.view.StatusBar;
	
	import com.adobe.images.JPGEncoder;
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.data.consts.BitmapType;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG2;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG3;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import org.as3commons.bytecode.abc.AbcFile;
	import org.as3commons.bytecode.abc.enum.Opcode;
	import org.as3commons.bytecode.emit.IClassBuilder;
	import org.as3commons.bytecode.emit.ICtorBuilder;
	import org.as3commons.bytecode.emit.IPackageBuilder;
	import org.as3commons.bytecode.emit.impl.AbcBuilder;
	import org.as3commons.bytecode.io.AbcSerializer;

	public class AssetsCompiler
	{
		/** 是否正在编译 */
		private static var isCompIng:Boolean = false;
		/** 本次需要搞定的总任务数 */
		private static var totalTaskNum:int = 0;
		/** 当前需要搞定的任务数 */
		private static function get leftTaskNum():int
		{
			if(taskUrls) { return taskUrls.length; }
			return 0;
		}
		
		private static var taskUrls:Vector.<String>;
		
		public function AssetsCompiler()
		{
		}
		
		/** 编译资源 */
		public static function comp():void
		{
			if(isCompIng)
			{
				StatusBar.instance.show("当前正在编译，请勿执行任何操作");
				return;
			}
			
			taskUrls = Builder.assetsDoc.getAllNodeUrls();
			initSwf();
			totalTaskNum = taskUrls.length;
			
			compOne();
			
			isCompIng = true;
		}
		
		private static function compOne():void
		{
			var relPath:String;
			if(taskUrls.length > 0)
			{
				relPath = taskUrls.pop();
				//trace("任务路径 " + relPath);
			}
			else
			{
				return;
			}
			var url:String = Builder.assetsDirFull() + relPath;
			var task:AssetsCompTask = new AssetsCompTask(relPath, url);
		}
		
		private static const PACKAGENAME:String = "";//默认包
		private static const BMD_CLASS:String = "flash.display.BitmapData";
		private static var swf:SWF;
		private static var abcBuilder:AbcBuilder;
		private static var packageBuilder:IPackageBuilder;
		private static var symbolClass:TagSymbolClass;
		private static var currentCharacterId:int;
		
		private static function initSwf():void
		{
			swf = new SWF();
			swf.tags.push(new TagFileAttributes());
			abcBuilder = new AbcBuilder();
			packageBuilder = abcBuilder.definePackage(PACKAGENAME);
			symbolClass = new TagSymbolClass();
			currentCharacterId = 1;
		}
		
		/** 处理加载好的任务 */
		public static function handleLoadedTask(task:AssetsCompTask):void
		{
			var statusDebugStr:String = "";
			if(task.loadSucc)
			{
				switch(task.type)
				{
				case AssetsCompTask.PNG:
					addPicARGB(task.className, task.bmd);
					break;
				case AssetsCompTask.BMP:
				case AssetsCompTask.JPEG:
				case AssetsCompTask.JPG:
				case AssetsCompTask.GIF:
					addPicRGB(task.className, task.bmd);
					break;
				}
				statusDebugStr = "编译 " + task.className + " 成功,进度(" + leftTaskNum + "/" + totalTaskNum + ")";
			}
			else
			{
				statusDebugStr = "Error:编译 " + task.className + " 失败,进度(" + leftTaskNum + "/" + totalTaskNum + ")";
			}
			trace(statusDebugStr);
			StatusBar.instance.show(statusDebugStr);
			
			if(leftTaskNum <= 0)
			{
				exportSwf();
			}
			else
			{
				compOne();
			}
		}
		
		private static function addPicRGB(className:String, bmd24:BitmapData):void
		{
			const imgWidth:int = bmd24.width;
			const imgHeight:int = bmd24.height;
			var classBuilder:IClassBuilder = packageBuilder.defineClass(className, BMD_CLASS);
			classBuilder.isDynamic = true;
			var ctorBuilder:ICtorBuilder = classBuilder.defineConstructor();
			ctorBuilder.defineArgument("int", true, imgWidth);
			ctorBuilder.defineArgument("int", true, imgHeight);
			ctorBuilder.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.pushscope)
				.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.getlocal_1)
				.addOpcode(Opcode.getlocal_2)
				.addOpcode(Opcode.constructsuper, [2])
				.addOpcode(Opcode.returnvoid);
			
			symbolClass.symbols.push(SWFSymbol.create(currentCharacterId, PACKAGENAME + "." + className));
			
			var defineBitsJPEG2:TagDefineBitsJPEG2 = new TagDefineBitsJPEG2();
			defineBitsJPEG2.characterId = currentCharacterId;
			defineBitsJPEG2.bitmapType = BitmapType.JPEG;
			defineBitsJPEG2.bitmapData.writeBytes( PicEncoder.instance.encode(bmd24) );
			swf.tags.push(defineBitsJPEG2);
			
			currentCharacterId++;
		}
		
		private static function addPicARGB(className:String, bmd32:BitmapData):void
		{
			const imgWidth:int = bmd32.width;
			const imgHeight:int = bmd32.height;
			var classBuilder:IClassBuilder = packageBuilder.defineClass(className, BMD_CLASS);
			classBuilder.isDynamic = true;
			var ctorBuilder:ICtorBuilder = classBuilder.defineConstructor();
			ctorBuilder.defineArgument("int", true, imgWidth);
			ctorBuilder.defineArgument("int", true, imgHeight);
			ctorBuilder.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.pushscope)
				.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.getlocal_1)
				.addOpcode(Opcode.getlocal_2)
				.addOpcode(Opcode.constructsuper, [2])
				.addOpcode(Opcode.returnvoid);
			
			symbolClass.symbols.push(SWFSymbol.create(currentCharacterId, PACKAGENAME + "." + className));
			
			var alphaBytes:ByteArray = new ByteArray();
			var rgbBmd:BitmapData = new BitmapData(imgWidth, imgHeight, false, 0x0);
			for(var y:int = 0; y < imgHeight; y++)
			{
				for(var x:int = 0; x < imgWidth; x++)
				{
					rgbBmd.setPixel( x, y, bmd32.getPixel(x, y) );
					alphaBytes.writeByte( (bmd32.getPixel32(x, y)>>24) );
				}
			}
			alphaBytes.compress();
			
			var defineBitsJPEG3:TagDefineBitsJPEG3 = new TagDefineBitsJPEG3();
			defineBitsJPEG3.characterId = currentCharacterId;
			defineBitsJPEG3.bitmapType = BitmapType.PNG;
			defineBitsJPEG3.bitmapAlphaData.writeBytes( alphaBytes );
			defineBitsJPEG3.bitmapData.writeBytes( PicEncoder.instance.encode(rgbBmd) );
			swf.tags.push(defineBitsJPEG3);
			
			currentCharacterId++;
		}
		
		/** 导出SWF文件 */
		private static function exportSwf():void
		{
			var abcFile:AbcFile = abcBuilder.build();
			var abcSerializer:AbcSerializer = new AbcSerializer();
			var abcBytes:ByteArray = abcSerializer.serializeAbcFile(abcFile);
			
			swf.tags.push(TagDoABC.create(abcBytes));
			swf.tags.push(symbolClass);
			swf.tags.push(new TagShowFrame());
			swf.tags.push(new TagEnd());
			
			var swfData:SWFData = new SWFData();
			swf.publish(swfData);
			
			var file:File = new File(Builder.outputDirFull()+Builder.assetsSwfName);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeBytes(swfData);
			
			StatusBar.instance.show("UI资源文件" + Builder.assetsSwfName + "编译成功");
			totalTaskNum = 0;
			isCompIng = false;
		}
		
	}
}