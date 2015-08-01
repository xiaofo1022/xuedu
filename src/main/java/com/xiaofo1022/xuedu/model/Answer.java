package com.xiaofo1022.xuedu.model;

import java.util.Date;

import com.xiaofo1022.xuedu.dao.common.Column;
import com.xiaofo1022.xuedu.dao.common.JoinTable;

public class Answer {
	@Column("ID")
	private int id;
	@Column("INSERT_DATETIME")
	private Date insertDatetime;
	@Column("UPDATE_DATETIME")
	private Date updateDatetime;
	@Column(value="UPDATE_DATETIME", isFormatDatetime=true)
	private String updateDatetimeLabel;
	@Column("TITLE")
	private String title;
	@Column("ANSWER")
	private String answer;
	@Column("IS_ACTIVE")
	private int isActive;
	@Column("SEARCH_COUNT")
	private int searchCount;
	@Column("IS_EASTER_EGG")
	private int isEasterEgg;
	@Column("EASTER_CODE")
	private String easterCode;
	@Column("NEXT_EASTER_TIP")
	private String nextEasterTip;
	@Column("FANS_ID")
	private int fansId;
	@JoinTable(tableName="FANS_ANSWER", joinField="fansId")
	private FansAnswer fansAnswer;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getInsertDatetime() {
		return insertDatetime;
	}
	public void setInsertDatetime(Date insertDatetime) {
		this.insertDatetime = insertDatetime;
	}
	public Date getUpdateDatetime() {
		return updateDatetime;
	}
	public void setUpdateDatetime(Date updateDatetime) {
		this.updateDatetime = updateDatetime;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public int getIsActive() {
		return isActive;
	}
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	public int getSearchCount() {
		return searchCount;
	}
	public void setSearchCount(int searchCount) {
		this.searchCount = searchCount;
	}
	public int getIsEasterEgg() {
		return isEasterEgg;
	}
	public void setIsEasterEgg(int isEasterEgg) {
		this.isEasterEgg = isEasterEgg;
	}
	public String getEasterCode() {
		return easterCode;
	}
	public void setEasterCode(String easterCode) {
		this.easterCode = easterCode;
	}
	public String getNextEasterTip() {
		return nextEasterTip;
	}
	public void setNextEasterTip(String nextEasterTip) {
		this.nextEasterTip = nextEasterTip;
	}
	public int getFansId() {
		return fansId;
	}
	public void setFansId(int fansId) {
		this.fansId = fansId;
	}
	public FansAnswer getFansAnswer() {
		return fansAnswer;
	}
	public void setFansAnswer(FansAnswer fansAnswer) {
		this.fansAnswer = fansAnswer;
	}
	public String getUpdateDatetimeLabel() {
		return updateDatetimeLabel;
	}
	public void setUpdateDatetimeLabel(String updateDatetimeLabel) {
		this.updateDatetimeLabel = updateDatetimeLabel;
	}
}
