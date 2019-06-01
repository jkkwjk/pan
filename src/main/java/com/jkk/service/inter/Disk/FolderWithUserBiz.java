package com.jkk.service.inter.Disk;

import com.jkk.model.Folder;

import java.util.List;

public interface FolderWithUserBiz {
	Integer addFolder(Folder folder);

	Integer deleteFolder(Integer folderId);

	List<Folder> getAllFolderInPfolder(Integer parFolderId);

	boolean checkFolder(Integer folderId);

	int deleteAllFolderInPfolder(Integer parFolder);

	boolean hasFolder(String folderName,Integer parFolderId);

	int renameFolder(Integer folderId,String name);

	String getFolderName(Integer folderId);
}
