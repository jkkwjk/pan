package com.jkk.dao.impl.User;

import com.jkk.dao.inter.User.DelDAO;
import com.jkk.model.DBInfo;
import com.jkk.utils.DButil;

public class DelDAOimpl implements DelDAO {
	private DButil dButil = new DButil();
	@Override
	public boolean delUser(Integer userId) {
		return dButil.exePresqlModifyData(String.format("delete from %s where id=?", DBInfo.USER),new Object[]{userId})==1;
	}
}
