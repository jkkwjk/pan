package com.jkk.dao.inter.User;

import com.jkk.model.User;

public interface RegeditDAO {
	Boolean checkUsernameIsSame(String userName);

	User addUser(String userName, String Md5pwd);
}
