package com.jkk.service.impl.Disk;

import com.jkk.dao.impl.Disk.FolderWithUserDAOimpl;
import com.jkk.model.Folder;
import com.jkk.model.User;
import com.jkk.service.inter.Disk.FolderWithUserBiz;

import java.util.List;

public class FolderWithUserImpl implements FolderWithUserBiz {
	Integer userId;
	private FolderWithUserDAOimpl folderWithUserDAOimpl;
	public FolderWithUserImpl(User user){
		this.userId=user.getUserId();
		folderWithUserDAOimpl = new FolderWithUserDAOimpl(userId);
	}
	@Override
	public Integer addFolder(Folder folder) {
		return folderWithUserDAOimpl.addFolder(folder);
	}

	@Override
	public Integer deleteFolder(Integer folderId) {
		return folderWithUserDAOimpl.deleteFolder(folderId);
	}

	@Override
	public List<Folder> getAllFolderInPfolder(Integer parFolderId) {
		return folderWithUserDAOimpl.getAllFolderInPfolder(parFolderId);
	}

	@Override
	public boolean checkFolder(Integer folderId) {
		return folderWithUserDAOimpl.checkFolder(folderId);
	}

	@Override
	public int deleteAllFolderInPfolder(Integer parFolder) {
		return folderWithUserDAOimpl.deleteAllFolderInPfolder(parFolder);
	}

	@Override
	public boolean hasFolder(String folderName, Integer parFolderId) {
		return folderWithUserDAOimpl.hasFolder(folderName,parFolderId);
	}

	@Override
	public int renameFolder(Integer folderId, String name) {
		return folderWithUserDAOimpl.renameFolder(folderId,name);
	}

	@Override
	public String getFolderName(Integer folderId) {
		return folderWithUserDAOimpl.getFolderName(folderId);
	}
}
