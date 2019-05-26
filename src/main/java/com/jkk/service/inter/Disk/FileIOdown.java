package com.jkk.service.inter.Disk;

import com.sun.deploy.net.HttpResponse;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface FileIOdown {
	public void downFile(ServletContext context, String folderPath, String nameDisplay, HttpServletResponse response, String MD5) throws IOException;
}
