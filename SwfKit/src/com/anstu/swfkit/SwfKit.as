package com.anstu.swfkit
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFFrameLabel;
	import com.codeazur.as3swf.data.SWFScene;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.data.consts.BitmapType;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG2;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG3;
	import com.codeazur.as3swf.tags.TagDefineSceneAndFrameLabelData;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	import com.codeazur.as3swf.tags.TagMetadata;
	import com.codeazur.as3swf.tags.TagSetBackgroundColor;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import org.as3commons.bytecode.abc.AbcFile;
	import org.as3commons.bytecode.abc.enum.Opcode;
	import org.as3commons.bytecode.emit.IClassBuilder;
	import org.as3commons.bytecode.emit.ICtorBuilder;
	import org.as3commons.bytecode.emit.IPackageBuilder;
	import org.as3commons.bytecode.emit.impl.AbcBuilder;
	import org.as3commons.bytecode.io.AbcSerializer;

	public class SwfKit
	{
		private static const BMD_CLASS:String = "flash.display.BitmapData";
		
		private var swf:SWF;
		private var abcBuilder:AbcBuilder;
		private var symbolClass:TagSymbolClass;
		private var currentCharacterId:int;
		
		public function SwfKit()
		{
			swf = new SWF();
			
			swf.frameRate = 24;
			
			swf.tags.push( new TagFileAttributes() );
			
			swf.tags.push(new TagMetadata());
			
			swf.tags.push(new TagSetBackgroundColor());
			
			var sfld:TagDefineSceneAndFrameLabelData = new TagDefineSceneAndFrameLabelData();
			var sce:SWFScene = new SWFScene(0, "我的场景");
			sfld.scenes.push(sce);
			swf.tags.push(sfld);
			
			abcBuilder = new AbcBuilder();
			symbolClass = new TagSymbolClass();
			currentCharacterId = 1;
		}
		
		public function addPicRGB(definition:String, bmd24:BitmapData, quality:int=90):void
		{
			const imgWidth:int = bmd24.width;
			const imgHeight:int = bmd24.height;
			
			var def:ClassDef = new ClassDef(definition);
			trace("packageName=" + def.packageName + " className=" + def.className);
			
			var packageBuilder:IPackageBuilder = abcBuilder.definePackage(def.packageName);
			var classBuilder:IClassBuilder = packageBuilder.defineClass(def.className, BMD_CLASS);
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
			
			symbolClass.symbols.push(SWFSymbol.create(currentCharacterId, def.packageName + "." + def.className));
			
			var defineBitsJPEG2:TagDefineBitsJPEG2 = new TagDefineBitsJPEG2();
			defineBitsJPEG2.characterId = currentCharacterId;
			defineBitsJPEG2.bitmapType = BitmapType.JPEG;
			var encoder:JPGEncoder = new JPGEncoder(quality);
			var bmdBytes:ByteArray = encoder.encode(bmd24);
			defineBitsJPEG2.bitmapData.writeBytes( bmdBytes );
			swf.tags.push(defineBitsJPEG2);
			
			currentCharacterId++;
		}
		
		public function addPicARGB(definition:String, bmd32:BitmapData, quality:int=90):void
		{
			const imgWidth:int = bmd32.width;
			const imgHeight:int = bmd32.height;
			
			var def:ClassDef = new ClassDef(definition);
			trace("packageName=" + def.packageName + " className=" + def.className);
			
			var packageBuilder:IPackageBuilder = abcBuilder.definePackage(def.packageName);
			var classBuilder:IClassBuilder = packageBuilder.defineClass(def.className, BMD_CLASS);
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
			
			symbolClass.symbols.push(SWFSymbol.create(currentCharacterId, def.packageName + "." + def.className));
			
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
			defineBitsJPEG3.bitmapType = BitmapType.JPEG;
			defineBitsJPEG3.bitmapAlphaData.writeBytes( alphaBytes );
			var encoder:JPGEncoder = new JPGEncoder(quality);
			var bmdBytes:ByteArray = encoder.encode(rgbBmd);
			//var bmdBytes:ByteArray = encoder.encode(bmd32);
			//rgbBmd.
			
			defineBitsJPEG3.bitmapData.writeBytes( bmdBytes );
			swf.tags.push(defineBitsJPEG3);
			
			currentCharacterId++;
		}
		
		/** 获得SWFData(extends ByteArray) */
		public function exportSwf():SWFData
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
			
			return swfData;
		}
		
	}
}

class ClassDef
{
	public var definition:String;
	public var packageName:String;
	public var className:String;
	
	public function ClassDef(definition:String)
	{
		parse(definition);
	}
	
	public function parse(definition:String):void
	{
		this.definition = definition;
		var defArr:Array = definition.split(".");
		if(defArr.length <= 0) { return; }
		className = defArr[defArr.length-1];
		packageName = "";
		for(var i:int = 0; i < defArr.length-1; i++)
		{
			packageName += defArr[i];
			if(i == defArr.length-2)
			{
				//
			}
			else
			{
				packageName += ".";
			}
		}
	}
}