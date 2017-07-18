package builder
{
	import builder.ctrls.base.BuilderAssetFiller;
	import builder.ctrls.base.CShellClickHandler;
	import builder.view.Alert;
	import builder.view.PropBox;
	import builder.view.StatusBar;
	import builder.view.UIBox;
	import builder.view.UICanvas;
	import builder.view.assets.AssetsDoc;
	import builder.view.radio.RadioGroupEditor;
	import builder.view.tab.TabPairEditor;
	import builder.view.template.TemplateEditor;
	
	import com.anstu.jui.build.BU;
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.build.ctrls.base.CShellContext;
	import com.anstu.jui.components.JComponent;
	import com.anstu.jui.components.JTextFormat;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.ui.Keyboard;

	public class Builder
	{
		/** 犹如构造函数的初始化 */
		public static function initialize():void
		{
			CShellContext.instance.assetFiller = BuilderAssetFiller.instance;
			CShellContext.instance.clickHandler = CShellClickHandler.instance;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __stageKeyDown);
		}
		
		/** 文档后缀 */
		public static const EXT:String = "xml";
		/** 项目后缀 */
		public static const PROJ_EXT:String = "proj";
		/** 项目所在目录 */
		public static var projName:String = "myProject";
		/** 模版所在目录 */
		public static const TEMPLATES_DIR:String = "templates";
		/** ui资源所在目录 */
		public static const ASSETS_DIR:String = "assets";
		/** ui资源配置输出文件名 */
		public static const ASSETS_CFG_FILE:String = "assets.xml"; 
		/** 文档预览图所在目录 */
		private static const SNAP_DIR:String = "snap";
		/** 资源包输出所在目录 */
		private static const OUTPUT_DIR:String = "output";
		
		
		/** 资源包文件名 */
		public static function get assetsSwfName():String
		{
			return projName+"_assets.swf";
		}
		
		/** 分隔文件名中路径斜杠的符号 */
		public static const CLASSNAME_SLASH_TAG:String = "_";
		/** 分隔文件名部分和后缀部分的符号 */
		public static const CLASSNAME_EXT_TAG:String = "$";
		
		public static function appDir():String
		{
			return File.applicationDirectory.nativePath + File.separator;
		}
		
		public static function docDirFull():String
		{
			return File.applicationDirectory.nativePath + File.separator + projName + File.separator;
		}
		
		public static function templatesDirFull():String
		{
			return docDirFull() + TEMPLATES_DIR + File.separator;
		}
		
		public static function assetsDirFull():String
		{
			return docDirFull() + ASSETS_DIR + File.separator;
		}
		/** ui资源配置文件 */
		public static function assetsCfgFileFull():String
		{
			return docDirFull() + ASSETS_DIR + File.separator + ASSETS_CFG_FILE;
		}
		/** ui资源配置备份目录 */
		public static function assetsCfgBakFull():String
		{
			return docDirFull() + ASSETS_DIR + File.separator + "assets.bak" + File.separator;
		}
		public static function snapDirFull():String
		{
			return docDirFull() + SNAP_DIR + File.separator;
		}
		public static function outputDirFull():String
		{
			return docDirFull() + OUTPUT_DIR + File.separator;
		}
		
		/** 湖蓝色 */
		public static const LAKE_BLUE:uint = 0xa5dcdc;
		/** 深灰 */
		public static const DARK_GREY:uint = 0x2b2b2b;
		/** 奶白 */
		public static const MILK_WHITE:uint = 0xfedede;
		
		public static function defaultFont():JTextFormat
		{
			return new JTextFormat("微软雅黑", 14, LAKE_BLUE);
		}
		
		public static var root:Sprite;
		public static var stage:Stage;
		
		private static var shellDic:Object = new Object();
		public static function regShell(shell:CShell):void
		{
			shellDic[shell.getTag()] = shell;
		}
		public static function getShell(tag:String):CShell
		{
			if(shellDic[tag]) { return shellDic[tag]; }
			return null;
		}
		
		/** 当前编辑的文档 */
		public static var doc:Document;
		/** 当前编辑的资源档 */
		public static var assetsDoc:AssetsDoc = new AssetsDoc();
		
		/** 获得资源相对路径 */
		public static function makeAssetsRePath(path:String):String
		{
			var relPath:String = path.replace(assetsDirFull(), "");
			return relPath;
		}
		
		/** 获得资源的类名 */
		public static function makeAssetsClassName(path:String):String
		{
			var relPath:String = makeAssetsRePath(path);
			var className:String = relPath;
			className = BU.replace(className, ".", Builder.CLASSNAME_EXT_TAG);
			className = BU.replace(className, "//", Builder.CLASSNAME_SLASH_TAG);
			className = BU.replace(className, "\\\\", Builder.CLASSNAME_SLASH_TAG);
			className = BU.replace(className, "/", Builder.CLASSNAME_SLASH_TAG);
			className = BU.replace(className, "\\", Builder.CLASSNAME_SLASH_TAG);
			return className;
		}
		
		public function Builder()
		{
		}
		
		/** 编辑器启动时设置 */
		public static function setup():void
		{
			projName = BuilderCfg.defaultProj;
			ProjManager.updateProjCfg();
			ProjManager.open(projName);
		}
		
		public static function frameUI(comp:JComponent):void
		{
			comp.frameLineThick = 2;
			comp.frameLineColor = LAKE_BLUE;
			comp.frameFillColor = DARK_GREY;
			comp.useFrame = true;
		}
		
		public static function show(sprite:Sprite, centre:Boolean=true):void
		{
			sprite.x = (stage.stageWidth-sprite.width)/2;
			sprite.y = (stage.stageHeight-sprite.height)/2;
			root.addChild(sprite);
		}
		
		private static var curTarget:CShell;
		/** 设置当前目标容器 */
		public static function setTarget(target:CShell):void
		{
			if(curTarget) { curTarget.selected = false; }
			curTarget = target;
			if(curTarget) { curTarget.selected = true; }
			PropBox.instance.parentUpdate();
		}
		/** 获取当前目标容器 */
		public static function getTarget():CShell
		{
			return curTarget;
		}
		
		/** 添加一个CShell */
		public static function addShell(child:CShell):void
		{
			if( curTarget )
			{
				curTarget.addShell(child);
			}
			else
			{
				UICanvas.instance.addShell(child);
			}
			setTarget(child);
		}
		
		/** 创建新文档 */
		public static function createDoc(docName:String):void
		{
			UICanvas.instance.clear();
			RadioGroupEditor.instance.clearGroup();
			TabPairEditor.instance.clearPairs();
			setTarget(null);
			doc = new Document(docName);
			UIBox.instance.enableBtns();
			shellDic = new Object();
		}
		
		/** 打开文档 */
		public static function openDoc(fileName:String, docText:String):void
		{
			UICanvas.instance.clear();
			RadioGroupEditor.instance.clearGroup();
			TabPairEditor.instance.clearPairs();
			setTarget(null);
			doc = new Document(fileName);
			UIBox.instance.enableBtns();
			
			DocParser.parse(docText);
		}
		
		/** 保存文档 */
		public static function saveDoc():void
		{
			if(doc)
			{
				Alert.instance.warn("正在保存!请勿操作", "提示");
				UICanvas.instance.snapshot();
				doc.save();
				Alert.instance.hide();
				StatusBar.instance.show(doc.fileName + "."+EXT+"保存成功");
			}
			else
			{
				Alert.instance.warn("没有需要保存的文档!", "错误操作");
			}
		}
		
		/** 关闭文档 */
		public static function closeDoc():void
		{
			UICanvas.instance.clear();
			RadioGroupEditor.instance.clearGroup();
			doc = null;
			UIBox.instance.enableBtns();
		}
		
		private static function __stageKeyDown(e:KeyboardEvent):void
		{
			switch(e.keyCode)
			{
			case Keyboard.LEFT:
				if(curTarget) { curTarget.x -= 1; }
				break;
			case Keyboard.RIGHT:
				if(curTarget) { curTarget.x += 1; }
				break;
			case Keyboard.UP:
				if(curTarget) { curTarget.y -= 1; }
				break;
			case Keyboard.DOWN:
				if(curTarget) { curTarget.y += 1; }
				break;
			}
		}
		
	}
}