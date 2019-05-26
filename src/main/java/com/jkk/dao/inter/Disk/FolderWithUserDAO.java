package com.jkk.dao.inter.Disk;

import com.jkk.model.Folder;

import java.util.List;

public interface FolderWithUserDAO {
	Integer addFolder(Folder folder);

	Integer deleteFolder(Integer folderId);

	List<Folder> getAllFolderInPfolder(Integer parFolderId);

	boolean checkFolder(Integer folderId);

	int deleteAllFolderInPfolder(Integer parFolder);

	boolean hasFolder(String folderName,Integer parFolderId);

}
