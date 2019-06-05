package com.jkk.controller.Share;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jkk.model.Share.ShareFile;
import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.AttrToken;
import com.jkk.service.ErrorPath;
import com.jkk.service.impl.Disk.FileBaseImpl;
import com.jkk.service.impl.Disk.FileWithUserImpl;
import com.jkk.service.impl.Share.ShareFileImpl;
import com.jkk.service.impl.User.UserInfoImpl;
import com.jkk.utils.StampDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;

public class ServletShare extends HttpServlet {
	/**
	 * 分享动作
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		Integer type = Integer.parseInt(request.getParameter("type"));
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute(AttrToken.USER);
		JSONObject ret = new JSONObject();
		PrintWriter out = response.getWriter();
		if (type == 1){
			// 文件
			FileWithUserImpl fileWithUser = new FileWithUserImpl(user);
			if (fileWithUser.getFileInfoByRSID(Integer.parseInt(id)) != null){
				ShareFileImpl shareFileimpl = new ShareFileImpl();
				Calendar cal = Calendar.getInstance();
				cal.set(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DAY_OF_MONTH)+15);
				String url = shareFileimpl.hasShareByRsid(Integer.parseInt(id),user.getUserId());
				if (url!=null){
					// 存在分享文件
					shareFileimpl.updateLimitTime(url,String.valueOf(cal.getTimeInMillis()/1000));
					ret.put("status",202);
					ret.put("url",url);
				}else {
					url = shareFileimpl.share(Integer.parseInt(id),String.valueOf(cal.getTimeInMillis()/1000));
					if (url != null){
						ret.put("status",200);
						ret.put("url",url);
					}else {
						ret.put("status",201);
						ret.put("error_msg","分享失败");
					}
				}

			}else {
				response.sendRedirect(request.getContextPath()+ ErrorPath.html500);
			}

		}

		out.print(JSON.toJSONString(ret));
	}

	/**
	 * 获取分享的文件
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getParameter("url");
		Integer type = Integer.parseInt(request.getParameter("type"));
		JSONObject retError = new JSONObject();
		if (type == 1){
			// 文件
			ShareFileImpl shareFileimpl = new ShareFileImpl();
			ShareFile shareFile = shareFileimpl.getShareByurl(url);
			if (shareFile!=null){
				if (Long.valueOf(shareFile.getLimitTime()) > new Date().getTime()/1000){
					// 可以访问

					// 自己的信息
					HttpSession session = request.getSession();
					User user = (User) session.getAttribute(AttrToken.USER);
					if (user != null){
						UserInfoImpl userInfoimpl = new UserInfoImpl(user);
						request.setAttribute(AttrToken.DATA,userInfoimpl.getInfo());
					}

					// 分享文件信息
					FileBaseImpl fileBase = new FileBaseImpl();
					request.setAttribute(AttrToken.SHARE_FILE,shareFile);
					request.setAttribute(AttrToken.NOW_TIME, new Date().getTime()/1000);
					request.setAttribute(AttrToken.FILE_SIZE, fileBase.getFileSizeByID(shareFile.getFile().getFileId()));
					// 分享者信息
					User shareUser = shareFileimpl.getShareUser(url);
					UserInfoImpl shareUserInfoimpl = new UserInfoImpl(shareUser);
					request.setAttribute(AttrToken.SHARE_USER_DATA,shareUserInfoimpl.getInfo());
					request.setAttribute(AttrToken.SHARE_USER,shareUser);
					request.getRequestDispatcher("/WEB-INF/share/shareFile.jsp").forward(request,response);
				}else {
					retError.put("status",202);
					retError.put("error_msg","分享文件已过期");
				}
			}else {
				retError.put("status",201);
				retError.put("error_msg","分享文件不存在");
			}
		}


		PrintWriter out = response.getWriter();
		out.print(JSONObject.toJSONString(retError));
	}
}
