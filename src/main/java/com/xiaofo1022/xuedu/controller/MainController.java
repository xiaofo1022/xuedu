package com.xiaofo1022.xuedu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xiaofo1022.xuedu.common.CommonConst;
import com.xiaofo1022.xuedu.dao.AnswerDao;
import com.xiaofo1022.xuedu.dao.LoginDao;
import com.xiaofo1022.xuedu.dao.QuestionDao;
import com.xiaofo1022.xuedu.model.Answer;
import com.xiaofo1022.xuedu.model.Question;
import com.xiaofo1022.xuedu.model.User;

@Controller("mainController")
public class MainController {
	@Autowired
	private QuestionDao questionDao;
	@Autowired
	private LoginDao loginDao;
	@Autowired
	private AnswerDao answerDao;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap modelMap) {
		return "xuedu";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login(HttpServletRequest request, ModelMap modelMap) {
		return "login";
	}
	
	@RequestMapping(value="/dologin", method=RequestMethod.POST)
	@ResponseBody
	public String dologin(@RequestBody User user, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		if (loginDao.canLogin(user)) {
			request.getSession(true).setAttribute("user", user);
			return CommonConst.SUCCESS;
		}
		return CommonConst.FAILURE;
	}
	
	@RequestMapping(value="/background", method=RequestMethod.GET)
	public String background(HttpServletRequest request, ModelMap modelMap) {
		modelMap.addAttribute("answerList", answerDao.getAnswerList());
		modelMap.addAttribute("questionList", questionDao.getQuestionList());
		return "background";
	}
	
	@RequestMapping(value="/answerlist", method=RequestMethod.GET)
	@ResponseBody
	public List<Answer> answerlist(HttpServletRequest request, ModelMap modelMap) {
		return answerDao.getAnswerList();
	}
	
	@RequestMapping(value="/question", method=RequestMethod.POST)
	@ResponseBody
	public String question(@RequestBody Question question, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		questionDao.insertQuestion(question);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/addanswer/{questionId}", method=RequestMethod.POST)
	@ResponseBody
	public String addanswer(@RequestBody Answer answer, BindingResult bindingResult, @PathVariable Integer questionId, HttpServletRequest request, ModelMap modelMap) {
		if (answer.getId() == 0) {
			answerDao.insertAnswer(answer);
		} else {
			answerDao.updateAnswer(answer);
		}
		if (questionId != 0) {
			questionDao.giveAnAnswer(questionId);
		}
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/answerdetail/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Answer answerdetail(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		return answerDao.getAnswerDetail(id);
	}
	
	@RequestMapping(value="/deleteanswer/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String deleteanswer(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.deleteAnswer(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/ignorequestion/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String ignorequestion(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		questionDao.ignoreQuestion(id);
		return CommonConst.SUCCESS;
	}
}
