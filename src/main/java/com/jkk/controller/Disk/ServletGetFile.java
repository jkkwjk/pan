package com.jkk.controller.Disk;

import com.alibaba.fastjson.JSONObject;
import com.jkk.model.File;
import com.jkk.model.Folder;
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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ServletGetFile",urlPatterns = "/file/getfile")
public class ServletGetFile extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String start = request.getParameter("start");
		String pFolder = request.getParameter("folder");
		User user = (User) session.getAttribute(AttrToken.USER);

		PrintWriter out = response.getWriter();
		JSONObject objectBase = new JSONObject();
		List<JSONObject> objectData = new ArrayList<>();
		int nowNum = 0;
		//首先先找文件夹
		if (start.equals("0")){
			FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);
			List<Folder> folderList = folderWithUser.getAllFolderInPfolder(Integer.parseInt(pFolder));

			nowNum += folderList.size();
			for (Folder folder : folderList) {
				JSONObject o = new JSONObject();
				o.put("rs_id",folder.getFolderId());
				o.put("file_type","0");
				o.put("file_name",folder.getName());
				o.put("file_size", "-");
				o.put("file_time", StampDate.stampToDate(folder.getTime()));

				o.put("file_ico", "folder");
				objectData.add(o);
			}
		}

		if (30-nowNum<0){
			// 单单文件夹 超出显示限制
			objectBase.put("file_num",nowNum);
			objectBase.put("has_next",'1');
			objectBase.put("data",objectData);
			out.print(JSONObject.toJSONString(objectBase));
			return;
		}
		// 找文件
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		List<File> fileList = fileWithUser.getFileInfo(Integer.parseInt(start),30-nowNum,Integer.parseInt(pFolder));

		objectBase.put("has_next",fileList.size()<30-nowNum? '0':'1');
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

		objectBase.put("file_num",nowNum+fileList.size());
		objectBase.put("data",objectData);
		out.print(JSONObject.toJSONString(objectBase));
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get");

	}
}
