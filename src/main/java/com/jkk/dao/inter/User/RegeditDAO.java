package com.jkk.dao.inter.User;

public interface RegeditDAO {
	Boolean checkUsernameIsSame(String userName);

	Boolean addUser(String userName,String pwd);
}
