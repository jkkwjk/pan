package com.jkk.service.impl.Share;

import com.jkk.dao.impl.Share.ShareFileDAOimpl;
import com.jkk.model.Share.ShareFile;
import com.jkk.model.User;
import com.jkk.service.inter.Share.ShareFileBiz;
import com.jkk.utils.UUIDutil;

import java.util.List;

public class ShareFileImpl implements ShareFileBiz {
	private ShareFileDAOimpl shareFileDAOimpl = new ShareFileDAOimpl();
	@Override
	public String share(Integer rsid, String limitTime, String pwd) {
		String uuid = UUIDutil.getUUID();
		if (shareFileDAOimpl.share(uuid,rsid,limitTime,pwd)){
			return uuid;
		}else {
			return null;
		}
	}

	@Override
	public String share(Integer rsid, String limitTime) {
		String uuid = UUIDutil.getUUID();
		if (shareFileDAOimpl.share(uuid,rsid,limitTime)){
			return uuid;
		}else {
			return null;
		}
	}

	@Override
	public boolean updateLimitTime(String url,String limitTime) {
		return shareFileDAOimpl.updateLimitTime(url,limitTime);
	}

	@Override
	public ShareFile getShareByurl(String url) {
		return shareFileDAOimpl.getShareByurl(url);
	}

	@Override
	public List<ShareFile> getAllShareByUserId(Integer userId) {
		return shareFileDAOimpl.getAllShareByUserId(userId);
	}

	@Override
	public boolean delShare(String url, Integer userId) {
		return shareFileDAOimpl.delShare(url,userId);
	}

	@Override
	public String hasShareByRsid(Integer rsid, Integer userId) {
		return shareFileDAOimpl.hasShareByRsid(rsid,userId);
	}

	@Override
	public User getShareUser(String url) {
		return shareFileDAOimpl.getShareUser(url);
	}
}
