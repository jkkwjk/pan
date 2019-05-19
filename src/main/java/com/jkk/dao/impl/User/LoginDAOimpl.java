package com.jkk.dao.impl.User;

import com.jkk.dao.inter.User.LoginDAO;
import com.jkk.model.DBInfo;
import com.jkk.model.User;
import com.jkk.utils.DButil;

import java.util.Map;

public class LoginDAOimpl implements LoginDAO {
	DButil dButil = new DButil();
	@Override
	public User login(String username, String md5pwd) {
		Map<String,String> map = dButil.exePresqlGetmap(String.format("SELECT * FROM `%s` where name= ? and password= ? LIMIT 1", DBInfo.USER),new String[]{username,md5pwd}).get(0);
		User user = new User();
		user.setUserId(Integer.parseInt(map.get("id")));
		user.setName(map.get("name"));
		user.setPermissionId(Integer.parseInt(map.get("permission_id")));
		return user;
	}

	@Override
	public Boolean checkUserpwd(String username, String md5pwd) {
		return dButil.hasData(String.format("SELECT id FROM `%s` where name= ? and password= ? LIMIT 1", DBInfo.USER),new String[]{username, md5pwd});
	}
}
