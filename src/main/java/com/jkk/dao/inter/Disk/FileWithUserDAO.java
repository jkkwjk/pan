package com.jkk.dao.inter.Disk;

import com.jkk.model.File;

import java.util.List;

public interface FileWithUserDAO extends FileBaseDAO{
	List<File> getFileInfo(Integer start,Integer limitSize,Integer folderId);

	int getAllFileCount();

	String getAllFileSize();

	List<File> findSameFileByFileId(int fileId);

	List<File> findFileByNamePrecise(String fileName);

	List<File> findFileByNameBlurry(String fileNameLike);

	File findFileByNameInFolder(int folderId,String fileName);

	File addFile(File file,String fileMD5,String fileSize,String objPath);

	File getFileInfoByRSID(Integer rsID);
}
