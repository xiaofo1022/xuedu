package com.xiaofo1022.xuedu.model;

public class AnalysisResult {

	private String ip;
	private int all;
	private int index;
	private int getanswer;
	private int blursearch;
	private int answerlistByFans;
	private int shuffle;
	private int latest;
	private int hotest;
	private int happiest;
	private int contribute;
	
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getAll() {
		return all;
	}
	public void setAll(int all) {
		this.all = all;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public int getGetanswer() {
		return getanswer;
	}
	public void setGetanswer(int getanswer) {
		this.getanswer = getanswer;
	}
	public int getBlursearch() {
		return blursearch;
	}
	public void setBlursearch(int blursearch) {
		this.blursearch = blursearch;
	}
	public int getAnswerlistByFans() {
		return answerlistByFans;
	}
	public void setAnswerlistByFans(int answerlistByFans) {
		this.answerlistByFans = answerlistByFans;
	}
	public int getShuffle() {
		return shuffle;
	}
	public void setShuffle(int shuffle) {
		this.shuffle = shuffle;
	}
	public int getLatest() {
		return latest;
	}
	public void setLatest(int latest) {
		this.latest = latest;
	}
	public int getHotest() {
		return hotest;
	}
	public void setHotest(int hotest) {
		this.hotest = hotest;
	}
	public int getHappiest() {
		return happiest;
	}
	public void setHappiest(int happiest) {
		this.happiest = happiest;
	}
	public int getContribute() {
		return contribute;
	}
	public void setContribute(int contribute) {
		this.contribute = contribute;
	}
	public void increaseAll() {
		this.all++;
	}
	public void increaseIndex() {
		this.index++;
	}
}
