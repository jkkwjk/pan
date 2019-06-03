package com.jkk.controller.User;

import com.alibaba.fastjson.JSON;
import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.User.UserInfoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class ServletGetUserInfo extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		UserInfoImpl userInfoimpl = new UserInfoImpl(user);
		PrintWriter out = response.getWriter();
		UserInfo userInfo = userInfoimpl.getInfo();

		String getWhat = request.getParameter("a");
		switch (getWhat){
			case "name":
				out.print(userInfo.getUserName());
				break;
			case "sex":
				out.print(userInfo.getSex());
				break;
			case "img":
				out.print(userInfo.getImgPath());
				break;
			case "confimpwd":
				if (userInfo.getConfimPWD()==null || userInfo.getConfimPWD().equals("")){
					out.print("user%2FdefineCPWD.jsp");
				}else {
					out.print("user%2FchangePWD.jsp");
				}
				break;
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}
