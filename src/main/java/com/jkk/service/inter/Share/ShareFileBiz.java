package com.jkk.service.inter.Share;

import com.jkk.model.Share.ShareFile;

import java.util.List;

public interface ShareFileBiz {
	String share(Integer rsid, String limitTime, String pwd);

	String share(Integer rsid, String limitTime);

	boolean updateLimitTime(String url,String limitTime);

	ShareFile getShareByurl(String url);

	List<ShareFile> getAllShareByUserId(Integer userId);
}
