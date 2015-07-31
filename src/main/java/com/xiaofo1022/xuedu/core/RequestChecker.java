package com.xiaofo1022.xuedu.core;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class RequestChecker {
	public static String phoneReg = "\\b(ip(hone|od)|android|opera m(ob|in)i|windows (phone|ce)|blackberry|s(ymbian|eries60|amsung)|p(laybook|alm|rofile/midp|laystation portable)|nokia|fennec|htc[-_]|mobile|up.browser|[1-4][0-9]{2}x[1-4][0-9]{2})\\b";
	public static String tableReg = "\\b(ipad|tablet|(Nexus 7)|up.browser|[1-4][0-9]{2}x[1-4][0-9]{2})\\b";
	public static Pattern phonePat = Pattern.compile(phoneReg, Pattern.CASE_INSENSITIVE);
	public static Pattern tablePat = Pattern.compile(tableReg, Pattern.CASE_INSENSITIVE);

	public static boolean isFromMobile(HttpServletRequest request) {
		boolean isFromMobile = false;

		HttpSession session = request.getSession();
		
		if (session.getAttribute("userAgent") == null) {
			try {
				String userAgent = request.getHeader("USER-AGENT").toLowerCase();
				if (userAgent == null) {
					userAgent = "";
				}
				isFromMobile = isMobileDevice(userAgent);
				if (isFromMobile) {
					session.setAttribute("userAgent", "mobile");
				} else {
					session.setAttribute("userAgent", "pc");
				}
			} catch (Exception e) {
			}
		} else {
			isFromMobile = session.getAttribute("userAgent").equals("mobile");
		}

		return isFromMobile;
	}
	
	public static boolean isMobileDevice(String userAgent) {
		if (null == userAgent) {
			userAgent = "";
		}
		Matcher matcherPhone = phonePat.matcher(userAgent);
		Matcher matcherTable = tablePat.matcher(userAgent);
		if (matcherPhone.find() || matcherTable.find()) {
			return true;
		} else {
			return false;
		}
	}
}
