package ui.ctrls.Framework{
	
	import ui.ctrls.Advanced.ComboScaleButton;
	import ui.ctrls.Advanced.ComboScaleStateButton;
	import ui.ctrls.Advanced.ListButton;
	import ui.ctrls.Advanced.ScaleButton;
	import ui.ctrls.Advanced.ScaleRadioButton;
	import ui.ctrls.Advanced.ScaleStateButton;
	import ui.ctrls.Advanced.ScaleTabButton;
	import ui.ctrls.Advanced.ScrollFieldLeft;
	import ui.ctrls.Advanced.ScrollFieldRight;
	import ui.ctrls.Advanced.SelectList;
	import ui.ctrls.Ape;
	import ui.ctrls.Button;
	import ui.ctrls.Container;
	import ui.ctrls.G9RptContainer;
	import ui.ctrls.Grids3Container;
	import ui.ctrls.Grids9Container;
	import ui.ctrls.Label;
	import ui.ctrls.Link;
	import ui.ctrls.NormalInput;
	import ui.ctrls.RadioButton;
	import ui.ctrls.StateButton;
	import ui.ctrls.StrokeLabel;
	import ui.ctrls.StrokeLink;
	import ui.ctrls.TabButton;
	import ui.ctrls.TileContainer;
	import ui.ctrls.Title;
	import ui.ctrls.UIInfo;
	import ui.ctrls.ZchangeG9RptContainer;
	import ui.ctrls.ZchangeTileContainer;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.TextInput;
	
	/**编辑器使用的UIXML解析*/
	public class UIXMLParser{
		
		static private var builder:MyUiBuilder;
		
		public function UIXMLParser(){
			
		}
		
		
		/**获取对MyUiBuilder的引用*/
		static public function setBuilder(builder:MyUiBuilder):void{
			UIXMLParser.builder = builder;
		}
		
		
		/**加载到UI编辑器*/
		static public function loadToBuilder(path:String, builder:MyUiBuilder):UIShell{
			var rootShell:UIShell;
			var srcXML:XML;
			var srcFile:File = new File(path);
			var srcStream:FileStream = new FileStream();
			srcStream.open(srcFile, FileMode.READ);
			var xmlString:String = srcStream.readUTFBytes(srcStream.bytesAvailable);
			if (xmlString != ""){
				srcXML = new XML(xmlString);
				rootShell = createShell(srcXML, builder);
			}
			
			return rootShell;
		}
		
		
		/**创建装UI的容器以及UI控件*/
		static private function createShell(srcXML:XML, builder:MyUiBuilder):UIShell{
			var shell:UIShell;
			var ctrl:Ape;
			var uiSubType:String = srcXML.name();
			ctrl = createUI(uiSubType);
			shell = new UIShell(ctrl, builder);
			readAllProp(shell, srcXML, builder);
			for each(var child:XML in srcXML.children()){
				var childShell:UIShell = createShell(child, builder);
				shell.canvas.addElement(childShell);
			}
			return shell;
		}
		
		
		/**创建单个UI*/
		static private function createUI(uiSubType:String):Ape{
			var ctrl:Ape;
			switch (uiSubType){
				case UIInfo.CONTAINER:
					ctrl = new ui.ctrls.Container();
					break;
				case UIInfo.TILE_CONTAINER:
					ctrl = new ui.ctrls.TileContainer();
					break;
				case UIInfo.GRIDS9CONTAINER:
					ctrl = new ui.ctrls.Grids9Container();
					break;
				case UIInfo.GRIDS3CONTAINER:
					ctrl = new ui.ctrls.Grids3Container();
					break;
				case UIInfo.G9RPTCONTAINER:
					ctrl = new ui.ctrls.G9RptContainer();
					break;
				case UIInfo.ZCHANGE_CONTAINER:
					ctrl = new ui.ctrls.ZchangeContainer();
					break;
				case UIInfo.ZCHANGE_TILE_CONTAINER:
					ctrl = new ui.ctrls.ZchangeTileContainer();
					break;
				case UIInfo.ZCHANGE_GRIDS9CONTAINER:
					ctrl = new ui.ctrls.ZchangeGrids9Container();
					break;
				case UIInfo.ZCHANGE_G9RPTCONTAINER:
					ctrl = new ui.ctrls.ZchangeG9RptContainer();
					break;
				case UIInfo.LINK:
					ctrl = new ui.ctrls.Link();
					break;
				case UIInfo.STROKELINK:
					ctrl = new ui.ctrls.StrokeLink();
					break;
				case UIInfo.BUTTON:
					ctrl = new ui.ctrls.Button();
					break;
				case UIInfo.RADIOBUTTON:
					ctrl = new ui.ctrls.RadioButton();
					break;
				case UIInfo.STATEBUTTON:
					ctrl = new ui.ctrls.StateButton();
					break;
				case UIInfo.TABBUTTON:
					ctrl = new ui.ctrls.TabButton();
					break;
				case UIInfo.TITLE:
					ctrl = new ui.ctrls.Title();
					break;
				case UIInfo.LABEL:
					ctrl = new ui.ctrls.Label();
					break;
				case UIInfo.STROKELABEL:
					ctrl = new ui.ctrls.StrokeLabel();
					break;
				case UIInfo.NORMALINPUT:
					ctrl = new ui.ctrls.NormalInput();
					break;
				case UIInfo.SCROLL_FIELD_RIGHT:
					ctrl = new ui.ctrls.Advanced.ScrollFieldRight();
					break;
				case UIInfo.SCROLL_FIELD_LEFT:
					ctrl = new ui.ctrls.Advanced.ScrollFieldLeft();
					break;
				case UIInfo.SCALE_BUTTON:
					ctrl = new ui.ctrls.Advanced.ScaleButton();
					break;
				case UIInfo.SCALE_STATEBUTTON:
					ctrl = new ui.ctrls.Advanced.ScaleStateButton();
					break;
				case UIInfo.SCALE_RADIOBUTTON:
					ctrl = new ui.ctrls.Advanced.ScaleRadioButton();
					break;
				case UIInfo.SCALE_TABBUTTON:
					ctrl = new ui.ctrls.Advanced.ScaleTabButton();
					break;
				case UIInfo.COMBO_SCALE_BUTTON:
					ctrl = new ui.ctrls.Advanced.ComboScaleButton();
					break;
				case UIInfo.COMBO_SCALE_STATEBUTTON:
					ctrl = new ui.ctrls.Advanced.ComboScaleStateButton();
					break;
				case UIInfo.LIST_BUTTON:
					ctrl = new ui.ctrls.Advanced.ListButton();
					break;
				case UIInfo.SELECT_LIST:
					ctrl = new ui.ctrls.Advanced.SelectList();
					break;
			}
			return ctrl;
		}
		
		
		/**从xml中读取属性，然后加载给UI控件*/
		static private function readAllProp(shell:UIShell, xml:XML, builder:MyUiBuilder):void{
			for(var i:String in builder.uiPropValArr){
				if(shell.ui.uiSubType == builder.uiPropValArr[i][0]){
					for(var j:String in builder.uiPropValArr[i]){
						if(int(j) != 0){
							var prop:String = builder.uiPropNameArr[i][j];
							var val:String = builder.uiPropValArr[i][j];
							shell[prop] = xml["@" + prop];
							//trace("prop:" + prop + "----val:" + val + "----shell[prop]:" + shell[prop] + "-----xml['@' + prop]:" + xml["@" + prop]);
						}
					}
					return;
				}
			}
		}
		
		
		//----------------------------------------------------保存---------------------------------------------------------
		
		/**保存为XML资源文件*/
		static public function save(item:UIShell, path:String):void{
			var srcXML:XML = getXML(item);
			var srcFile:File = new File(path);
			var srcStream:FileStream = new FileStream();
			srcStream.open(srcFile, FileMode.WRITE);
			srcStream.writeUTFBytes(srcXML.toXMLString());
			srcStream.close();
		}
		
		
		/**获取xml*/
		static private function getXML(item:UIShell):XML{
			var children:Array = item.canvas.children;
			var curXML:XML = <node></node>;
			curXML.setName(item.ui.uiSubType);
			
			writeAllProp(item, curXML);
			
			if (children.length > 0){
				for each(var child:UIShell in children){
					var childXML:XML = getXML(child);
					if (childXML != null){
						curXML.appendChild(childXML);
					}
				}
			}
			return curXML;
		}
		
		
		/**将UI控件的属性 写入XML*/
		static private function writeAllProp(item:UIShell, xml:XML):void{
			for(var i:String in builder.uiPropValArr){
				if(item.ui.uiSubType == builder.uiPropValArr[i][0]){
					for(var j:String in builder.uiPropValArr[i]){
						if(int(j) != 0){
							var prop:String = builder.uiPropNameArr[i][j];
							var val:String = builder.uiPropValArr[i][j];
							xml["@" + prop] = item[prop];//trace("prop:" + prop + "----val:" + val + "----item[prop]:" + item[prop]);
						}
					}
					return;
				}
			}
		}
		
		
		
		
	}
}