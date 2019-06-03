package com.jkk.controller.User;

import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.User.LoginImpl;
import com.jkk.service.impl.User.UserInfoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
public class ServletLogin extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginImpl login = new LoginImpl();
		HttpSession session = request.getSession();
		Map<String,String[]> map = request.getParameterMap();
		String name="",pwd;
		if (!map.isEmpty()) {
			session.removeAttribute(AttrToken.USER);

			name = map.get("username")[0];
			pwd = map.get("pwd")[0];

			if (login.checkUserpwd(name,pwd)) {
				//登录成功
				User user = login.login(name,pwd);
				session.setAttribute(AttrToken.USER,user);
			}
		}
		if (session.getAttribute(AttrToken.USER) != null) {
			UserInfo userInfo = (new UserInfoImpl((User) session.getAttribute(AttrToken.USER))).getInfo();
			request.setAttribute(AttrToken.DATA,userInfo);
			request.getRequestDispatcher("/WEB-INF/disk.jsp").forward(request,response);
		} else {
			session.setAttribute(AttrToken.ERROR_MSG,"用户名或密码错误");
			session.setAttribute(AttrToken.LOGIN_NAME,name);
			response.sendRedirect(request.getContextPath()+"/login.jsp");
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute(AttrToken.USER) == null) {
			response.sendRedirect(request.getContextPath()+"/login.jsp");
		}else {
			UserInfo userInfo = (new UserInfoImpl((User) session.getAttribute(AttrToken.USER))).getInfo();
			request.setAttribute(AttrToken.DATA,userInfo);
			request.getRequestDispatcher("/WEB-INF/disk.jsp").forward(request,response);
		}
	}
}
