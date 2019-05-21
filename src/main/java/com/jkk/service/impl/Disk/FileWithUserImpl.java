package com.jkk.service.impl.Disk;

import com.jkk.model.File;
import com.jkk.model.User;
import com.jkk.service.inter.Disk.FileWithUserBiz;

import java.util.List;

public class FileWithUserImpl extends FileBaseImpl implements FileWithUserBiz{
	private String userId;
	public FileWithUserImpl(User user){
		this.userId = String.valueOf(user.getUserId());
	}
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public List<File> getFileInfo(Integer start,Integer limitSize) {
		return null;
	}

	@Override
	public int getAllFileCount() {
		return 0;
	}

	@Override
	public String getAllFileSize() {
		return null;
	}

	@Override
	public List<File> findSameFileByFileId(int fileId) {
		return null;
	}

	@Override
	public List<File> findFileByNamePrecise(String fileName) {
		return null;
	}

	@Override
	public List<File> findFileByNameBlurry(String fileNameLike) {
		return null;
	}

	@Override
	public String findFileTimeByFileId(int folderId,int fileId) {
		return null;
	}

	@Override
	public List<File> findFileByNameInFolder(int folderId, String fileName) {
		return null;
	}
}
