package com.jkk.controller.Share;

import com.jkk.model.Share.ShareFile;
import com.jkk.service.impl.Disk.FileBaseImpl;
import com.jkk.service.impl.Disk.FileIOdownImpl;
import com.jkk.service.impl.Share.ShareFileImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
public class ServletShareDown extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * 用户下载文件
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter("url");

		ShareFileImpl shareFileimpl = new ShareFileImpl();
		ShareFile shareFile = shareFileimpl.getShareByurl(url);

		FileIOdownImpl fileIOdown = new FileIOdownImpl();
		FileBaseImpl fileBase = new FileBaseImpl();
		fileIOdown.downFile(request.getServletContext(),
				fileBase.findFilePathByID(shareFile.getFile().getFileId()),
				shareFile.getFile().getFileName(),
				response,
				fileBase.getFileMD5ByID(shareFile.getFile().getFileId()));
	}
}
