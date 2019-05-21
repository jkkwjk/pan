package com.jkk.service.impl.User;

import com.jkk.dao.impl.User.LoginDAOimpl;
import com.jkk.model.User;
import com.jkk.service.inter.User.LoginBiz;
import com.jkk.utils.MD5Util;

public class LoginImpl implements LoginBiz {
	LoginDAOimpl loginDAOimpl = new LoginDAOimpl();
	@Override
	public User login(String username, String pwd) {
		return loginDAOimpl.login(username, MD5Util.md5two(pwd));
	}

	@Override
	public Boolean checkUserpwd(String username, String pwd) {
		return loginDAOimpl.checkUserpwd(username, MD5Util.md5two(pwd));
	}
}
