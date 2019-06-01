package com.jkk.controller.Disk;

import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.ErrorPath;
import com.jkk.service.impl.Disk.FileIOdownImpl;
import com.jkk.service.impl.Disk.FileWithUserImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
public class ServletDownload extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);

		String rsID = request.getParameter("rsid");
		com.jkk.model.File fileInfo = fileWithUser.getFileInfoByRSID(Integer.parseInt(rsID));
		if (fileInfo != null){
			String fileName = fileInfo.getFileName();
			String fileInSystemPath = fileWithUser.findFilePathByID(fileInfo.getFileId());

			FileIOdownImpl downFile = new FileIOdownImpl();
			downFile.downFile(getServletContext(),fileInSystemPath,fileName,response,
					fileWithUser.getFileMD5ByID(fileInfo.getFileId()));

		}else {
			response.sendRedirect(request.getContextPath()+ ErrorPath.html500);
		}

	}
}
