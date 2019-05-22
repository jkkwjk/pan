package com.jkk.tools;

import java.util.HashMap;
import java.util.Map;

public class getFileIco {
	public static String getIco(String fileName){
		Map map = getIcoMap();
		String fileIco = (String) map.get("default");
		int i = fileName.lastIndexOf('.');

		if (i!=-1) {
			String suffix = fileName.substring(i+1,fileName.length()).toLowerCase();
			String Ico_f = (String) map.get(suffix);
			if (Ico_f!=null){
				fileIco = Ico_f;
			}
		}

		return fileIco;
	}

	public static Map<String,String> getIcoMap(){
		Map<String,String> map = new HashMap<>(50);
		map.put("ai","AI");
		map.put("apk","Android");
		map.put("torrent","BT");
		map.put("dwg","CAD");
		map.put("dwt","CAD");

		map.put("c","Code");
		map.put("cpp","Code");
		map.put("java","Code");
		map.put("py","Code");
		map.put("jsp","Code");
		map.put("js","Code");
		map.put("css","Code");
		map.put("asp","Code");
		map.put("php","Code");
		map.put("go","Code");
		map.put("pyc","Code");
		map.put("h","Code");

		map.put("xls","Excel");
		map.put("xlsx","Excel");
		map.put("xlsm","Excel");
		map.put("xml","Excel");
		map.put("xlt","Excel");
		map.put("xltx","Excel");

		map.put("exe","EXE");
		map.put("swf","Flash");
		map.put("fla","Flash");
		map.put("font","Fonts");

		map.put("mp3","Music");
		map.put("wma","Music");
		map.put("ape","Music");
		map.put("flac","Music");
		map.put("aac","Music");
		map.put("m4a","Music");
		map.put("wav","Music");

		map.put("pdf","PDF");
		map.put("ppt","PPT");
		map.put("psd","PS");
		map.put("rar","RAR");
		map.put("txt","Text");

		map.put("mp4","Video");
		map.put("mkv","Video");
		map.put("avi","Video");
		map.put("gif","Video");
		map.put("wmv","Video");
		map.put("mpg","Video");
		map.put("mov","Video");

		map.put("html","Web");
		map.put("htm","Web");

		map.put("doc","Word");
		map.put("docx","Word");
		map.put("zip","ZIP");

		map.put("default","Default");

		return map;
	}

	public static void main(String[] args) {
		System.out.print(getIco("sdfsdf34."));
	}
}
