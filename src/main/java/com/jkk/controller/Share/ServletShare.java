package com.jkk.controller.Share;

import com.jkk.model.Share.ShareFile;
import com.jkk.service.impl.Share.ShareFileImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Calendar;

public class ServletShare extends HttpServlet {
	/**
	 * 分享动作
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		Integer type = Integer.parseInt(request.getParameter("type"));
		if (type == 1){
			// 文件
			ShareFileImpl shareFileimpl = new ShareFileImpl();
			Calendar cal = Calendar.getInstance();
			cal.set(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH)+2);
			shareFileimpl.share(Integer.parseInt(id),String.valueOf(cal.getTimeInMillis()/1000));
		}
	}

	/**
	 * 获取分享的文件
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter("url");
		Integer type = Integer.parseInt(request.getParameter("type"));
		if (type == 1){
			// 文件
			ShareFileImpl shareFileimpl = new ShareFileImpl();
		}
	}
}
