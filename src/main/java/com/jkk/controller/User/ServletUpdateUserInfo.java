package com.jkk.controller.User;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.Disk.FileIOupImpl;
import com.jkk.service.impl.User.UserInfoImpl;
import com.jkk.service.inter.Disk.FileIOup;
import com.jkk.utils.MD5Util;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

@WebServlet(name = "ServletUpdateUserInfo")
public class ServletUpdateUserInfo extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		UserInfoImpl userInfoimpl = new UserInfoImpl(user);
		FileIOupImpl fileUp = new FileIOupImpl((int)(2.5*1024*1024));

		JSONObject ret = new JSONObject();

		try {
			Map<String,Object> map = fileUp.parseRequest(request);
			if (map.get("__file__") != null){
				FileItem item = (FileItem) map.get("__file__");
				String path = request.getServletContext().getRealPath("/static/img/user");

				String fileName = MD5Util.getInputMD5(item.getInputStream());
				fileUp.writeFile(path,item,fileName);
				userInfoimpl.updateImg(fileName);

				map.remove("__file__");
			}

			UserInfo userInfo = new UserInfo((String) map.get("userName"), (String) map.get("sex"),(String) map.get("eMail"),
					(String) map.get("phone"),(String) map.get("website"),(String) map.get("location"));
			if (userInfoimpl.updateAll(userInfo)){
				ret.put("status","1");
			}else {
				ret.put("status","0");
				ret.put("error_msg","服务器繁忙, 请稍后重试");
			}
		} catch (Exception e){
			ret.put("status","0");
			ret.put("error_msg","未知错误 !");
			e.printStackTrace();
		}finally {
			PrintWriter out = response.getWriter();
			out.print(JSON.toJSONString(ret));
		}


	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}
