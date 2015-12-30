package com.xiaofo1022.xuedu.filter;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.xiaofo1022.xuedu.dao.UtilDao;
import com.xiaofo1022.xuedu.model.User;

public class LoginFilter implements Filter {
	
	private UtilDao utilDao;
	private Pattern allowedResources;
	private Pattern apkResources;
	private final static String resPattern = ".*((background)|(alllastestAnswerlist)).*";
	private final static String apkPattern = ".*(apk).*";
	
	public void init(FilterConfig arg0) throws ServletException {
		allowedResources = Pattern.compile(resPattern);
		apkResources = Pattern.compile(apkPattern);
	}
	
	public void destroy() {}
	
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		String uri = request.getRequestURI();
		String baseUri = request.getContextPath() + "/";
		User user = null;
		boolean canEnterSystem = false;
		
		if (!uri.equals(baseUri) && allowedResources.matcher(uri).matches()) {
			HttpSession session = request.getSession(false);
			if (session != null) {
				user = (User) session.getAttribute("user");
				if (user != null) {
					canEnterSystem = true;
				}
			}
		} else {
			canEnterSystem = true;
		}
		
		if (!uri.equals(baseUri) && apkResources.matcher(uri).matches()) {
			if (utilDao == null) {
				if (utilDao == null) {
					WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
					utilDao = context.getBean(UtilDao.class);
				}
			}
			utilDao.increaseApkDownloadCount();
		}
		
		if (canEnterSystem) {
			arg2.doFilter(arg0, arg1);
		} else {
			HttpServletResponse response = (HttpServletResponse) arg1;
			response.sendRedirect(response.encodeRedirectURL(baseUri));
			return;
		}
	}
}
