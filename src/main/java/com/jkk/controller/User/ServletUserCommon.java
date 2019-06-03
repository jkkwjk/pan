package com.jkk.controller.User;

import com.jkk.model.User;
import com.jkk.service.AttrToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
public class ServletUserCommon extends HttpServlet {
	/**
	 * 用于获得跳转的链接
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute(AttrToken.USER);

	}

	/**
	 * 用于控制链接的跳转
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter(AttrToken.URL);
		if (url.contains("user")){
			request.getRequestDispatcher("/WEB-INF/"+url).forward(request,response);
		}
	}
}
