package com.jkk.controller.Disk;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.File;
import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.ErrorPath;
import com.jkk.service.impl.Disk.FileIOupImpl;
import com.jkk.service.impl.Disk.FileWithUserImpl;
import com.jkk.service.impl.Disk.FolderWithUserImpl;
import com.jkk.utils.MD5Util;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Map;

@WebServlet(name = "ServletUpload",urlPatterns = "/file/up")
public class ServletUpload extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		JSONObject retObj = new JSONObject();
		PrintWriter out = response.getWriter();

		FileWithUserImpl fileUser = new FileWithUserImpl(user);
		FileIOupImpl up = new FileIOupImpl();
		FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);

		String systemPath = fileUser.getNextFolder();

		try {
			Map<String,Object> param = up.parseRequest(request);

			FileItem item = (FileItem) param.get("__file__");
			String fileName = new java.io.File(item.getName()).getName();
			String MD5_up = (String) param.get("md5");
			String MD5_confim = MD5Util.getInputMD5(item.getInputStream());
			String fileSize = String.valueOf(item.getSize());
			Integer folderId = Integer.parseInt((String) param.get("folder"));

			if (folderId != 0) {
				if (!folderWithUser.checkFolder(folderId)){
					retObj.put("status","0");
					retObj.put("error_msg","参数错误!");
					out.print(JSON.toJSONString(retObj));
					return;
				}
			}
			// 文件名重复
			if (fileUser.findFileByNameInFolder(folderId,fileName) != null) {
				retObj.put("status","0");
				retObj.put("error_msg","文件重复 !");
				out.print(JSON.toJSONString(retObj));
				return;
			}

			if (MD5_up.toLowerCase().equals(MD5_confim)) {
				Integer fileId = fileUser.getFileIdByMD5(MD5_confim);
				File file = new File(fileId, fileName, folderId,String.valueOf(new Date().getTime()/1000));

				if (file.getFileId()==null){
					up.writeFile(request.getServletContext(),systemPath,item,MD5_confim);
				}

				fileUser.addFile(file,MD5_confim,fileSize,systemPath);

				retObj.put("status","1");
				out.print(JSON.toJSONString(retObj));


			} else {
				// MD5与交提上来的不同
				retObj.put("status","0");
				retObj.put("error_msg","文件可能损坏 请重新上传!");
				out.print(JSON.toJSONString(retObj));
				return;
			}
		} catch (Exception e){
			retObj.put("status","0");
			retObj.put("error_msg","文件大小超过限制");
			out.print(JSON.toJSONString(retObj));
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}
