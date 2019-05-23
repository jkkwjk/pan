package com.jkk.controller.Disk;

import com.alibaba.fastjson.JSONObject;
import com.jkk.model.File;
import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.Disk.FileWithUserImpl;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ServletGetFile",urlPatterns = "/file/getfile")
public class ServletGetFile extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String start = request.getParameter("start");
		String folder = request.getParameter("folder");
		PrintWriter out = response.getWriter();
		//首先先找文件夹



		// 找文件
		User user = (User) session.getAttribute(AttrToken.USER);
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		List<File> fileList = fileWithUser.getFileInfo(Integer.parseInt(start),30,Integer.parseInt(folder));

		JSONObject objectBase = new JSONObject();
		objectBase.put("file_num",fileList.size());

		List<JSONObject> objectData = new ArrayList<>();
		for (File file : fileList) {
			JSONObject o = new JSONObject();
			o.put("rs_id",file.getRsId());
			o.put("file_type","1");
			String fileName = file.getFileName();
			o.put("file_name",fileName);
			o.put("file_size", FilesizeUtil.BToOther(fileWithUser.getFileSizeByID(file.getFileId())));
			o.put("file_time", StampDate.stampToDate(file.getFileTime()));

			o.put("file_ico", FileIcoTool.getIco(fileName));
			objectData.add(o);
		}

		objectBase.put("data",objectData);

		out.print(JSONObject.toJSONString(objectBase));
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get");

	}
}
