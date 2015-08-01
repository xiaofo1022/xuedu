package com.xiaofo1022.xuedu.model;

public class FansContribute implements Comparable<FansContribute> {
	private String fansName;
	private int contributeCount;
	
	public String getFansName() {
		return fansName;
	}
	public void setFansName(String fansName) {
		this.fansName = fansName;
	}
	public int getContributeCount() {
		return contributeCount;
	}
	public void setContributeCount(int contributeCount) {
		this.contributeCount = contributeCount;
	}
	public int compareTo(FansContribute fansContribute) {
		int count = fansContribute.getContributeCount();
		if (this.contributeCount > count) {
			return -1;
		} else if (this.contributeCount == count) {
			return 0;
		} else {
			return 1;
		}
	}
}
