package com.jkk.dao.impl.User;

import com.jkk.dao.inter.User.UserInfoDAO;
import com.jkk.model.DBInfo;
import com.jkk.model.UserInfo;
import com.jkk.utils.DButil;

import java.util.Map;

public class UserInfoDAOimpl implements UserInfoDAO {
	private Integer userId;
	private DButil dButil = new DButil();
	public UserInfoDAOimpl(Integer userId){
		this.userId=userId;
	}
	@Override
	public UserInfo getInfo() {
		Map<String,String> map = dButil.exePresqlGetmap(String.format("SELECT * FROM %s where userid=? limit 1", DBInfo.USER_INFO),new Object[]{userId}).get(0);

		return new UserInfo(Integer.parseInt(map.get("userid")),map.get("username"),map.get("sex"),
				map.get("e_mail"),map.get("phone"),map.get("website"),map.get("location"),map.get("max_filesize"));
	}

	@Override
	public boolean updateAll(UserInfo userInfo) {
		return dButil.exePresqlModifyData(String.format("update %s set username=?,sex=?,e_mail=?,phone=?,website=?,location=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{userInfo.getUserName(),userInfo.getSex(),userInfo.geteMail(),userInfo.getPhone(),
						userInfo.getWebsite(),userInfo.getLocation(),userId})==1;
	}

	@Override
	public boolean updateUserName(String val) {
		return dButil.exePresqlModifyData(String.format("update %s set username=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{val,userId})==1;
	}

	@Override
	public boolean updateSex(String val) {
		return dButil.exePresqlModifyData(String.format("update %s set sex=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{val,userId})==1;
	}

	@Override
	public boolean updateEMail(String val) {
		return dButil.exePresqlModifyData(String.format("update %s set e_mail=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{val,userId})==1;
	}

	@Override
	public boolean updatePhone(String val) {
		return dButil.exePresqlModifyData(String.format("update %s set phone=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{val,userId})==1;
	}

	@Override
	public boolean updateWebSite(String val) {
		return dButil.exePresqlModifyData(String.format("update %s set website=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{val,userId})==1;
	}

	@Override
	public boolean updateLocation(String val) {
		return dButil.exePresqlModifyData(String.format("update %s set location=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{val,userId})==1;
	}

	@Override
	public boolean updateMaxSize(String val) {
		return dButil.exePresqlModifyData(String.format("update %s set max_filesize=? where userid=? limit 1", DBInfo.USER_INFO),
				new Object[]{val,userId})==1;
	}
}
