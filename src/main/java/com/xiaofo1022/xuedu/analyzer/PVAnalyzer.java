package com.xiaofo1022.xuedu.analyzer;

import java.io.IOException;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.xiaofo1022.xuedu.model.AnalysisResult;

public class PVAnalyzer {

	private static Pattern ipPattern = Pattern.compile("\\d+\\.\\d+\\.\\d+\\.\\d+");
	private static Pattern requestPattern = Pattern.compile("\".+\"");
	
	//private static final String BASE_PATH = "F:\\apache-tomcat-7.0.42\\logs\\";
	private static final String BASE_PATH = "C:\\apache-tomcat-7.0.62\\logs\\";
	private static final String PREFIX = "localhost_access_log.";
	private static final String SUFFIX = ".txt";
	
	private Map<String, AnalysisResult> resultMap = new HashMap<String, AnalysisResult>();
	
	public void analysisLogFileByDay(String dayStr) {
		Path logFile = Paths.get(BASE_PATH + PREFIX + dayStr + SUFFIX);
		if (Files.exists(logFile)) {
			try {
				List<String> logFileLines = Files.readAllLines(logFile, StandardCharsets.UTF_8);
				if (logFileLines != null) {
					for (String logLine : logFileLines) {
						String ip = getIp(logLine);
						if (!resultMap.containsKey(ip)) {
							AnalysisResult result = new AnalysisResult();
							result.setIp(ip);
							resultMap.put(ip, result);
						}
						AnalysisResult result = resultMap.get(ip);
						startAnalysis(logLine, result);
						clearEmptyResult();
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public String getIp(String logLine) {
		return findGroup(logLine, ipPattern);
	}
	
	public String getRequest(String logLine) {
		return findGroup(logLine, requestPattern).replaceAll("\"", "");
	}
	
	private String findGroup(String input, Pattern pattern) {
		String group = "";
		Matcher matcher = pattern.matcher(input);
		if (matcher.find()) {
			group = matcher.group();
		}
		return group;
	}
	
	private boolean startAnalysis(String logLine, AnalysisResult result) {
		boolean isValidRequest = false;
		
		String request = getRequest(logLine);
		if (!request.equals("") && request.startsWith("GET")) {
			String requestUrl = request.split(" ")[1];
			Field[] fields = AnalysisResult.class.getDeclaredFields();
			for (Field field : fields) {
				String fieldName = field.getName();
				if (requestUrl.indexOf("/" + fieldName) >= 0) {
					isValidRequest = true;
					field.setAccessible(true);
					try {
						int count = Integer.valueOf(field.get(result).toString());
						field.set(result, ++count);
						result.increaseAll();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				if (requestUrl.equals("/")) {
					result.increaseAll();
					result.increaseIndex();
				}
			}
		}
		
		return isValidRequest;
	}

	private void clearEmptyResult() {
		Iterator<String> iterator = resultMap.keySet().iterator();
		Map<String, AnalysisResult> finalResult = new HashMap<String, AnalysisResult>(resultMap.size());
		while (iterator.hasNext()) {
			String ip = iterator.next();
			if (resultMap.get(ip).getAll() != 0) {
				finalResult.put(ip, resultMap.get(ip));
			}
		}
		resultMap = finalResult;
	}
	
	public Map<String, AnalysisResult> getResultMap() {
		return resultMap;
	}
}
