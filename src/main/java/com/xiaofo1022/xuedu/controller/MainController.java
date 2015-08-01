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
import com.xiaofo1022.xuedu.core.RequestChecker;
import com.xiaofo1022.xuedu.dao.AnswerDao;
import com.xiaofo1022.xuedu.dao.FansAnswerDao;
import com.xiaofo1022.xuedu.dao.LoginDao;
import com.xiaofo1022.xuedu.dao.QuestionDao;
import com.xiaofo1022.xuedu.model.Answer;
import com.xiaofo1022.xuedu.model.FansAnswer;
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
	@Autowired
	private FansAnswerDao fansAnswerDao;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap modelMap) {
		modelMap.addAttribute("answerList", answerDao.getLatestAnswerList());
		modelMap.addAttribute("hotestAnswerList", answerDao.getHotestAnswerList());
		modelMap.addAttribute("shuffleAnswerList", answerDao.getShuffleAnswerList());
		if (RequestChecker.isFromMobile(request)) {
			return "xuedumobile";
		} else {
			return "xueduboot";
		}
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
		modelMap.addAttribute("answerList", answerDao.getLatestAnswerList());
		modelMap.addAttribute("questionList", questionDao.getQuestionList());
		modelMap.addAttribute("fansAnswerList", fansAnswerDao.getFansAnswerList());
		return "background";
	}
	
	@RequestMapping(value="/answerlist", method=RequestMethod.GET)
	@ResponseBody
	public List<Answer> answerlist(HttpServletRequest request, ModelMap modelMap) {
		return answerDao.getHotestAnswerList();
	}
	
	@RequestMapping(value="/lastestAnswerlist", method=RequestMethod.GET)
	@ResponseBody
	public List<Answer> lastestAnswerlist(HttpServletRequest request, ModelMap modelMap) {
		return answerDao.getLatestAnswerList();
	}
	
	@RequestMapping(value="/question", method=RequestMethod.POST)
	@ResponseBody
	public String question(@RequestBody Question question, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		questionDao.insertQuestion(question);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/addanswer/{questionId}/{oilId}", method=RequestMethod.POST)
	@ResponseBody
	public String addanswer(@RequestBody Answer answer, BindingResult bindingResult, @PathVariable int questionId, @PathVariable int oilId, HttpServletRequest request, ModelMap modelMap) {
		int answerId = 0;
		if (answer.getId() == 0) {
			answerId = answerDao.insertAnswer(answer);
		} else {
			answerId = answer.getId();
			answerDao.updateAnswer(answer);
		}
		if (questionId != 0) {
			questionDao.giveAnAnswer(questionId);
		}
		if (oilId != 0) {
			fansAnswerDao.approveFansAnswer(oilId);
		}
		return String.valueOf(answerId);
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
	
	@RequestMapping(value="/ding/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String ding(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.ding(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/removeeaster/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String removeeaster(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.removeEaster(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/addeaster/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String addeaster(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.addEaster(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/ignorequestion/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String ignorequestion(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		questionDao.ignoreQuestion(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/increasesearch/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String increasesearch(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.increaseSearchCount(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/addfansanswer", method=RequestMethod.POST)
	@ResponseBody
	public String addfansanswer(@RequestBody FansAnswer fansAnswer, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		fansAnswerDao.insertFansAnswer(fansAnswer);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/getfansanswer/{id}", method=RequestMethod.GET)
	@ResponseBody
	public FansAnswer getfansanswer(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		return fansAnswerDao.getFansAnswerDetail(id);
	}
	
	@RequestMapping(value="/deletefansanswer/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String deletefansanswer(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		fansAnswerDao.deleteFansAnswer(id);
		return CommonConst.SUCCESS;
	}
}
