package com.jkk.service.inter.User;

import com.jkk.model.UserInfo;

public interface UserInfoBiz {
	UserInfo getInfo();

	boolean updateAll(UserInfo userInfo);

	boolean updateUserName(String val);

	boolean updateSex(String val);

	boolean updateEMail(String val);

	boolean updatePhone(String val);

	boolean updateWebSite(String val);

	boolean updateLocation(String val);

	boolean updateMaxSize(String val);

	boolean updateLastLoginTime(String val);

	boolean updateImg(String val);
}

