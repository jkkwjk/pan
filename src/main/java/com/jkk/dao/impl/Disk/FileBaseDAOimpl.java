package com.jkk.dao.impl.Disk;

import com.jkk.dao.inter.Disk.FileBaseDAO;
import com.jkk.model.DBInfo;
import com.jkk.utils.DButil;

public class FileBaseDAOimpl implements FileBaseDAO {
	DButil dButil = new DButil();
	@Override
	public int getFileIdByMD5(String MD5) {
		return Integer.parseInt(dButil.exePresqlSelect(String.format("SELECT id FROM %s where md5=? limit 1", DBInfo.FILE),new String[]{MD5}).get(0)[0]);
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
}
