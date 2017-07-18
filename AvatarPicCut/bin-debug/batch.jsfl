fl.outputPanel.clear();

var dom = fl.getDocumentDOM();
var lib = dom.library;

//var URI = fl.browseForFolderURL("选择素材文件夹..."); 
var URI = fl.scriptURI.replace("batch.jsfl", "") + "/cut/";

importFolder(URI);


function importFolder(folderURI)
{
    fl.trace(folderURI);
        
    var folderContents;
    var fitem, i;
        
    var libPath = folderURI.replace(URI, "");
    var subLibPath = libPath.substr(1);        //去掉第一个“/”
        
    //文件
    folderContents = FLfile.listFolder(folderURI, "files");
    for (i in folderContents)
	{
		fitem = folderContents[i];
        var inx = fitem.lastIndexOf(".");
        if (inx > 0)
		{
            var ext = fitem.substr(inx+1).toLowerCase();  //扩展名
            //fl.trace(ext);
            if (ext == "jpg" ||ext == "png" || ext == "gif")
			{
                fl.trace("导入文件：" + fitem);
                dom.importFile(folderURI + "/" + fitem, true); 
                if (libPath != "")
				{
                    lib.selectItem(fitem);
                    lib.moveToFolder(subLibPath);
                    }
                }
            }
        }
        
        //文件夹
        folderContents = FLfile.listFolder(folderURI, "directories");
        for (i in folderContents)
		{
                fitem = folderContents[i];
                fl.trace("-----------文件夹：" + fitem + "------------------");
                lib.newFolder(libPath + "/" + fitem);
                
                importFolder(folderURI + "/" + fitem); //递归
        }
        
}

linkClasses();

function linkClasses()
{
	var currentDoc = fl.getDocumentDOM();

	var curlib = currentDoc.library;
                
	var lenLib = curlib.items.length;
	var item;
	for (i=0; i<lenLib; i++)
	{
        item = curlib.items[i];
        if (item.itemType == "bitmap")
		{
            fl.trace(item.name);
                
            item.linkageExportForAS = true;
            item.linkageExportInFirstFrame = true;
            item.linkageBaseClass = "flash.display.BitmapData";
                
            //导出的类名
            var className = item.name;//item.name.substr(0, item.name.lastIndexOf("."));
            className = className.replace("/", ".");
            item.linkageClassName = className;
                
            //item.linkageImportForRS = false;
            //item.linkageIdentifier = item.name;
        }
	}
	fl.trace("-------------------导出项数："+lenLib);
}
