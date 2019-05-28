package com.jkk.controller.Disk;

import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.Disk.FileWithUserImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ServletFileSearch",urlPatterns = "/file/search")
public class ServletFileSearch extends HttpServlet {
	Map<String,String> FileTypemap = new HashMap<>();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		String name = request.getParameter("name");


	}
}
