package com.jkk.model;

public class Folder {
	private int folderId;
	private String name;
	private String pFloderId;

	public Folder() {
	}

	public Folder(int folderId, String name, String pFloderId) {
		this.folderId = folderId;
		this.name = name;
		this.pFloderId = pFloderId;
	}

	public int getFolderId() {
		return folderId;
	}

	public void setFolderId(int folderId) {
		this.folderId = folderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getpFloderId() {
		return pFloderId;
	}

	public void setpFloderId(String pFloderId) {
		this.pFloderId = pFloderId;
	}
}
