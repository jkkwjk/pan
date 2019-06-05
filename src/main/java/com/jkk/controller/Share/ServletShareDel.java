package com.jkk.controller.Share;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.Share.ShareFileImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

public class ServletShareDel extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		String url = request.getParameter("url");
		String type = request.getParameter("type");

		JSONObject ret = new JSONObject();
		if (Integer.parseInt(type) == 1){
			ShareFileImpl shareFileimpl = new ShareFileImpl();


			if (shareFileimpl.delShare(url,user.getUserId())){
				ret.put("status",200);
			}else {
				ret.put("status",201);
				ret.put("error_msg","未知错误! 取消失败");
			}
		}

		PrintWriter out = response.getWriter();
		out.print(JSON.toJSONString(ret));
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}
