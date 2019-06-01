package com.jkk.service.inter.Disk;

import com.jkk.model.File;

import java.util.List;

public interface FileWithUserBiz extends FileBaseBiz{
	List<File> getFileInfo(Integer start,Integer limitSize,Integer folderId);

	List<File> getAll();

	int getAllFileCount();

	String getAllFileSize();

	List<File> findSameFileByFileId(int fileId); //用来 查找用户上传的重复文件

	List<File> findFileByNamePrecise(String fileName);

	List<File> findFileByNameBlurry(String fileNameLike);

	File findFileByNameInFolder(int folderId,String fileName);

	File addFile(File file,String fileMD5,String fileSize,String objPath);

	File getFileInfoByRSID(Integer rsID);

	int deleteFile(Integer rsId);

	int deleteAllFileInFolder(Integer folderId);

	int renameFile(Integer rsId,String fileName);
}
