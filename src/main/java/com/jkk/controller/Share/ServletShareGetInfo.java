package com.jkk.controller.Share;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.Share.ShareFile;
import com.jkk.model.User;
import com.jkk.service.AttrToken;
import com.jkk.service.impl.Disk.FileBaseImpl;
import com.jkk.service.impl.Disk.FileIOdownImpl;
import com.jkk.service.impl.Disk.FileWithUserImpl;
import com.jkk.service.impl.Disk.FolderWithUserImpl;
import com.jkk.service.impl.Share.ShareFileImpl;
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
import java.util.Date;
import java.util.List;

public class ServletShareGetInfo extends HttpServlet {
	/**
	 * 得到用户分享的文件
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession();
		User user = (User)session.getAttribute(AttrToken.USER);

		ShareFileImpl shareFileimpl = new ShareFileImpl();
		FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
		FolderWithUserImpl folderWithUser = new FolderWithUserImpl(user);
		List<ShareFile> shareFiles = shareFileimpl.getAllShareByUserId(user.getUserId());

		JSONObject ret = new JSONObject();
		ret.put("file_num",shareFiles.size());
		List<JSONObject> data = new ArrayList<>();

		for (ShareFile shareFile : shareFiles) {
			JSONObject o = new JSONObject();
			o.put("rs_id",shareFile.getFile().getRsId());
			o.put("share_url",shareFile.getUrl());
			o.put("share_time",StampDate.stampToDate(shareFile.getLimitTime()));
			o.put("file_type","1");
			String fileName = shareFile.getFile().getFileName();

			if (Long.valueOf(shareFile.getLimitTime()) < new Date().getTime()/1000){
				// 过期
				o.put("share_guoqi","(已过期)");
			}else {
				o.put("share_guoqi","");
			}

			Integer folder_id = shareFile.getFile().getFolderId();
			if (folder_id==1){
				o.put("file_name",fileName);
			}else {
				o.put("file_name",fileName+"&nbsp;&nbsp;&nbsp;-("+folderWithUser.getFolderName(folder_id)+")");
			}

			o.put("file_size", FilesizeUtil.BToOther(fileWithUser.getFileSizeByID(shareFile.getFile().getFileId())));
			o.put("file_time", StampDate.stampToDate(shareFile.getFile().getFileTime()));

			o.put("file_ico", FileIcoTool.getIco(fileName));
			data.add(o);
		}
		ret.put("data",data);

		PrintWriter out = response.getWriter();
		out.print(JSON.toJSONString(ret));
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}
