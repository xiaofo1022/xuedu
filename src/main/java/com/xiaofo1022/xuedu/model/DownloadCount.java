package com.xiaofo1022.xuedu.model;

import com.xiaofo1022.xuedu.dao.common.Column;

public class DownloadCount {

	@Column("ID")
	private int id;
	@Column("COUNT")
	private int count;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
