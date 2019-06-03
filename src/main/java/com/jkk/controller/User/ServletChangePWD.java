package com.jkk.controller.User;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.User.LoginImpl;
import com.jkk.service.impl.User.RegeditImpl;
import com.jkk.service.impl.User.UserInfoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class ServletChangePWD extends HttpServlet {
	/**
	 * 修改登录密码
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute(AttrToken.USER);
		LoginImpl login = new LoginImpl();
		RegeditImpl regedit = new RegeditImpl();
		JSONObject ret = new JSONObject();

		String old = request.getParameter("old");
		if (login.checkUserpwd(user.getName(),old)){
			// 密码效验正确
			String newPwd = request.getParameter("new");
			if (regedit.checkPwdIsstrong(newPwd)){
				ret.put("status",200);
				login.updatePwd(newPwd,String.valueOf(user.getUserId()));
			}else {
				ret.put("status",201);
				ret.put("error_msg","新密码强度不足");
			}
		}else {
			ret.put("status",201);
			ret.put("error_msg","原密码错误!");
		}
		PrintWriter out = response.getWriter();
		out.print(JSON.toJSONString(ret));
	}

	/**
	 * 修改二次密码
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute(AttrToken.USER);
		UserInfoImpl userInfoimpl = new UserInfoImpl(user);
		RegeditImpl regedit = new RegeditImpl();
		JSONObject ret = new JSONObject();

		String old = request.getParameter("old");
		if (userInfoimpl.checkConfimPWD(old)){
			// 密码效验正确
			String newPwd = request.getParameter("new");
			if (regedit.checkPwdIsstrong(newPwd)){
				ret.put("status",200);
				userInfoimpl.updateConfimPWD(newPwd);
			}else {
				ret.put("status",201);
				ret.put("error_msg","新密码强度不足");
			}
		}else {
			ret.put("status",201);
			ret.put("error_msg","原密码错误!");
		}
		PrintWriter out = response.getWriter();
		out.print(JSON.toJSONString(ret));
	}
}
