package com.jkk.controller.User;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.User.DelBizImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class ServletUserDel extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute(AttrToken.USER);
		DelBizImpl delBiz = new DelBizImpl();

		JSONObject ret = new JSONObject();
		if (delBiz.delUser(user.getUserId())){
			ret.put("status",200);
			session.removeAttribute(AttrToken.USER);
		}else {
			ret.put("status",201);
			ret.put("error_msg","未知错误! 请稍后重试");
		}

		PrintWriter out = response.getWriter();
		out.print(JSON.toJSONString(ret));
	}

	/**
	 * 删除user的session
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute(AttrToken.USER);
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
}
