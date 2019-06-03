package com.jkk.controller.User;

import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.AttrToken;
import com.jkk.service.ErrorPath;
import com.jkk.service.impl.User.UserInfoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

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
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute(AttrToken.USER);
			UserInfoImpl userInfoimpl = new UserInfoImpl(user);
			UserInfo userInfo = userInfoimpl.getInfo();
			switch (url){
				case "user/user.jsp":
					request.setAttribute(AttrToken.DATA,userInfo);
					break;
				case "user/changePWD.jsp":
					request.setAttribute(AttrToken.DATA,userInfo);
					if (!(userInfo.getConfimPWD() == null||userInfo.getConfimPWD().equals(""))){
						request.setAttribute(AttrToken.CONFIM,true);
					}
					break;
				case "user/defineCPWD.jsp":
					if (!(userInfo.getConfimPWD()==null || userInfo.getConfimPWD().equals(""))){
						// 非法访问
						response.sendRedirect(request.getContextPath()+ ErrorPath.html500);
						return;
					}
					request.setAttribute(AttrToken.DATA,userInfo);
					break;
			}
			request.getRequestDispatcher("/WEB-INF/"+url).forward(request,response);
		}
	}
}
