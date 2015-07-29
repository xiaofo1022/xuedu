package com.xiaofo1022.xuedu.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.Question;

@Repository
public class QuestionDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertQuestion(Question question) {
		String ques = question.getQuestion();
		if (ques != null) {
			ques = ques.trim();
			if (!ques.equals("") && !this.isExistSameQuestion(ques)) {
				Date now = new Date();
				commonDao.insert("INSERT INTO QUESTION (INSERT_DATETIME, UPDATE_DATETIME, QUESTION) VALUES (?, ?, ?)", now, now, ques);
			}
		}
	}
	
	public List<Question> getQuestionList() {
		return commonDao.query(Question.class, "SELECT * FROM QUESTION WHERE IS_ACTIVE = 1 AND IS_ANSWERED = 0 ORDER BY UPDATE_DATETIME DESC");
	}
	
	public boolean isExistSameQuestion(String ques) {
		Question question = commonDao.getFirst(Question.class, "SELECT * FROM QUESTION WHERE QUESTION = ?", ques);
		if (question != null) {
			return true;
		} else {
			return false;
		}
	}
	
	public void giveAnAnswer(int id) {
		commonDao.update("UPDATE QUESTION SET IS_ANSWERED = 1 WHERE ID = ?", id);
	}
	
	public void ignoreQuestion(int id) {
		commonDao.update("UPDATE QUESTION SET IS_ACTIVE = 0 WHERE ID = ?", id);
	}
}
