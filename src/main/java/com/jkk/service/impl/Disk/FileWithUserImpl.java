package com.jkk.service.impl.Disk;

import com.jkk.dao.impl.Disk.FileWithUserDAOimpl;
import com.jkk.model.File;
import com.jkk.model.User;
import com.jkk.service.inter.Disk.FileWithUserBiz;

import java.util.List;

public class FileWithUserImpl extends FileBaseImpl implements FileWithUserBiz{
	private String userId;

	private FileWithUserDAOimpl fileWithUserDAOimpl;

	public FileWithUserImpl(User user){
		this.userId = String.valueOf(user.getUserId());
		fileWithUserDAOimpl= new FileWithUserDAOimpl(this.userId);
	}
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public List<File> getFileInfo(Integer start,Integer limitSize,Integer folderId) {
		return fileWithUserDAOimpl.getFileInfo(start,limitSize,folderId);
	}

	@Override
	public int getAllFileCount() {
		return fileWithUserDAOimpl.getAllFileCount();
	}

	@Override
	public String getAllFileSize() {
		return fileWithUserDAOimpl.getAllFileSize();
	}

	@Override
	public List<File> findSameFileByFileId(int fileId) {
		return fileWithUserDAOimpl.findSameFileByFileId(fileId);
	}

	@Override
	public List<File> findFileByNamePrecise(String fileName) {
		return fileWithUserDAOimpl.findFileByNamePrecise(fileName);
	}

	@Override
	public List<File> findFileByNameBlurry(String fileNameLike) {
		return fileWithUserDAOimpl.findFileByNameBlurry(fileNameLike);
	}

	@Override
	public File findFileByNameInFolder(int folderId, String fileName) {
		return fileWithUserDAOimpl.findFileByNameInFolder(folderId,fileName);
	}

	/**
	 * 添加文件 包含两表的操作
	 * @param file File对象 如果fileID=null  则会往file表中加入该文件
	 * @param fileMD5
	 * @param fileSize
	 * @return 返回是否添加成功
	 */
	@Override
	public boolean addFile(File file, String fileMD5, String fileSize) {
		return fileWithUserDAOimpl.addFile(file,fileMD5,fileSize) == 1;
	}
}
