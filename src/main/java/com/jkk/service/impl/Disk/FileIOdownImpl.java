package com.jkk.service.impl.Disk;

import com.jkk.service.inter.Disk.FileIOdown;
import com.sun.deploy.net.HttpResponse;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

public class FileIOdownImpl extends FileIOBaseImpl implements FileIOdown{
	@Override
	public void downFile(ServletContext context, String folderPath, String nameDisplay, HttpServletResponse response, String MD5) throws IOException {

		String nameDisplayEncode  = new String(nameDisplay.getBytes("GB2312"),"ISO-8859-1");

		response.setContentType("application/octet-stream");
		response.addHeader("Content-Disposition", "attachment;filename="+nameDisplayEncode);

		OutputStream os = response.getOutputStream();
		FileInputStream fis = new FileInputStream(super.getBasePath(context)+ folderPath +
				File.separator + MD5);
		try{
			byte[] b =new byte[1024];
			int m=0;
			while ((m=fis.read(b))>0){
				os.write(b,0,m);
			}
			fis.close(); os.flush(); os.close();
		}catch (Exception e){
			fis.close(); os.flush(); os.close();
		}
	}
}
