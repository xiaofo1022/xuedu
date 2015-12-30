package com.xiaofo1022.xuedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.DownloadCount;

@Repository
public class UtilDao {
	@Autowired
	private CommonDao commonDao;
	
	public void increaseApkDownloadCount() {
		DownloadCount downloadCount = commonDao.getFirst(DownloadCount.class, "SELECT * FROM DOWNLOAD_COUNT WHERE ID = 1");
		if (downloadCount != null) {
			int count = downloadCount.getCount();
			count++;
			commonDao.update("UPDATE DOWNLOAD_COUNT SET COUNT = ? WHERE ID = 1", count);
		}
	}
	
	public int getDownloadCount() {
		DownloadCount downloadCount = commonDao.getFirst(DownloadCount.class, "SELECT * FROM DOWNLOAD_COUNT WHERE ID = 1");
		if (downloadCount != null) {
			return downloadCount.getCount();
		}
		return 0;
	}
}
