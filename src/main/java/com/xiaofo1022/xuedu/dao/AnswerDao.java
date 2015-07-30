package com.xiaofo1022.xuedu.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.Answer;

@Repository
public class AnswerDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertAnswer(Answer answer) {
		Date now = new Date();
		commonDao.insert("INSERT INTO ANSWER (INSERT_DATETIME, UPDATE_DATETIME, TITLE, ANSWER) VALUES (?, ?, ?, ?)",
			now, now, answer.getTitle(), answer.getAnswer());
	}
	
	public void updateAnswer(Answer answer) {
		commonDao.update("UPDATE ANSWER SET UPDATE_DATETIME = ?, TITLE = ?, ANSWER = ? WHERE ID = ?",
			new Date(), answer.getTitle(), answer.getAnswer(), answer.getId());
	}
	
	public List<Answer> getHotestAnswerList() {
		return commonDao.query(Answer.class, "SELECT * FROM ANSWER WHERE IS_ACTIVE = 1 ORDER BY SEARCH_COUNT DESC");
	}
	
	public List<Answer> getLatestAnswerList() {
		return commonDao.query(Answer.class, "SELECT * FROM ANSWER WHERE IS_ACTIVE = 1 ORDER BY UPDATE_DATETIME DESC");
	}
	
	public Answer getAnswerDetail(int id) {
		return commonDao.getFirst(Answer.class, "SELECT * FROM ANSWER WHERE ID = ?", id);
	}
	
	public void deleteAnswer(int id) {
		commonDao.update("UPDATE ANSWER SET IS_ACTIVE = 0 WHERE ID = ?", id);
	}
	
	public void increaseSearchCount(int id) {
		Answer answer = commonDao.getFirst(Answer.class, "SELECT * FROM ANSWER WHERE ID = ?", id);
		if (answer != null) {
			int searchCount = answer.getSearchCount();
			searchCount++;
			commonDao.update("UPDATE ANSWER SET SEARCH_COUNT = ? WHERE ID = ?", searchCount, id);
		}
	}
}
