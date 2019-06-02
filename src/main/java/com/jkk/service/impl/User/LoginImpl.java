package com.jkk.service.impl.User;

import com.jkk.dao.impl.User.LoginDAOimpl;
import com.jkk.model.User;
import com.jkk.model.UserInfo;
import com.jkk.service.inter.User.LoginBiz;
import com.jkk.utils.MD5Util;

import java.util.Date;

public class LoginImpl implements LoginBiz {
	LoginDAOimpl loginDAOimpl = new LoginDAOimpl();
	@Override
	public User login(String username, String pwd) {
		User user = loginDAOimpl.login(username, MD5Util.md5two(pwd));

		UserInfoImpl userInfoimpl = new UserInfoImpl(user);
		String dateStamp = String.valueOf(new Date().getTime()/1000);
		userInfoimpl.updateLastLoginTime(dateStamp);

		return user;
	}

	@Override
	public Boolean checkUserpwd(String username, String pwd) {
		return loginDAOimpl.checkUserpwd(username, MD5Util.md5two(pwd));
	}
}
