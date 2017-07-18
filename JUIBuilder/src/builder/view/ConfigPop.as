package builder.view
{
	import builder.BuilderCfg;
	import builder.view.assets.PicEncoder;
	import builder.view.base.CrystalLabel;
	import builder.view.base.Popup;
	import builder.view.config.ConfigShellFrame;
	
	import com.anstu.jui.build.ctrls.base.CShell;
	import com.anstu.jui.controls.JCheckBox;
	import com.anstu.jui.controls.JSlider;
	import com.anstu.jui.define.JuiConst;
	import com.anstu.jui.skin.JCalendarSkin;
	import com.anstu.jui.skin.JCheckBoxSkin;
	import com.anstu.jui.skin.JSliderSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ConfigPop extends Popup
	{
		private static var _instance:ConfigPop;
		public static function get instance():ConfigPop
		{
			if(_instance == null) { _instance = new ConfigPop(); }
			return _instance;
		}
		
		/** 编译品质标签 */
		private var compQuaLabel:CrystalLabel;
		/** 编译品质滑块 */
		private var compQuaSlider:JSlider;
		/** 资源配置是否自动保存 */
		private var assetsAutoSaveOpt:JCheckBox;
		/** 是否允许拖动 */
		private var dragableOpt:JCheckBox;
		
		public function ConfigPop()
		{
			super();
		}
		override protected function addChildren():void
		{
			super.addChildren();
			this.normalBtn.enabled = false;
			this.maximizeBtn.enabled = false;
			this.iconifiedBtn.enabled = false;
			setSize(400, 360);
			setTitle("编辑器配置");
			
			compQuaLabel = new CrystalLabel("资源编译品质：00", 140, 25);
			compQuaLabel.move(30, 50);
			this.addChild(compQuaLabel);
			
			compQuaSlider = new JSlider(JuiConst.HORIZONTAL, __compQualityChange);
			new JSliderSkin().apply(compQuaSlider);
			compQuaSlider.setSliderParams(PicEncoder.MIN_QUALITY, PicEncoder.MAX_QUALITY, PicEncoder.DEFAULT_QUALITY);
			compQuaSlider.width = 180;
			compQuaSlider.move(170, 53);
			this.addChild(compQuaSlider);
			
			updateCompQuality();
			
			var assetsAutoSaveLabel:CrystalLabel = new CrystalLabel("资源配置是否自动保存：", 160, 25);
			assetsAutoSaveLabel.move(30, 80);
			this.addChild(assetsAutoSaveLabel);
			
			assetsAutoSaveOpt = new JCheckBox();
			new JCheckBoxSkin().apply(assetsAutoSaveOpt);
			assetsAutoSaveOpt.move(190, 85);
			this.addChild(assetsAutoSaveOpt);
			assetsAutoSaveOpt.addEventListener(Event.CHANGE, __assetsAutoSaveChange);
			
			ConfigShellFrame.instance.x = 30;
			ConfigShellFrame.instance.y = 120;
			this.addChild(ConfigShellFrame.instance);
			
			var dragableLabel:CrystalLabel = new CrystalLabel("是否允许拖动：", 140, 25);
			dragableLabel.move(30, 320);
			this.addChild(dragableLabel);
			
			dragableOpt = new JCheckBox();
			new JCheckBoxSkin().apply(dragableOpt);
			dragableOpt.move(140, 326);
			this.addChild(dragableOpt);
			dragableOpt.addEventListener(Event.CHANGE, __dragableChange);
			dragableOpt.selected = true;
		}
		
		private function __compQualityChange(e:Event):void
		{
			updateCompQuality();
		}
		
		private function updateCompQuality():void
		{
			var qua:int = int(compQuaSlider.value);
			var label:String = "资源编译品质为：" + qua
			StatusBar.instance.show(label);
			compQuaLabel.text = label
			PicEncoder.instance.changeQuality(qua);
		}
		
		private function __assetsAutoSaveChange(e:Event):void
		{
			BuilderCfg.assetsAutoSave = assetsAutoSaveOpt.selected;
			BuilderCfg.save();
		}
		
		private function __dragableChange(e:Event):void
		{
			CShell.allowDrag = dragableOpt.selected;
		}
	}
}