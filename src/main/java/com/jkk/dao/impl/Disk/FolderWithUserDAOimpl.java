package com.jkk.dao.impl.Disk;

import com.jkk.dao.inter.Disk.FolderWithUserDAO;
import com.jkk.model.DBInfo;
import com.jkk.model.Folder;
import com.jkk.utils.DButil;
import com.sun.org.apache.bcel.internal.generic.NEW;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FolderWithUserDAOimpl implements FolderWithUserDAO {
	DButil dButil = new DButil();
	private Integer userID;
	public FolderWithUserDAOimpl(Integer userID){
		this.userID=userID;
	}
	@Override
	public Integer addFolder(Folder folder) {
		return dButil.exePresqlModifyData(String.format("INSERT into %s(name,user_id,folder_time,p_folder_id) VALUES(?,?,?,?)", DBInfo.FOLDER),
				new Object[]{folder.getName(),userID,folder.getTime(),folder.getpFolderId()});
	}

	@Override
	public Integer deleteFolder(Integer folderId) {
		return dButil.exePresqlModifyData(String.format("DELETE FROM %s where id=? and user_id=?", DBInfo.FOLDER),
				new Object[]{folderId,userID});
	}

	@Override
	public List<Folder> getAllFolderInPfolder(Integer parFolderId) {
		List<Map<String,String>> mapList = dButil.exePresqlGetmap(String.format("select * from %s where p_folder_id=? and user_id=? order by name", DBInfo.FOLDER),
				new Object[]{parFolderId,userID});
		List<Folder> list = new ArrayList<>();

		for (Map<String, String> map : mapList) {
			String id = map.get("id");
			String name = map.get("name");
			String folder_time = map.get("folder_time");
			String p_folder_id = map.get("p_folder_id");

			Folder folder = new Folder(Integer.parseInt(id),name,folder_time,Integer.parseInt(p_folder_id));
			list.add(folder);
		}

		return list;
	}

	@Override
	public boolean checkFolder(Integer folderId) {
		return dButil.hasData(String.format("select id from %s where user_id=? and id=?", DBInfo.FOLDER),
				new Object[]{userID,folderId});
	}

	@Override
	public int deleteAllFolderInPfolder(Integer parFolder) {
		return dButil.exePresqlModifyData(String.format("DELETE FROM %s where p_folder_id=? and user_id=?", DBInfo.FOLDER),
				new Object[]{parFolder,userID});
	}

	@Override
	public boolean hasFolder(String folderName, Integer parFolderId) {
		return dButil.hasData(String.format("select id from %s where p_folder_id=? and name=? and user_id=?", DBInfo.FOLDER),
				new Object[]{parFolderId,folderName,userID});
	}
}
