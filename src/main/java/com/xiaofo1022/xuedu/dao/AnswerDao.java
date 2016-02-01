package com.xiaofo1022.xuedu.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.Answer;

@Repository
public class AnswerDao {
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private SupplementAnswerDao supplementAnswerDao;
	
	private static Calendar calendar = Calendar.getInstance();
	
	public int insertAnswer(Answer answer) {
		Date now = new Date();
		calendar.setTime(now);
		if (answer.getIsEasterEgg() == 1) {
			calendar.set(Calendar.YEAR, 2014);
		}
		return commonDao.insert("INSERT INTO ANSWER (INSERT_DATETIME, UPDATE_DATETIME, TITLE, ANSWER, IS_EASTER_EGG, EASTER_CODE, NEXT_EASTER_TIP, FANS_ID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
			calendar.getTime(), calendar.getTime(), answer.getTitle(), answer.getAnswer(), answer.getIsEasterEgg(), answer.getEasterCode(), answer.getNextEasterTip(), answer.getFansId());
	}
	
	public int insertAnswer(String title, String answer, int fansId) {
		Date now = new Date();
		return commonDao.insert("INSERT INTO ANSWER (INSERT_DATETIME, UPDATE_DATETIME, TITLE, ANSWER, FANS_ID) VALUES (?, ?, ?, ?, ?)",
				now, now, title, answer, fansId);
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
	
	public void ding(int id) {
		commonDao.update("UPDATE ANSWER SET UPDATE_DATETIME = ? WHERE ID = ?", new Date(), id);
	}
	
	public List<Answer> blurSearchAnswerList(Answer answer) {
		String title = answer.getTitle();
		if (title != null) {
			title = title.trim();
			if (!title.equals("")) {
				return commonDao.query(Answer.class, "SELECT * FROM ANSWER WHERE TITLE LIKE '%" + title + "%' AND IS_ACTIVE = 1 ORDER BY UPDATE_DATETIME DESC");
			}
		}
		return null;
	}
	
	public List<Answer> getHotestAnswerList() {
		return commonDao.query(Answer.class, "SELECT * FROM ANSWER WHERE IS_ACTIVE = 1 ORDER BY SEARCH_COUNT DESC LIMIT 20");
	}
	
	public List<Answer> getAllLatestAnswerList() {
		return commonDao.query(Answer.class, "SELECT * FROM ANSWER WHERE IS_ACTIVE = 1 ORDER BY UPDATE_DATETIME DESC");
	}
	
	public List<Answer> getLatestAnswerList() {
		return commonDao.query(Answer.class, "SELECT * FROM ANSWER WHERE IS_ACTIVE = 1 ORDER BY UPDATE_DATETIME DESC LIMIT 20");
	}
	
	public List<Answer> getHappiestAnswerList() {
		return commonDao.query(Answer.class, "SELECT * FROM ANSWER WHERE IS_ACTIVE = 1 AND HAPPY_COUNT > 0 ORDER BY HAPPY_COUNT DESC LIMIT 20");
	}
	
	public List<Answer> getAnswerListByFansName(String fansName) {
		List<Answer> resultList = new ArrayList<Answer>();
		Map<String, Answer> answerMap = new HashMap<String, Answer>();
		
		List<Answer> contributeAnswerList = commonDao.query(Answer.class, "SELECT * FROM ANSWER A INNER JOIN FANS_ANSWER B ON A.FANS_ID = B.ID WHERE B.FANS_NAME = TRIM('" + fansName + "') AND B.IS_ACTIVE = 1 AND B.IS_APPROVED = 1 AND A.IS_ACTIVE = 1");
		if (contributeAnswerList != null && contributeAnswerList.size() > 0) {
			for (Answer answer : contributeAnswerList) {
				resultList.add(answer);
				answerMap.put(answer.getTitle(), answer);
			}
		}
		
		List<Answer> suppleAnswerList = commonDao.query(Answer.class, "SELECT A.ANSWER_ID AS ID, B.TITLE FROM SUPPLEMENT_ANSWER A LEFT JOIN ANSWER B ON A.ANSWER_ID = B.ID WHERE A.FANS_NAME = TRIM('" + fansName + "') AND A.IS_ACTIVE = 1 AND A.IS_APPROVED = 1 AND B.IS_ACTIVE = 1");
		if (suppleAnswerList != null && suppleAnswerList.size() > 0) {
			for (Answer answer : suppleAnswerList) {
				if (!answerMap.containsKey(answer.getTitle())) {
					resultList.add(answer);
					answerMap.put(answer.getTitle(), answer);
				}
			}
		}
		
		return resultList;
	}
	
	public List<Answer> getShuffleAnswerList() {
		List<Answer> shuffleAnswerList = new ArrayList<Answer>(20);
		Map<Integer, Integer> shuffleMap = new HashMap<Integer, Integer>();
		int answerCount = 0;
		while (answerCount < 20) {
			Answer shuffleAnswer = this.getShuffleAnswer();
			if (shuffleAnswer != null) {
				if (!shuffleMap.containsKey(shuffleAnswer.getId())) {
					shuffleAnswerList.add(shuffleAnswer);
					shuffleMap.put(shuffleAnswer.getId(), shuffleAnswer.getId());
					answerCount++;
				}
			}
		}
		return shuffleAnswerList;
	}
	
	public Answer getAnswer(int id) {
		Answer answer = this.getAnswerDetail(id);
		if (answer != null) {
			answer.setSupplementAnswerList(supplementAnswerDao.getSuppleAnswerList(id));
		}
		return answer;
	}
	
	public Answer getShuffleAnswer() {
		return commonDao.getFirst(Answer.class, "SELECT * FROM ANSWER AS T1 JOIN (SELECT ROUND(RAND() * ((SELECT MAX(ID) FROM ANSWER) - (SELECT MIN(ID) FROM ANSWER)) + (SELECT MIN(ID) FROM ANSWER)) AS ID) AS T2 WHERE T1.IS_ACTIVE = 1 AND T1.ID >= T2.ID ORDER BY T1.ID LIMIT 1");
	}
	
	public Answer getAnswerDetail(int id) {
		return commonDao.getFirst(Answer.class, "SELECT * FROM ANSWER WHERE ID = ?", id);
	}
	
	public Answer getAnswerByFansId(int fansId) {
		return commonDao.getFirst(Answer.class, "SELECT * FROM ANSWER WHERE FANS_ID = ?", fansId);
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
	
	public void increaseHappyCount(int id) {
		Answer answer = commonDao.getFirst(Answer.class, "SELECT * FROM ANSWER WHERE ID = ?", id);
		if (answer != null) {
			int happyCount = answer.getHappyCount();
			happyCount++;
			commonDao.update("UPDATE ANSWER SET HAPPY_COUNT = ? WHERE ID = ?", happyCount, id);
		}
	}
	
	public void removeEaster(int id) {
		commonDao.update("UPDATE ANSWER SET IS_EASTER_EGG = 0 WHERE ID = ?", id);
	}
	
	public void addEaster(int id) {
		commonDao.update("UPDATE ANSWER SET IS_EASTER_EGG = 1 WHERE ID = ?", id);
	}
}
