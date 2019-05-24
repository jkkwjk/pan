package com.jkk.dao.impl.Disk;

import com.jkk.dao.inter.Disk.FileBaseDAO;
import com.jkk.model.DBInfo;
import com.jkk.utils.DButil;

import java.util.List;
import java.util.Map;

public class FileBaseDAOimpl implements FileBaseDAO {
	public static final Integer MAX_FILE_IN_SYSTEM_FOLDER = 1000;

	DButil dButil = new DButil();
	@Override
	public Integer getFileIdByMD5(String MD5) {
		List<String[]> list = dButil.exePresqlSelect(String.format("SELECT id FROM %s where md5=? limit 1", DBInfo.FILE),new String[]{MD5});
		if (list.isEmpty()){
			return null;
		}else {
			return Integer.parseInt(list.get(0)[0]);
		}
	}

	@Override
	public String getFileMD5ByID(int id) {
		return dButil.exePresqlSelect(String.format("SELECT md5 FROM %s where id=? limit 1", DBInfo.FILE),new String[]{String.valueOf(id)}).get(0)[0];
	}

	@Override
	public Boolean existFile(String MD5) {
		return dButil.hasData(String.format("SELECT id FROM %s where md5=? limit 1", DBInfo.FILE),new String[]{MD5});
	}

	@Override
	public String getFileSizeByID(int id) {
		return dButil.exePresqlSelect(String.format("SELECT file_size FROM %s where id=? limit 1", DBInfo.FILE),new String[]{String.valueOf(id)}).get(0)[0];
	}

	@Override
	public String getFileSizeByMD5(String MD5) {
		return dButil.exePresqlSelect(String.format("SELECT file_size FROM %s where md5=? limit 1", DBInfo.FILE),new String[]{MD5}).get(0)[0];
	}

	@Override
	public String FindFilePathByID(int id) {
		return dButil.exePresqlSelect(String.format("SELECT folder_path FROM %s where id=? limit 1", DBInfo.FILE),new String[]{String.valueOf(id)}).get(0)[0];
	}

	@Override
	public String FindFilePathByMD5(String MD5) {
		return dButil.exePresqlSelect(String.format("SELECT folder_path FROM %s where md5=? limit 1", DBInfo.FILE),new String[]{MD5}).get(0)[0];
	}

	@Override
	public int getFileNumInSystemFolder(String folder) {
		return Integer.parseInt(dButil.exePresqlSelect(String.format("SELECT num FROM %s where path=?", DBInfo.FILE_NUM_IN_SYSTEM),new String[]{folder}).get(0)[0]);
	}

	@Override
	public String getNextFolder() {
		String objPath = null;
		int i;
		List<Map<String,String>> listMap = dButil.exePresqlGetmap(String.format("SELECT * from %s", DBInfo.FILE_NUM_IN_SYSTEM),null);
		//遍历列表
		for (i=0; i<listMap.size(); ++i) {
			if ( Integer.parseInt(listMap.get(i).get("num"))<FileBaseDAOimpl.MAX_FILE_IN_SYSTEM_FOLDER ) {
				//找到符合条件的目标路径
				objPath = listMap.get(i).get("path");
				break;
			}
		}
		//没找到
		if (i==listMap.size()) {
			objPath = String.valueOf(i);
		}
		return objPath;
	}
}
