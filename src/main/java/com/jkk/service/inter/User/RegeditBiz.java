package com.jkk.service.inter.User;

import com.jkk.model.User;
import com.jkk.service.inter.Tools.ValcodeBiz;

import java.util.Map;

public interface RegeditBiz extends ValcodeBiz {
	Boolean checkUsernameIsstrong(String userName);

	Boolean checkUsernameIsSame(String userName);

	Boolean checkPwdIsstrong(String pwd);

	User addUser(String userName, String pwd);
}
