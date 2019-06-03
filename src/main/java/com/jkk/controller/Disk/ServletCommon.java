package com.jkk.controller.Disk;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.Folder;
import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.AttrToken;
import com.jkk.service.ErrorPath;
import com.jkk.service.impl.Disk.FileWithUserImpl;
import com.jkk.service.impl.Disk.FolderWithUserImpl;
import com.jkk.service.impl.User.UserInfoImpl;
import com.jkk.utils.FilesizeUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;

public class ServletCommon extends HttpServlet {
	/**
	 *  负责 获得总容量和用户使用容量
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		PrintWriter out = response.getWriter();
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		UserInfoImpl userInfoImpl = new UserInfoImpl(user);

		JSONObject ret = new JSONObject();
		UserInfo userInfo = userInfoImpl.getInfo();

		String max = userInfo.getMax_filesize();
		ret.put("max", FilesizeUtil.BToOther(max));

		String used = fileWithUser.getAllFileSize();
		ret.put("used", FilesizeUtil.BToOther(used));

		String scale_tmp = (new BigDecimal(used)).divide(new BigDecimal(max)).toString();
		Integer scale;
		int pos = scale_tmp.indexOf('.');
		if (pos!=-1){
			scale = Integer.parseInt(scale_tmp.substring(0,pos))*100;
		} else {
			scale = Integer.parseInt(scale_tmp)*100;
		}
		ret.put("scale", scale);

		out.print(JSON.toJSONString(ret));
	}

	/**
	 *    负责 轻量级的请求 (新建文件夹 文件夹以及文件重命名 文件夹以及文件的删除)
	 *    请求格式  r=new/rename/del  t=0/1 1文件0文件夹  val=    now=当前所在folder
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		String r = request.getParameter("r");
		String t = request.getParameter("t");
		String[] val = request.getParameterValues("val");
		String now = request.getParameter("now");

		PrintWriter out = response.getWriter();
		switch (r){
			case "new":
			{
				FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);
				if (val==null||val[0].equals("")|| (!now.equals("0") && !folderWithUser.checkFolder(Integer.parseInt(now)))){
					response.sendRedirect(request.getContextPath()+ ErrorPath.html500);
					return;
				}
				JSONObject ret = new JSONObject();

				if (!folderWithUser.hasFolder(val[0],Integer.parseInt(now))) {
					Folder folder = new Folder(val[0],String.valueOf(new Date().getTime()/1000),Integer.parseInt(now));
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
			{
				if (val==null||val[0].equals("")||val[1].equals("")){
					response.sendRedirect(request.getContextPath()+ ErrorPath.html500);
					return;
				}
				JSONObject ret = new JSONObject();
				if (t.equals("1")) {
					FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
					// 文件名称重复检测
					if (fileWithUser.findFileByNameInFolder(Integer.parseInt(now),val[0])==null){
						if (fileWithUser.renameFile(Integer.parseInt(val[0]),val[1])!=1){
							ret.put("status",201);
							ret.put("msg","你TM别乱改我网页!!");
						}else {
							ret.put("status",200);
						}
					}else {
						ret.put("status",201);
						ret.put("msg","文件名重复!");
					}
				}else {
					FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);
					if (folderWithUser.checkFolder(Integer.parseInt(val[0]))){
						folderWithUser.renameFolder(Integer.parseInt(val[0]),val[1]);
						ret.put("status",200);
					}else {
						ret.put("status",201);
						ret.put("msg","重命名失败!");
					}
				}
				out.println(JSON.toJSONString(ret));
				break;
			}

			case "del":
			{
				FileWithUserImpl fileWithUser = new FileWithUserImpl(user);

				if (t.equals("1")) {
					//文件
					fileWithUser.deleteFile(Integer.parseInt(val[0]));
				} else {
					//文件夹
					FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);
					folderWithUser.deleteFolder(Integer.parseInt(val[0]));
				}
				break;
			}
		}
	}
}
