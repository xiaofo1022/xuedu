package com.xiaofo1022.xuedu.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.FansAnswer;
import com.xiaofo1022.xuedu.model.FansContribute;

@Repository
public class FansAnswerDao {
	@Autowired
	private CommonDao commonDao;
	@Autowired
	private AnswerDao answerDao;
	
	public void insertFansAnswer(FansAnswer fansAnswer) {
		if (isValidAnswer(fansAnswer)) {
			Date now = new Date();
			commonDao.insert("INSERT INTO FANS_ANSWER (INSERT_DATETIME, UPDATE_DATETIME, FANS_NAME, TITLE, ANSWER) VALUES (?, ?, ?, ?, ?)",
				now, now, fansAnswer.getFansName(), fansAnswer.getTitle(), fansAnswer.getAnswer());
		}
	}
	
	public int insertFansAnswer(String fansName, String title, String answer) {
		Date now = new Date();
		return commonDao.insert("INSERT INTO FANS_ANSWER (INSERT_DATETIME, UPDATE_DATETIME, FANS_NAME, TITLE, ANSWER, IS_APPROVED) VALUES (?, ?, ?, ?, ?, ?)",
			now, now, fansName, title, answer, 1);
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
	
	public List<FansContribute> getFansContributeList() {
		List<FansContribute> fansContributeList = new ArrayList<FansContribute>();
		List<FansAnswer> approvedFansAnswerList = getApprovedFansAnswerList();
		Map<String, FansContribute> fansMap = new HashMap<String, FansContribute>();
		
		if (approvedFansAnswerList != null && approvedFansAnswerList.size() > 0) {
			for (FansAnswer fansAnswer : approvedFansAnswerList) {
				String fansName = fansAnswer.getFansName();
				if (fansName != null) {
					fansName = fansName.trim();
					if (!fansMap.containsKey(fansName)) {
						FansContribute fansContribute = new FansContribute();
						fansContribute.setFansName(fansName);
						fansContribute.setContributeCount(1);
						fansMap.put(fansName, fansContribute);
					} else {
						FansContribute fansContribute = fansMap.get(fansName);
						fansContribute.setContributeCount(fansContribute.getContributeCount() + 1);
					}
				}
			}
		}
		
		for (String key : fansMap.keySet()) {
			fansContributeList.add(fansMap.get(key));
		}
		
		Collections.sort(fansContributeList);
		
		return fansContributeList;
	}
	
	public List<FansAnswer> getApprovedFansAnswerList() {
		return commonDao.query(FansAnswer.class, "SELECT * FROM FANS_ANSWER A INNER JOIN ANSWER B ON A.ID = B.FANS_ID WHERE B.IS_ACTIVE = 1");
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
