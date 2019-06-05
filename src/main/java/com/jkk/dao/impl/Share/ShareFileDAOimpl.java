package com.jkk.dao.impl.Share;

import com.jkk.dao.inter.Share.ShareFileDAO;
import com.jkk.model.DBInfo;
import com.jkk.model.File;
import com.jkk.model.Share.ShareFile;
import com.jkk.model.User;
import com.jkk.utils.DButil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ShareFileDAOimpl implements ShareFileDAO {
	private DButil dButil = new DButil();
	@Override
	public boolean share(String uuid, Integer rsid, String limitTime, String pwd) {
		return dButil.exePresqlModifyData(String.format("INSERT INTO %s(url,link_id,limit_time,pwd) VALUES(?,?,?,?)", DBInfo.SHARE_FILE),
				new Object[]{uuid,rsid,limitTime,pwd})==1;
	}

	@Override
	public boolean share(String uuid, Integer rsid, String limitTime) {
		return dButil.exePresqlModifyData(String.format("INSERT INTO %s(url,link_id,limit_time) VALUES(?,?,?)", DBInfo.SHARE_FILE),
				new Object[]{uuid,rsid,limitTime})==1;
	}

	@Override
	public boolean updateLimitTime(String url, String limitTime) {
		return dButil.exePresqlModifyData(String.format("update %s set limit_time=? where url=?", DBInfo.SHARE_FILE),
				new Object[]{limitTime,url})==1;
	}

	@Override
	public ShareFile getShareByurl(String url) {
		List<Map<String,String>> mapList = dButil.exePresqlGetmap(String.format("SELECT * FROM %s WHERE url=? limit 1", DBInfo.SHARE_FILE),
				new Object[]{url});
		if (mapList.size()==0){
			return null;
		}else {
			Map<String,String> map = mapList.get(0);
			String rsid = map.get("link_id");
			return new ShareFile(map.get("url"),map.get("limit_time"),map.get("pwd"),getFileByrsid(Integer.parseInt(rsid)));
		}

	}

	@Override
	public List<ShareFile> getAllShareByUserId(Integer userId) {
		List<Map<String,String>> mapList = dButil.exePresqlGetmap(String.format("SELECT * FROM %s t1,%s t2 WHERE t1.link_id=t2.id and t2.user_id=?", DBInfo.SHARE_FILE,DBInfo.USER_FILE),
				new Object[]{userId});
		List<ShareFile> list = new ArrayList<>();
		for (Map<String, String> map : mapList) {
			ShareFile shareFile = new ShareFile(map.get("url"),map.get("limit_time"),map.get("pwd"),
					new File(Integer.parseInt(map.get("file_id")),map.get("file_name"),Integer.parseInt(map.get("folder_id")),
							map.get("file_time"),Integer.parseInt(map.get("id"))));
			list.add(shareFile);
		}
		return list;
	}

	@Override
	public boolean delShare(String url, Integer userId) {
		return dButil.exePresqlModifyData(String.format("DELETE t1 from %s t1,%s t2 where t1.url=? and t1.link_id=t2.id and t2.user_id=?", DBInfo.SHARE_FILE,DBInfo.USER_FILE),
				new Object[]{url,userId})==1;
	}

	@Override
	public String hasShareByRsid(Integer rsid, Integer userId) {
		List<String[]> list = dButil.exePresqlSelect(String.format("select t1.url from %s t1,%s t2 where t1.link_id=t2.id and t2.user_id=? and t2.id=? limit 1", DBInfo.SHARE_FILE,DBInfo.USER_FILE),
				new Object[]{userId,rsid});
		if (list.size()==0){
			return null;
		}else {
			return list.get(0)[0];
		}
	}

	@Override
	public User getShareUser(String url) {
		List<Map<String,String>> mapList = dButil.exePresqlGetmap(String.format("select t3.* from %s t1,%s t2,%s t3 where t1.link_id=t2.id and t1.url=? and t2.user_id=t3.id limit 1", DBInfo.SHARE_FILE,DBInfo.USER_FILE,DBInfo.USER),
				new Object[]{url});
		if (mapList.size()==0){
			return null;
		}else {
			Map<String,String> map = mapList.get(0);
			return new User(Integer.parseInt(map.get("id")),map.get("name"),Integer.parseInt(map.get("permission_id")));
		}
	}

	private File getFileByrsid(Integer rsid) {
		Map<String,String> map = dButil.exePresqlGetmap(String.format("SELECT * FROM %s where id=? limit 1", DBInfo.USER_FILE),
				new Object[]{rsid}).get(0);
		return new File(Integer.parseInt(map.get("file_id")),map.get("file_name"),Integer.parseInt(map.get("folder_id")),
				map.get("file_time"),Integer.parseInt(map.get("id")));
	}
}
