package com.jkk.dao.inter.Disk;

import com.jkk.model.File;

import java.util.List;

public interface FileWithUserDAO extends FileBaseDAO{
	List<File> getFileInfo(Integer start,Integer limitSize);

	int getAllFileCount();

	String getAllFileSize();

	List<File> findSameFileByFileId(int fileId);

	List<File> findFileByNamePrecise(String fileName);

	List<File> findFileByNameBlurry(String fileNameLike);

	String findFileTimeByFileId(int folderId,int fileId);

	List<File> findFileByNameInFolder(int folderId,String fileName);
}
