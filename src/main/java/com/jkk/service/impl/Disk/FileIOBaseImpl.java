package com.jkk.service.impl.Disk;

import com.jkk.service.inter.Disk.FileIOBase;
import com.jkk.utils.PropertiesUtil;

import javax.servlet.ServletContext;

public class FileIOBaseImpl implements FileIOBase {
	public String getBasePath(ServletContext context){
		PropertiesUtil p = new PropertiesUtil("/system.properties");
		return p.getValue("file_save_path");
	}
}
