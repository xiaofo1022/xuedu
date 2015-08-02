package com.xiaofo1022.xuedu.model;

import java.util.Date;

import com.xiaofo1022.xuedu.dao.common.Column;

public class SupplementAnswer {
	@Column("ID")
	private int id;
	@Column("INSERT_DATETIME")
	private Date insertDatetime;
	@Column("UPDATE_DATETIME")
	private Date updateDatetime;
	@Column(value="UPDATE_DATETIME", isFormatDatetime=true)
	private String updateDatetimeLabel;
	@Column("FANS_NAME")
	private String fansName;
	@Column("ANSWER")
	private String answer;
	@Column("IS_ACTIVE")
	private int isActive;
	@Column("IS_APPROVED")
	private int isApproved;
	@Column("ANSWER_ID")
	private int answerId;
	@Column("PARENT_ANSWER_TITLE")
	private String parentAnswerTitle;
	
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
	public String getUpdateDatetimeLabel() {
		return updateDatetimeLabel;
	}
	public void setUpdateDatetimeLabel(String updateDatetimeLabel) {
		this.updateDatetimeLabel = updateDatetimeLabel;
	}
	public String getFansName() {
		return fansName;
	}
	public void setFansName(String fansName) {
		this.fansName = fansName;
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
	public int getIsApproved() {
		return isApproved;
	}
	public void setIsApproved(int isApproved) {
		this.isApproved = isApproved;
	}
	public int getAnswerId() {
		return answerId;
	}
	public void setAnswerId(int answerId) {
		this.answerId = answerId;
	}
	public String getParentAnswerTitle() {
		return parentAnswerTitle;
	}
	public void setParentAnswerTitle(String parentAnswerTitle) {
		this.parentAnswerTitle = parentAnswerTitle;
	}
}
