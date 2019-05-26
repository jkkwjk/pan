package com.jkk.model;

public class Folder {
	private Integer folderId;
	private String name;
	private String time;
	private Integer pFolderId;

	public Folder(String name, String time, Integer pFolderId) {
		this.name = name;
		this.time = time;
		this.pFolderId = pFolderId;
	}

	public Folder(Integer folderId, String name, String time, Integer pFolderId) {
		this.folderId = folderId;
		this.name = name;
		this.time = time;
		this.pFolderId = pFolderId;
	}

	public Integer getFolderId() {
		return folderId;
	}

	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public Integer getpFolderId() {
		return pFolderId;
	}

	public Folder() {
	}

	public void setpFolderId(Integer pFolderId) {
		this.pFolderId = pFolderId;
	}
}
