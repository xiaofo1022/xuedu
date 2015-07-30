package com.xiaofo1022.xuedu.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.FansAnswer;

@Repository
public class FansAnswerDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertFansAnswer(FansAnswer fansAnswer) {
		if (isValidAnswer(fansAnswer)) {
			Date now = new Date();
			commonDao.insert("INSERT INTO FANS_ANSWER (INSERT_DATETIME, UPDATE_DATETIME, FANS_NAME, TITLE, ANSWER) VALUES (?, ?, ?, ?, ?)",
				now, now, fansAnswer.getFansName(), fansAnswer.getTitle(), fansAnswer.getAnswer());
		}
	}
	
	public boolean isValidAnswer(FansAnswer fansAnswer) {
		if (fansAnswer != null) {
			String fansname = fansAnswer.getFansName();
			String title = fansAnswer.getTitle();
			String answer = fansAnswer.getAnswer();
			if (fansname != null) {
				fansname = fansname.trim();
			}
			if (title != null) {
				title = title.trim();
			}
			if (answer != null) {
				answer = answer.trim();
			}
			if (fansname != null && !fansname.equals("")
				&& title != null && !title.equals("")
				&& answer != null && !answer.equals("")) {
				return true;
			}
		}
		return false;
	}
	
	public List<FansAnswer> getFansAnswerList() {
		return commonDao.query(FansAnswer.class, "SELECT * FROM FANS_ANSWER WHERE IS_ACTIVE = 1 AND IS_APPROVED = 0 ORDER BY UPDATE_DATETIME DESC");
	}
	
	public FansAnswer getFansAnswerDetail(int id) {
		return commonDao.getFirst(FansAnswer.class, "SELECT * FROM FANS_ANSWER WHERE ID = ?", id);
	}
	
	public void deleteFansAnswer(int id) {
		commonDao.update("UPDATE FANS_ANSWER SET IS_ACTIVE = 0 WHERE ID = ?", id);
	}
	
	public void approveFansAnswer(int id) {
		commonDao.update("UPDATE FANS_ANSWER SET IS_APPROVED = 1 WHERE ID = ?", id);
	}
}
