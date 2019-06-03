package com.jkk.service.inter.User;

import com.jkk.model.User;

public interface LoginBiz {
	User login(String username,String pwd);

	Boolean checkUserpwd(String username,String pwd);

	Boolean updatePwd(String pwd,String userId);
}
