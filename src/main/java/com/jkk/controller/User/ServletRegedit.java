package com.jkk.controller.User;

import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.ErrorPath;
import com.jkk.service.impl.User.RegeditImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet(name = "ServletRegedit",urlPatterns = "/regedit")
public class ServletRegedit extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RegeditImpl regedit = new RegeditImpl();
		Map<String,String[]> map = request.getParameterMap();
		HttpSession session = request.getSession();
		String name = map.get("username")[0];
		String pwd = map.get("pwd")[0];
		String code = map.get("code")[0];

		// 服务端二次验证
		if (!regedit.checkUsernameIsSame(name) && regedit.checkPwdIsstrong(pwd) && code.equals(session.getAttribute(AttrToken.VALCODE))) {
			response.sendRedirect(request.getContextPath()+ErrorPath.html500);
		} else {
			User user = regedit.addUser(name,pwd);
			session.setAttribute(AttrToken.USER,user);
			session.removeAttribute(AttrToken.VALCODE);
			response.sendRedirect(request.getContextPath()+"/login");
		}
	}

	/**
	 * 验证用户名重复 验证码    get参数:  c=xxx&val=???
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RegeditImpl regedit = new RegeditImpl();
		Map<String,String[]> map = request.getParameterMap();
		String checkToken = map.get("c")[0];
		String val = map.get("val")[0];
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		switch (checkToken){
			case "valcode":
				String session_code = (String) session.getAttribute(AttrToken.VALCODE);
				val = val.toUpperCase();
				if (session_code.equals(val)){
					out.print("{\"ret\":\"1\"}");
				} else {
					out.print("{\"ret\":\"0\"}");
				}
				break;
			case "username":
				if (regedit.checkUsernameIsSame(val)) {
					out.print("{\"ret\":\"0\"}");
				} else {
					out.print("{\"ret\":\"1\"}");
				}
				break;
		}
	}
}
