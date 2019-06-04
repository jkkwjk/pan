package com.jkk.model.Share;

public class Share {
	private String url;
	private String limitTime;
	private String pwd;

	public Share() {
	}

	public Share(String url, String limitTime, String pwd) {
		this.url = url;
		this.limitTime = limitTime;
		this.pwd = pwd;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getLimitTime() {
		return limitTime;
	}

	public void setLimitTime(String limitTime) {
		this.limitTime = limitTime;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
}
