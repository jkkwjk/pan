package com.jkk.service.impl.User;

import com.jkk.dao.impl.User.RegeditDAOimpl;
import com.jkk.model.User;
import com.jkk.service.impl.Tools.ValcodeImpl;
import com.jkk.service.inter.User.RegeditBiz;
import com.jkk.utils.MDUtil;

import java.util.regex.Pattern;

public class RegeditImpl extends ValcodeImpl implements RegeditBiz{
	RegeditDAOimpl regeditDAO = new RegeditDAOimpl();
	@Override
	public Boolean checkUsernameIsstrong(String userName) {
		String pattern = "^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){3,19}$";
		return Pattern.matches(pattern,userName);
	}

	@Override
	public Boolean checkUsernameIsSame(String userName) {
		return regeditDAO.checkUsernameIsSame(userName);
	}

	@Override
	public Boolean checkPwdIsstrong(String pwd) {
		String pattern = "^.*(?=.{6,16})(?=.*\\d)(?=.*[A-Z]{1,})(?=.*[a-z]{1,}).*$";
		return Pattern.matches(pattern,pwd);
	}

	@Override
	public User addUser(String userName, String pwd) {
		return regeditDAO.addUser(userName, MDUtil.md5two(pwd));
	}
}
