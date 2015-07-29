package com.xiaofo1022.xuedu.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xiaofo1022.xuedu.dao.common.CommonDao;
import com.xiaofo1022.xuedu.model.User;

@Repository
public class LoginDao {
	@Autowired
	private CommonDao commonDao;
	
	public boolean canLogin(User user) {
		User loginUser = commonDao.getFirst(User.class, "SELECT * FROM USERS WHERE USERNAME = ? AND PASSWORD = ?", user.getUsername(), user.getPassword());
		if (loginUser != null) {
			return true;
		}
		return false;
	}
}
