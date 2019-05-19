package com.jkk.dao.impl.User;

import com.jkk.dao.inter.User.RegeditDAO;
import com.jkk.model.DBInfo;
import com.jkk.model.User;
import com.jkk.utils.DButil;

public class RegeditDAOimpl implements RegeditDAO {
	public DButil dButil = new DButil();
	@Override
	public Boolean checkUsernameIsSame(String userName) {
		return dButil.hasData(String.format("SELECT id FROM `%s` where name= ? LIMIT 1", DBInfo.USER),new String[]{userName});
	}

	@Override
	public User addUser(String userName, String md5Pwd) {
		int id = dButil.addDataGetIncrement(String.format("INSERT into %s(name,password) VALUES (?,?)", DBInfo.USER),new String[]{userName,md5Pwd});
		User user = new User();
		user.setName(userName);
		user.setUserId(id);
		user.setPermissionId(0);

		return user;
	}
}
