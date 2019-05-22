package com.jkk.model;

public class File {
	private int fileId;
	private String fileName;
	private Integer folderId; //可以为null
	private String fileTime;
	private Integer rsId;

	public Integer getRsId() {
		return rsId;
	}

	public void setRsId(Integer rsId) {
		this.rsId = rsId;
	}

	public File() {
	}

	public File(int fileId, String fileName, Integer folderId, String fileTime, Integer rsId) {
		this.fileId = fileId;
		this.fileName = fileName;
		this.folderId = folderId;
		this.fileTime = fileTime;
		this.rsId = rsId;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Integer getFolderId() {
		return folderId;
	}

	public void setFolderId(Integer folderId) {
		this.folderId = folderId;
	}

	public String getFileTime() {
		return fileTime;
	}

	public void setFileTime(String fileTime) {
		this.fileTime = fileTime;
	}
}
