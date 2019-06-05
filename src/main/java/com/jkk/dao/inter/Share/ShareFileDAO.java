package com.jkk.dao.inter.Share;

import com.jkk.model.Share.ShareFile;
import com.jkk.model.User;

import java.util.List;

public interface ShareFileDAO {
	boolean share(String uuid, Integer rsid, String limitTime, String pwd);

	boolean share(String uuid, Integer rsid, String limitTime);

	boolean updateLimitTime(String url,String limitTime);

	ShareFile getShareByurl(String url);

	List<ShareFile> getAllShareByUserId(Integer userId);

	boolean delShare(String url, Integer userId);

	String hasShareByRsid(Integer rsid, Integer userId);

	User getShareUser(String url);
}
