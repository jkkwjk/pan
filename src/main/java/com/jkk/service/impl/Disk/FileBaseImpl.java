package com.jkk.service.impl.Disk;

import com.jkk.dao.impl.Disk.FileBaseDAOimpl;
import com.jkk.service.inter.Disk.FileBaseBiz;

public class FileBaseImpl implements FileBaseBiz {
	FileBaseDAOimpl file = new FileBaseDAOimpl();
	@Override
	public Integer getFileIdByMD5(String MD5) {
		return file.getFileIdByMD5(MD5);
	}

	@Override
	public String getFileMD5ByID(int id) {
		return file.getFileMD5ByID(id);
	}

	@Override
	public Boolean existFile(String MD5) {
		return file.existFile(MD5);
	}

	@Override
	public String getFileSizeByID(int id) {
		return file.getFileSizeByID(id);
	}

	@Override
	public String getFileSizeByMD5(String MD5) {
		return file.getFileSizeByMD5(MD5);
	}

	@Override
	public String findFilePathByID(int id) {
		return file.findFilePathByID(id);
	}

	@Override
	public String findFilePathByMD5(String MD5) {
		return file.findFilePathByMD5(MD5);
	}

	@Override
	public int getFileNumInSystemFolder(String folder) {
		return file.getFileNumInSystemFolder(folder);
	}

	@Override
	public String getNextFolder() {
		return file.getNextFolder();
	}

}
