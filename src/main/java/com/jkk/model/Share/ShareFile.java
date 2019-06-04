package com.jkk.model.Share;

import com.jkk.model.File;

public class ShareFile extends Share {
	private File file;

	public ShareFile(){}
	public ShareFile(String url, String limitTime, String pwd, File file) {
		super(url, limitTime, pwd);
		this.file = file;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}
}
