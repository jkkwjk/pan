package com.jkk.controller;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.RenderedImage;
import java.io.IOException;
import java.util.Map;

import com.jkk.service.AttrToken;
import com.jkk.service.impl.User.RegeditImpl;


@WebServlet(name = "ServletGetValcode",urlPatterns = "/getcode")
public class ServletGetValcode extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RegeditImpl regedit = new RegeditImpl();
		Map<String,Object> map = regedit.getValcode();

		session.setAttribute(AttrToken.VALCODE,map.get("code").toString());

		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", -1);

		response.setContentType("image/jpeg");

		ServletOutputStream out = response.getOutputStream();
		ImageIO.write((RenderedImage) map.get("img"),"jpeg",out);
		out.close();
	}
}
