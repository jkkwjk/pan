package com.jkk.dao.inter.User;

import com.jkk.model.UserInfo;

public interface UserInfoDAO {
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

	boolean updateConfimPWD(String val);
}
