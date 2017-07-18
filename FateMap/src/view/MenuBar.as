package view
{
	import controller.MainCtrl;
	import controller.MapPicCtrl;
	
	import flash.desktop.NativeApplication;
	
	import model.WorkConfig;
	
	import org.aswing.ButtonGroup;
	import org.aswing.JCheckBoxMenuItem;
	import org.aswing.JMenu;
	import org.aswing.JMenuBar;
	import org.aswing.JMenuItem;
	import org.aswing.JRadioButtonMenuItem;
	import org.aswing.JSeparator;
	import org.aswing.KeySequence;
	import org.aswing.KeyStroke;
	import org.aswing.event.AWEvent;
	import org.aswing.event.InteractiveEvent;

	public class MenuBar
	{
		private static var _me:MenuBar;
		public static function me():MenuBar
		{
			if(_me == null) { _me = new MenuBar(); }
			return _me;
		}
		
		/** [文件]新建标准地图 */
		private static const MENU_NEW_STD_MAP:String = "MENU_NEW_STD_MAP";
		/** [文件]新建地图全局设置 */
		private static const MENU_NEW_MAP_ENV:String = "MENU_NEW_MAP_ENV";
		/** [文件]打开标准地图 */
		private static const MENU_OPEN_STD_MAP:String = "MENU_OPEN_STD_MAP";
		/** [文件]打开地图全局设置 */
		private static const MENU_OPEN_MAP_ENV:String = "MENU_OPEN_MAP_ENV";
		/** [文件]保存文件 */
		private static const MENU_SAVE:String = "MENU_SAVE";
		/** [文件]导出切片 */
		private static const MENU_EXPORT_SECTION:String = "MENU_EXPORT_SECTION";
		/** [文件]整合切片 */
		private static const MENU_PIECE_SECTION:String = "MENU_PIECE_SECTION";
		/** [文件]关闭文件 */
		private static const MENU_CLOSE:String = "MENU_CLOSE";
		/** [文件]退出程序 */
		private static const MENU_EXIT:String = "MENU_EXIT";
		/** [编辑]剪切 */
		private static const MENU_CUT:String = "MENU_CUT";
		/** [编辑]复制 */
		private static const MENU_COPY:String = "MENU_COPY";
		/** [编辑]粘贴 */
		private static const MENU_PASTE:String = "MENU_PASTE";
		/** [选项]导航视图选项 */
		private static const MENU_NAVI_VIEW:String = "MENU_NAVI_VIEW";
		/** [选项]中文语言选项 */
		private static const MENU_LANG_ZH:String = "MENU_LANG_ZH";
		/** [选项]英文语言选项 */
		private static const MENU_LANG_EN:String = "MENU_LANG_EN";
		/** [视图]网格可见 */
		private static const MENU_VIEW_NET:String = "MENU_VIEW_NET";
		/** [视图]底色可见 */
		private static const MENU_VIEW_BG:String = "MENU_VIEW_BG";
		/** [视图]坐标可见 */
		private static const MENU_VIEW_POINT:String = "MENU_VIEW_POINT";
		/** [视图]阻碍点可见 */
		private static const MENU_VIEW_BLOCK:String = "MENU_VIEW_BLOCK";
		/** [视图]遮罩点可见 */
		private static const MENU_VIEW_MASK:String = "MENU_VIEW_MASK";
		/** [视图]摆摊点可见 */
		private static const MENU_VIEW_STALL:String = "MENU_VIEW_STALL";
		/** [视图]传送点可见 */
		private static const MENU_VIEW_DELIVER:String = "MENU_VIEW_DELIVER";
		/** [视图]数字标识可见 */
		private static const MENU_VIEW_NUM_TAG:String = "MENU_VIEW_NUM_TAG";
		/** [插件]解压ws */
		private static const MENU_UNZIP_WS:String = "MENU_UNZIP_WS";
		/** [帮助]帮助文档 */
		private static const MENU_HELP_DOC:String = "MENU_HELP_DOC";
		/** [帮助]关于... */
		private static const MENU_HELP_ABOUT:String = "MENU_HELP_ABOUT";
		
		private var root:JMenuBar;
		public function getRootPane():JMenuBar { return root; }
		
		private var netView:JCheckBoxMenuItem;
		private var bgView:JCheckBoxMenuItem;
		private var pointView:JCheckBoxMenuItem;
		private var blockView:JCheckBoxMenuItem;
		private var maskView:JCheckBoxMenuItem;
		private var stallView:JCheckBoxMenuItem;
		private var deliverView:JCheckBoxMenuItem;
		private var numTagView:JCheckBoxMenuItem;
		
		private var performanceHigh:JRadioButtonMenuItem;
		private var performanceLow:JRadioButtonMenuItem;
		
		public function MenuBar()
		{
			root = new JMenuBar();
			var item:JMenuItem = null;
			//文件菜单
			var fileMenu:JMenu = new JMenu("文件");
			
			var newMenu:JMenu = new JMenu("新建");
			item = new JMenuItem("标准地图");
			item.name = MENU_NEW_STD_MAP;
			item.addActionListener(__menuItemAct);
			newMenu.append(item);
			item = new JMenuItem("地图全局设置");
			item.name = MENU_NEW_MAP_ENV;
			item.addActionListener(__menuItemAct);
			newMenu.append(item);
			fileMenu.append(newMenu);
			
			var openMenu:JMenu = new JMenu("打开");
			item = new JMenuItem("标准地图");
			item.name = MENU_OPEN_STD_MAP;
			item.addActionListener(__menuItemAct);
			openMenu.append(item);
			item = new JMenuItem("地图全局设置");
			item.name = MENU_OPEN_MAP_ENV;
			item.addActionListener(__menuItemAct);
			openMenu.append(item);
			fileMenu.append(openMenu);
			
			item = new JMenuItem("保存文件");
			item.name = MENU_SAVE;
			item.addActionListener(__menuItemAct);
			fileMenu.append(item);
			
			item = new JMenuItem("导出切片");
			item.name = MENU_EXPORT_SECTION;
			item.addActionListener(__menuItemAct);
			fileMenu.append(item);
			
			item = new JMenuItem("整合切片");
			item.name = MENU_PIECE_SECTION;
			item.addActionListener(__menuItemAct);
			fileMenu.append(item);
			
			item = new JMenuItem("关闭文件");
			item.name = MENU_CLOSE;
			item.addActionListener(__menuItemAct);
			fileMenu.append(item);
			
			item = new JMenuItem("退出程序");
			item.name = MENU_EXIT;
			item.addActionListener(__menuItemAct);
			fileMenu.append(item);
			
			//编辑菜单
			var editMenu:JMenu = new JMenu("编辑");
			item = new JMenuItem("剪切");
			item.name = MENU_CUT;
			item.addActionListener(__menuItemAct);
			editMenu.append(item);
			
			item = new JMenuItem("复制");
			item.name = MENU_COPY;
			item.addActionListener(__menuItemAct);
			editMenu.append(item);
			
			item = new JMenuItem("粘贴");
			item.name = MENU_PASTE;
			item.addActionListener(__menuItemAct);
			editMenu.append(item);
			
			//选项菜单
			var optionMenu:JMenu = new JMenu("选项");
			var naviView:JCheckBoxMenuItem = new JCheckBoxMenuItem("导航视图");
			naviView.name = MENU_NAVI_VIEW;
			naviView.addSelectionListener(__menuSelection);
			naviView.setAccelerator(new KeySequence(KeyStroke.VK_CONTROL, KeyStroke.VK_N));
			optionMenu.append(naviView);
			
			optionMenu.append(new JSeparator(JSeparator.HORIZONTAL));
			
			var languageMenu:JMenu = new JMenu("语言");
			var langZh:JRadioButtonMenuItem = new JRadioButtonMenuItem("简体中文");
			langZh.name = MENU_LANG_ZH;
			langZh.addSelectionListener(__menuSelection);
			var langEn:JRadioButtonMenuItem = new JRadioButtonMenuItem("English");
			langEn.name = MENU_LANG_EN;
			langEn.addSelectionListener(__menuSelection);
			var langGroup:ButtonGroup = new ButtonGroup();
			langGroup.append(langZh);
			langGroup.append(langEn);
			languageMenu.append(langZh);
			languageMenu.append(langEn);
			optionMenu.append(languageMenu);
			
			var performanceMenu:JMenu = new JMenu("性能");
			performanceHigh = new JRadioButtonMenuItem("高级");
			performanceHigh.addSelectionListener(__menuSelection);
			performanceLow = new JRadioButtonMenuItem("低级");
			performanceLow.getModel().setSelected(true);//默认
			performanceLow.addSelectionListener(__menuSelection);
			var performanceGroup:ButtonGroup = new ButtonGroup();
			performanceGroup.append(performanceHigh);
			performanceGroup.append(performanceLow);
			performanceMenu.append(performanceHigh);
			performanceMenu.append(performanceLow);
			optionMenu.append(performanceMenu);
			
			//视图菜单
			var viewMenu:JMenu = new JMenu("视图");
			netView = new JCheckBoxMenuItem("网格可见");
			netView.getModel().setSelected(WorkConfig.me().VIEW_NET);
			netView.name = MENU_VIEW_NET;
			netView.addSelectionListener(__menuSelection);
			viewMenu.append(netView);
			
			bgView = new JCheckBoxMenuItem("底色可见");
			bgView.getModel().setSelected(WorkConfig.me().VIEW_BG);
			bgView.name = MENU_VIEW_BG;
			bgView.addSelectionListener(__menuSelection);
			viewMenu.append(bgView);
			
			pointView = new JCheckBoxMenuItem("坐标可见");
			pointView.getModel().setSelected(WorkConfig.me().VIEW_POINT);
			pointView.name = MENU_VIEW_POINT;
			pointView.addSelectionListener(__menuSelection);
			viewMenu.append(pointView);
			
			blockView = new JCheckBoxMenuItem("阻碍点可见");
			blockView.getModel().setSelected(WorkConfig.me().VIEW_BLOCK);
			blockView.name = MENU_VIEW_BLOCK;
			blockView.addSelectionListener(__menuSelection);
			viewMenu.append(blockView);
			
			maskView = new JCheckBoxMenuItem("遮罩点可见");
			maskView.getModel().setSelected(WorkConfig.me().VIEW_MASK);
			maskView.name = MENU_VIEW_MASK;
			maskView.addSelectionListener(__menuSelection);
			viewMenu.append(maskView);
			
			stallView = new JCheckBoxMenuItem("摆摊点可见");
			stallView.getModel().setSelected(WorkConfig.me().VIEW_STALL);
			stallView.name = MENU_VIEW_STALL;
			stallView.addSelectionListener(__menuSelection);
			viewMenu.append(stallView);
			
			deliverView = new JCheckBoxMenuItem("传送点可见");
			deliverView.getModel().setSelected(WorkConfig.me().VIEW_DELIVER);
			deliverView.name = MENU_VIEW_DELIVER;
			deliverView.addSelectionListener(__menuSelection);
			viewMenu.append(deliverView);
			
			numTagView = new JCheckBoxMenuItem("数字标识可见");
			numTagView.getModel().setSelected(WorkConfig.me().VIEW_NUM_TAG);
			numTagView.name = MENU_VIEW_NUM_TAG;
			numTagView.addSelectionListener(__menuSelection);
			viewMenu.append(numTagView);
			
			//插件菜单
			var pluginMenu:JMenu = new JMenu("插件");
			item = new JMenuItem("解压ws");
			item.name = MENU_UNZIP_WS;
			item.addActionListener(__menuItemAct);
			pluginMenu.append(item);
			
			//帮助菜单
			var helpMenu:JMenu = new JMenu("帮助");
			item = new JMenuItem("帮助文档");
			item.name = MENU_HELP_DOC;
			item.addActionListener(__menuItemAct);
			helpMenu.append(item);
			
			item = new JMenuItem("关于...");
			item.name = MENU_HELP_ABOUT;
			item.addActionListener(__menuItemAct);
			helpMenu.append(item);
			
			root.append(fileMenu);
			root.append(editMenu);
			root.append(optionMenu);
			root.append(viewMenu);
			root.append(pluginMenu);
			root.append(helpMenu);
			//
			setViewConfig();
		}
		
		private function __menuItemAct(event:AWEvent):void
		{
			var source:JMenuItem = event.target as JMenuItem;
			//trace("__menuItemAct", source.getText());
			switch(source.name)
			{
				case MENU_NEW_STD_MAP:
					trace("新建标准地图");
					CreateStdMapWnd.me().open();
					break;
				case MENU_NEW_MAP_ENV:
					trace("新建地图全局设置");
					break;
				case MENU_OPEN_STD_MAP:
					trace("打开标准地图");
					OpenStdMapWnd.me().open();
					break;
				case MENU_OPEN_MAP_ENV:
					trace("打开地图全局设置");
					break;
				case MENU_SAVE:
					trace("保存文件");
					MainCtrl.me().saveWorkSpace();
					MainCtrl.me().saveMapConfig();
					break;
				case MENU_EXPORT_SECTION:
					trace("导出切片");
					ExportSectionWnd.me().open();
					break;
				case MENU_PIECE_SECTION:
					trace("整合切片");
					PieceSectionWnd.me().open();
					break;
				case MENU_CLOSE:
					trace("关闭文件");
					MainCtrl.me().clearWorkSpace();
					break;
				case MENU_EXIT:
					trace("退出程序");
					NativeApplication.nativeApplication.activeWindow.close();
					break;
				case MENU_CUT:
					trace("剪切");
					break;
				case MENU_COPY:
					trace("复制");
					break;
				case MENU_PASTE:
					trace("粘贴");
					break;
				case MENU_UNZIP_WS:
					trace("解压ws");
					UnzipWsWnd.me().open();
					break;
				case MENU_HELP_DOC:
					trace("帮助文档");
					AlertWnd.me().show("详见程序根目录下 帮助.txt，如果没找到该文件，\r\n请直接联系我，QQ：278884301");
					break;
				case MENU_HELP_ABOUT:
					trace("关于...");
					AlertWnd.me().show("COPYLEFT 2013-3102");
					break;
				default:
					trace("__menuItemAct:默认");
					break;
			}
		}
		
		private function __menuSelection(event:InteractiveEvent):void
		{
			WorkConfig.me().HIGH_PERFORM = performanceHigh.getModel().isSelected();
			//
			var source:JMenuItem = event.target as JMenuItem;
			//trace("__menuSelection", source.getText(), source.isSelected());
			switch(source.name)
			{
				case MENU_NAVI_VIEW:
					trace("导航视图选项");
					break;
				case MENU_LANG_ZH:
					trace("中文语言选项");
					break;
				case MENU_LANG_EN:
					trace("英文语言选项");
					break;
				case MENU_VIEW_NET:
				case MENU_VIEW_BG:
				case MENU_VIEW_POINT:
				case MENU_VIEW_BLOCK:
				case MENU_VIEW_MASK:
				case MENU_VIEW_STALL:
				case MENU_VIEW_DELIVER:
				case MENU_VIEW_NUM_TAG:
					setViewConfig();
					break;
				default:
					trace("__menuSelection:默认");
					break;
			}
		}
		
		/** 设置视图配置 */
		private function setViewConfig():void
		{
			WorkConfig.me().VIEW_NET = netView.getModel().isSelected();
			WorkConfig.me().VIEW_BG = bgView.getModel().isSelected();
			WorkConfig.me().VIEW_POINT = pointView.getModel().isSelected();
			WorkConfig.me().VIEW_BLOCK = blockView.getModel().isSelected();
			WorkConfig.me().VIEW_MASK = maskView.getModel().isSelected();
			WorkConfig.me().VIEW_STALL = stallView.getModel().isSelected();
			WorkConfig.me().VIEW_DELIVER = deliverView.getModel().isSelected();
			WorkConfig.me().VIEW_NUM_TAG = numTagView.getModel().isSelected();
			trace(WorkConfig.me());
			CanvasPanel.me().paint();
			if(WorkConfig.me().VIEW_POINT)
			{
				PointTip.me().show();
			}
			else
			{
				PointTip.me().hide();
			}
		}
		
	}
}