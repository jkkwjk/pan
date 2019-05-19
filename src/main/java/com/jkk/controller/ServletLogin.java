package com.jkk.controller;

import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.User.LoginImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet(name = "ServletLogin",urlPatterns = "/login")
public class ServletLogin extends HttpServlet {
	LoginImpl login = new LoginImpl();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			request.getRequestDispatcher("/WEB-INF/disk.jsp").forward(request,response);
		} else {
			session.setAttribute(AttrToken.ERRORMSG,"用户名或密码错误");
			session.setAttribute(AttrToken.LOGINNAME,name);
			response.sendRedirect("/login.jsp");
		}

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute(AttrToken.USER) == null) {
			response.sendRedirect("/login.jsp");
		}else {
			request.getRequestDispatcher("/WEB-INF/disk.jsp").forward(request,response);
		}
	}
}
