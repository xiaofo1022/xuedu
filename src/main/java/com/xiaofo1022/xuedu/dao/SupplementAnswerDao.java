package com.xiaofo1022.xuedu.dao;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.SupplementAnswer;

@Repository
public class SupplementAnswerDao {
	@Autowired
	private CommonDao commonDao;
	
	public void insertIntoSupplementAnswer(SupplementAnswer supplementAnswer) {
		Date now = new Date();
		commonDao.insert("INSERT INTO SUPPLEMENT_ANSWER (INSERT_DATETIME, UPDATE_DATETIME, ANSWER_ID, FANS_NAME, ANSWER, TITLE) VALUES (?, ?, ?, ?, ?, ?)",
				now, now, supplementAnswer.getAnswerId(), supplementAnswer.getFansName(), supplementAnswer.getAnswer(), supplementAnswer.getTitle());
	}
	
	public List<SupplementAnswer> getSuppleAnswerList(int answerId) {
		return commonDao.query(SupplementAnswer.class, "SELECT * FROM SUPPLEMENT_ANSWER WHERE ANSWER_ID = ? AND IS_ACTIVE = 1 AND IS_APPROVED = 1 ORDER BY UPDATE_DATETIME", answerId);
	}
	
	public List<SupplementAnswer> getUnapprovedAnswerList() {
		return commonDao.query(SupplementAnswer.class, "SELECT A.*, B.TITLE AS PARENT_ANSWER_TITLE FROM SUPPLEMENT_ANSWER A LEFT JOIN ANSWER B ON A.ANSWER_ID = B.ID WHERE A.IS_ACTIVE = 1 AND A.IS_APPROVED = 0 ORDER BY UPDATE_DATETIME DESC");
	}
	
	public SupplementAnswer getSupplementAnswer(int suppleId) {
		return commonDao.getFirst(SupplementAnswer.class, "SELECT * FROM SUPPLEMENT_ANSWER WHERE ID = ?", suppleId);
	}
	
	public void approveSupplement(int id) {
		commonDao.update("UPDATE SUPPLEMENT_ANSWER SET IS_APPROVED = 1 WHERE ID = ?", id);
	}
	
	public void denialSupplement(int id) {
		commonDao.update("UPDATE SUPPLEMENT_ANSWER SET IS_ACTIVE = 0 WHERE ID = ?", id);
	}
}
