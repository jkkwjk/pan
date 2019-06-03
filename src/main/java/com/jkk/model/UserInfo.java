package com.jkk.model;

import com.alibaba.fastjson.annotation.JSONField;

public class UserInfo {
	@JSONField(serialize = false)
	private Integer userId;
	private String userName;
	private String sex;
	private String eMail;
	private String phone;
	private String website;
	private String location;
	private String max_filesize;
	private String lastLoginTime;
	private String imgPath;
	private String confimPWD;

	public String getConfimPWD() {
		return confimPWD;
	}

	public void setConfimPWD(String confimPWD) {
		this.confimPWD = confimPWD;
	}

	public String getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public UserInfo(String userName, String sex, String eMail, String phone, String website, String location) {
		this.userName = userName;
		this.sex = sex;
		this.eMail = eMail;
		this.phone = phone;
		this.website = website;
		this.location = location;
	}

	public UserInfo(Integer userId, String userName, String sex, String eMail, String phone, String website, String location, String max_filesize, String lastLoginTime, String imgPath, String confimPWD) {
		this.userId = userId;
		this.userName = userName;
		this.sex = sex;
		this.eMail = eMail;
		this.phone = phone;
		this.website = website;
		this.location = location;
		this.max_filesize = max_filesize;
		this.lastLoginTime = lastLoginTime;
		this.imgPath = imgPath;
		this.confimPWD = confimPWD;
	}

	public UserInfo() {
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String geteMail() {
		return eMail;
	}

	public void seteMail(String eMail) {
		this.eMail = eMail;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getMax_filesize() {
		return max_filesize;
	}

	public void setMax_filesize(String max_filesize) {
		this.max_filesize = max_filesize;
	}
}
