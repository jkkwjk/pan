package com.jkk.dao.impl.Disk;

import com.jkk.dao.inter.Disk.FileWithUserDAO;
import com.jkk.model.DBInfo;
import com.jkk.model.File;
import com.jkk.model.User;
import com.jkk.utils.DButil;
import com.jkk.utils.StampDate;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class FileWithUserDAOimpl extends FileBaseDAOimpl implements FileWithUserDAO{
	private String userId;
	public FileWithUserDAOimpl(String userId){
		this.userId = userId;
	}
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	DButil dButil = new DButil();
	@Override
	public List<File> getFileInfo(Integer start,Integer limitSize,Integer folderId) {
		List<Map<String,String>> map = dButil.exePresqlGetmap(String.format("SELECT * FROM %s where user_id=? and folder_id=? limit ?,?", DBInfo.USER_FILE_FOLDER),
				new Object[]{userId,folderId,start,limitSize});

		return getFileFromMapList(map);
	}

	@Override
	public int getAllFileCount() {
		return dButil.exePresqlSelect(String.format("SELECT id FROM %s where user_id=?", DBInfo.USER_FILE_FOLDER),new String[]{userId}).size();
	}

	@Override
	public String getAllFileSize() {
		List<String[]> list = dButil.exePresqlSelect(String.format("SELECT t2.file_size from %s t1,%s t2 where t1.user_id=? and t1.file_id=t2.id",
				DBInfo.USER_FILE_FOLDER,DBInfo.FILE),new String[]{userId});
		BigInteger res = new BigInteger("0");
		for (String[] str : list) {
			res = res.add(new BigInteger(str[0]));
		}

		return res.toString();
	}

	@Override
	public List<File> findSameFileByFileId(int fileId) {
		List<Map<String,String>> map = dButil.exePresqlGetmap(String.format("SELECT * from %s where user_id=? and file_id=?", DBInfo.USER_FILE_FOLDER),new String[]{userId,String.valueOf(fileId)});

		return getFileFromMapList(map);
	}

	@Override
	public List<File> findFileByNamePrecise(String fileName) {
		List<Map<String,String>> map = dButil.exePresqlGetmap(String.format("SELECT * from %s where user_id=? and file_name=?", DBInfo.USER_FILE_FOLDER),new String[]{userId,fileName});

		return getFileFromMapList(map);
	}

	@Override
	public List<File> findFileByNameBlurry(String fileNameLike) {
		List<Map<String,String>> map = dButil.exePresqlGetmap(String.format("SELECT * from %s where user_id=? and file_name like concat('%%',?,'%%')", DBInfo.USER_FILE_FOLDER),new String[]{userId,fileNameLike});

		return getFileFromMapList(map);
	}

	@Override
	public File findFileByNameInFolder(int folderId, String fileName) {
		List<Map<String,String>> map = dButil.exePresqlGetmap(String.format("SELECT * from %s where user_id=? and file_name =? and folder_id = ?", DBInfo.USER_FILE_FOLDER),new String[]{userId,fileName,String.valueOf(folderId)});

		return getFileFromMapList(map).get(0);
	}

	/**
	 * 要求 select * from DBInfo.USER_FILE_FOLDER
	 * @param map
	 * @return
	 */
	private List<File> getFileFromMapList(List<Map<String,String>> map) {
		List<File> list = new ArrayList<>();
		for (Map<String, String> stringStringMap : map) {
			int fileId = Integer.parseInt(stringStringMap.get("file_id"));
			String fileName = stringStringMap.get("file_name");
			String folderIdStr = stringStringMap.get("folder_id");
			Integer folderId = folderIdStr==null? null:Integer.parseInt(folderIdStr);
			String fileTime = StampDate.dateToStamp(stringStringMap.get("file_time"));
			Integer rsId = Integer.parseInt(stringStringMap.get("id"));
			File file = new File(fileId, fileName, folderId, fileTime,rsId);
			list.add(file);
		}
		return list;
	}
}
