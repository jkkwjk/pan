package com.jkk.service.impl.User;

import com.jkk.dao.impl.User.UserInfoDAOimpl;
import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.inter.User.UserInfoBiz;
import com.jkk.utils.MD5Util;
import com.jkk.utils.StampDate;

import java.util.Date;

public class UserInfoImpl implements UserInfoBiz {
	private UserInfoDAOimpl userInfoDAOimpl;
	public UserInfoImpl(User user){
		userInfoDAOimpl = new UserInfoDAOimpl(user.getUserId());
	}
	@Override
	public UserInfo getInfo() {
		UserInfo userInfo = userInfoDAOimpl.getInfo();
		try {
			userInfo.setLastLoginTime(StampDate.stampToDate(userInfo.getLastLoginTime()));
		}catch (Exception e){
			userInfo.setLastLoginTime(StampDate.stampToDate(new Date().getTime()/1000)); //只有在输出化的时候可能会抛出异常
		}finally {
			return userInfo;
		}
	}

	@Override
	public boolean updateAll(UserInfo userInfo) {
		return userInfoDAOimpl.updateAll(userInfo);
	}

	@Override
	public boolean updateUserName(String val) {
		return userInfoDAOimpl.updateUserName(val);
	}

	@Override
	public boolean updateSex(String val) {
		return userInfoDAOimpl.updateSex(val);
	}

	@Override
	public boolean updateEMail(String val) {
		return userInfoDAOimpl.updateEMail(val);
	}

	@Override
	public boolean updatePhone(String val) {
		return userInfoDAOimpl.updatePhone(val);
	}

	@Override
	public boolean updateWebSite(String val) {
		return userInfoDAOimpl.updateWebSite(val);
	}

	@Override
	public boolean updateLocation(String val) {
		return userInfoDAOimpl.updateLocation(val);
	}

	@Override
	public boolean updateMaxSize(String val) {
		return userInfoDAOimpl.updateMaxSize(val);
	}

	@Override
	public boolean updateLastLoginTime(String val) {
		return userInfoDAOimpl.updateLastLoginTime(val);
	}

	@Override
	public boolean updateImg(String val) {
		return userInfoDAOimpl.updateImg(val);
	}

	@Override
	public boolean updateConfimPWD(String val) {
		return userInfoDAOimpl.updateConfimPWD(MD5Util.md5two(val));
	}

	@Override
	public boolean checkConfimPWD(String val) {
		UserInfo userInfo = this.getInfo();
		return userInfo.getConfimPWD().equals(MD5Util.md5two(val));
	}
}
