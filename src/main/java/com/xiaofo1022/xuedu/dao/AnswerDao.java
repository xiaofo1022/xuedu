package com.xiaofo1022.xuedu.dao;

import java.util.Calendar;
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
	
	private static Calendar calendar = Calendar.getInstance();
	
	public void insertAnswer(Answer answer) {
		Date now = new Date();
		calendar.setTime(now);
		if (answer.getIsEasterEgg() == 1) {
			calendar.set(Calendar.YEAR, 2014);
		}
		commonDao.insert("INSERT INTO ANSWER (INSERT_DATETIME, UPDATE_DATETIME, TITLE, ANSWER, IS_EASTER_EGG, EASTER_CODE, NEXT_EASTER_TIP) VALUES (?, ?, ?, ?, ?, ?, ?)",
			calendar.getTime(), calendar.getTime(), answer.getTitle(), answer.getAnswer(), answer.getIsEasterEgg(), answer.getEasterCode(), answer.getNextEasterTip());
	}
	
	public void updateAnswer(Answer answer) {
		if (answer.getIsEasterEgg() == 1) {
			updateAnswerWithoutDatetime(answer);
		} else {
			updateAnswerWithDatetime(answer);
		}
	}
	
	public void updateAnswerWithoutDatetime(Answer answer) {
		commonDao.update("UPDATE ANSWER SET TITLE = ?, ANSWER = ?, IS_EASTER_EGG = ?, EASTER_CODE = ?, NEXT_EASTER_TIP = ? WHERE ID = ?",
			answer.getTitle(), answer.getAnswer(), answer.getIsEasterEgg(), answer.getEasterCode(), answer.getNextEasterTip(), answer.getId());
	}
	
	public void updateAnswerWithDatetime(Answer answer) {
		commonDao.update("UPDATE ANSWER SET UPDATE_DATETIME = ?, TITLE = ?, ANSWER = ?, IS_EASTER_EGG = ?, EASTER_CODE = ?, NEXT_EASTER_TIP = ? WHERE ID = ?",
			new Date(), answer.getTitle(), answer.getAnswer(), answer.getIsEasterEgg(), answer.getEasterCode(), answer.getNextEasterTip(), answer.getId());
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
	
	public void removeEaster(int id) {
		commonDao.update("UPDATE ANSWER SET IS_EASTER_EGG = 0 WHERE ID = ?", id);
	}
}
