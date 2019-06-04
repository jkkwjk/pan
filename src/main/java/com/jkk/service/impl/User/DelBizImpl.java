package com.jkk.service.impl.User;

import com.jkk.dao.impl.User.DelDAOimpl;
import com.jkk.service.inter.User.DelBiz;

public class DelBizImpl implements DelBiz {
	private DelDAOimpl delDAOimpl = new DelDAOimpl();
	@Override
	public boolean delUser(Integer userId) {
		return delDAOimpl.delUser(userId);
	}
}
