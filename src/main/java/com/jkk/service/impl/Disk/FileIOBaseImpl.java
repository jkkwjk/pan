package com.jkk.service.impl.Disk;

import com.jkk.service.inter.Disk.FileIOBase;

import javax.servlet.ServletContext;

public class FileIOBaseImpl implements FileIOBase {
	public String getBasePath(ServletContext context){
		StringBuffer realPath = new StringBuffer(context.getRealPath(""));
		String uploadPath = realPath.substring(0,realPath.lastIndexOf("/"));
		uploadPath = uploadPath.substring(0,uploadPath.lastIndexOf("/")+1)+"pan_upload/";
		// TODO: 2019/6/7 服务器适配 
		return uploadPath;
	}
}
