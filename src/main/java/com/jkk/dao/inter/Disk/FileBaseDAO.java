package com.jkk.dao.inter.Disk;

public interface FileBaseDAO {
	int getFileIdByMD5(String MD5);

	String getFileMD5ByID(int id);

	Boolean existFile(String MD5);

	String getFileSizeByID(int id);

	String getFileSizeByMD5(String MD5);

	String FindFilePathByID(int id);

	String FindFilePathByMD5(String MD5);
}