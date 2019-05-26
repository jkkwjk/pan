package com.jkk.controller.Disk;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.Folder;
import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.Disk.FileWithUserImpl;
import com.jkk.service.impl.Disk.FolderWithUserImpl;
import jdk.nashorn.internal.ir.debug.JSONWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet(name = "ServletCommon",urlPatterns = "/file/c")

/**
 *    负责 轻量级的请求 (新建文件夹 文件夹以及文件重命名 文件夹以及文件的删除)
 *    请求格式  r=new/rename/del  t=0/1 1文件0文件夹  val=    now=当前所在folder
 */
public class ServletCommon extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		String r = request.getParameter("r");
		String t = request.getParameter("t");
		String val = request.getParameter("val");
		String now = request.getParameter("now");

		PrintWriter out = response.getWriter();
		switch (r){
			case "new":
			{
				JSONObject ret = new JSONObject();
				FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);
				if (!folderWithUser.hasFolder(val,Integer.parseInt(now))) {
					Folder folder = new Folder(val,String.valueOf(new Date().getTime()/1000),Integer.parseInt(now));
					folderWithUser.addFolder(folder);
					ret.put("status",200);
				} else {
					ret.put("status",201);
					ret.put("msg","文件名不唯一!");
				}
				out.print(JSON.toJSONString(ret));
			}
				break;
			case "rename":
				break;
			case "del":
			{
				FileWithUserImpl fileWithUser = new FileWithUserImpl(user);

				if (t.equals("1")) {
					//文件
					System.out.print("删除文件"+val);
					fileWithUser.deleteFile(Integer.parseInt(val));
				} else {
					//文件夹
					FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);
					folderWithUser.deleteFolder(Integer.parseInt(val));
					fileWithUser.deleteAllFileInFolder(Integer.parseInt(val)); //删除文件夹下所有文件
				}
				break;
			}
		}
	}
}
