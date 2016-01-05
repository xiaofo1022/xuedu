package com.xiaofo1022.xuedu.test;

import java.util.Map;

import com.xiaofo1022.xuedu.analyzer.PVAnalyzer;
import com.xiaofo1022.xuedu.model.AnalysisResult;

public class PVAnalyzerTest {

	public static void main(String[] args) {
		PVAnalyzer pvAnalyzer = new PVAnalyzer();
		pvAnalyzer.analysisLogFileByDay("2015-12-31");
		Map<String, AnalysisResult> resultMap = pvAnalyzer.getResultMap();
		System.out.println(resultMap);
	}
}
