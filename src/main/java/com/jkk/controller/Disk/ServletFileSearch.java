package com.jkk.controller.Disk;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.File;
import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.Disk.FileWithUserImpl;
import com.jkk.service.impl.Disk.FolderWithUserImpl;
import com.jkk.tools.FileIcoTool;
import com.jkk.utils.FilesizeUtil;
import com.jkk.utils.StampDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import java.util.regex.Pattern;

@WebServlet(name = "ServletFileSearch",urlPatterns = "/file/search")
public class ServletFileSearch extends HttpServlet {
	Map<String,String> FileTypemap = new HashMap<>();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 点击按钮进行的查询
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		PrintWriter out = response.getWriter();
		StringBuffer name = new StringBuffer(request.getParameter("name"));

		List<File> fileList = fileWithUser.getAll();
		List<File> obj = new ArrayList<>();
		for (File file : fileList) {
			if (Pattern.compile(".*"+name+".*",Pattern.CASE_INSENSITIVE).matcher(file.getFileName()).find()){
				obj.add(file);
			}
		}
		out.print(fileToJson(obj,user));
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		PrintWriter out = response.getWriter();
		String name = request.getParameter("name");

		List<File> fileList = fileWithUser.getAll();
		List<File> obj = new ArrayList<>();
		for (File file : fileList) {
			if (Pattern.compile(name,Pattern.CASE_INSENSITIVE).matcher(file.getFileName()).find()){
				obj.add(file);
			}
		}
		out.print(fileToJson(obj,user));
	}

	private static String fileToJson(List<File> fileList,User user){
		JSONObject objectBase = new JSONObject();
		List<JSONObject> list = new ArrayList<>();
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);

		if (fileList!=null && fileList.size()>0){
			objectBase.put("file_num",fileList.size());
			for (File file : fileList) {
				JSONObject o = new JSONObject();
				o.put("rs_id",file.getRsId());

				String fileName = file.getFileName();
				Integer folder_id = file.getFolderId();
				if (folder_id==0){
					o.put("file_name",fileName);
				}else {
					o.put("file_name",fileName+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;( "+folderWithUser.getFolderName(folder_id)+" )");
				}
				o.put("file_size", FilesizeUtil.BToOther(fileWithUser.getFileSizeByID(file.getFileId())));
				o.put("file_time", StampDate.stampToDate(file.getFileTime()));
				o.put("file_type","1");

				o.put("file_ico", FileIcoTool.getIco(fileName));
				list.add(o);
			}
			objectBase.put("data",list);
		}else {
			objectBase.put("file_num",'0');
		}

		return JSON.toJSONString(objectBase);
	}
}
