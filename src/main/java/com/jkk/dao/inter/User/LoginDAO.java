package com.jkk.dao.inter.User;

import com.jkk.model.User;

public interface LoginDAO {
	User login(String username, String md5pwd);

	Boolean checkUserpwd(String username,String md5pwd);

	Boolean updatePwd(String pwd,String userId);
}
