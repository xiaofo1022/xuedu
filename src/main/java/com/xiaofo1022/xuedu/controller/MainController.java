package com.xiaofo1022.xuedu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
import com.xiaofo1022.xuedu.dao.SupplementAnswerDao;
import com.xiaofo1022.xuedu.model.Answer;
import com.xiaofo1022.xuedu.model.FansAnswer;
import com.xiaofo1022.xuedu.model.FansContribute;
import com.xiaofo1022.xuedu.model.Question;
import com.xiaofo1022.xuedu.model.SupplementAnswer;
import com.xiaofo1022.xuedu.model.User;

@Controller("mainController")
@Transactional
public class MainController {
	@Autowired
	private QuestionDao questionDao;
	@Autowired
	private LoginDao loginDao;
	@Autowired
	private AnswerDao answerDao;
	@Autowired
	private FansAnswerDao fansAnswerDao;
	@Autowired
	private SupplementAnswerDao supplementAnswerDao;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String index(HttpServletRequest request, ModelMap modelMap) {
		modelMap.addAttribute("answerList", answerDao.getLatestAnswerList());
		modelMap.addAttribute("hotestAnswerList", answerDao.getHotestAnswerList());
		modelMap.addAttribute("shuffleAnswerList", answerDao.getShuffleAnswerList());
		modelMap.addAttribute("fansContributeList", fansAnswerDao.getFansContributeList());
		modelMap.addAttribute("happiestAnswerList", answerDao.getHappiestAnswerList());
		if (RequestChecker.isFromMobile(request)) {
			return "xuedumobile";
		} else {
			return "xueduboot";
		}
	}
	
	@RequestMapping(value="/backdoor", method=RequestMethod.GET)
	public String login(HttpServletRequest request, ModelMap modelMap) {
		return "loginboot";
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
		return "backgroundboot";
	}
	
	@RequestMapping(value="/fanscontributelist", method=RequestMethod.GET)
	@ResponseBody
	public List<FansContribute> fanscontributelist(HttpServletRequest request, ModelMap modelMap) {
		return fansAnswerDao.getFansContributeList();
	}
	
	@RequestMapping(value="/fansanswerlist", method=RequestMethod.GET)
	@ResponseBody
	public List<FansAnswer> fansanswerlist(HttpServletRequest request, ModelMap modelMap) {
		return fansAnswerDao.getFansAnswerList();
	}
	
	@RequestMapping(value="/questionlist", method=RequestMethod.GET)
	@ResponseBody
	public List<Question> questionlist(HttpServletRequest request, ModelMap modelMap) {
		return questionDao.getQuestionList();
	}
	
	@RequestMapping(value="/answerlist", method=RequestMethod.GET)
	@ResponseBody
	public List<Answer> answerlist(HttpServletRequest request, ModelMap modelMap) {
		return answerDao.getHotestAnswerList();
	}
	
	@RequestMapping(value="/answerlistByFans", method=RequestMethod.POST)
	@ResponseBody
	public List<Answer> answerlistByFans(@RequestBody FansContribute fansContribute, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		return answerDao.getAnswerListByFansName(fansContribute.getFansName());
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
	
	@RequestMapping(value="/addanswer", method=RequestMethod.POST)
	@ResponseBody
	public String addanswer(@RequestBody Answer answer, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		answerDao.insertAnswer(answer);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/addSearchAnswer/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String addSearchAnswer(@RequestBody Answer answer, BindingResult bindingResult, @PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.insertAnswer(answer);
		questionDao.giveAnAnswer(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/approveFansAnswer/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String approveFansAnswer(@RequestBody Answer answer, BindingResult bindingResult, @PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.insertAnswer(answer);
		fansAnswerDao.approveFansAnswer(id);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/updateAnswer", method=RequestMethod.POST)
	@ResponseBody
	public String updateAnswer(@RequestBody Answer answer, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		answerDao.updateAnswer(answer);
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
	
	@RequestMapping(value="/increasehappy/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String increasehappy(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		answerDao.increaseHappyCount(id);
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
	
	@RequestMapping(value="/addsupplementanswer", method=RequestMethod.POST)
	@ResponseBody
	public String addsupplementanswer(@RequestBody SupplementAnswer supplementAnswer, BindingResult bindingResult, HttpServletRequest request, ModelMap modelMap) {
		supplementAnswerDao.insertIntoSupplementAnswer(supplementAnswer);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/suppleAnswerlist/{answerId}", method=RequestMethod.GET)
	@ResponseBody
	public List<SupplementAnswer> suppleAnswerlist(@PathVariable int answerId, HttpServletRequest request, ModelMap modelMap) {
		return supplementAnswerDao.getSuppleAnswerList(answerId);
	}
	
	@RequestMapping(value="/unapprovedSuppleAnswerlist", method=RequestMethod.GET)
	@ResponseBody
	public List<SupplementAnswer> unapprovedSuppleAnswerlist(HttpServletRequest request, ModelMap modelMap) {
		return supplementAnswerDao.getUnapprovedAnswerList();
	}
	
	@RequestMapping(value="/approveSupplement/{id}/{answerId}", method=RequestMethod.POST)
	@ResponseBody
	public String approveSupplement(@PathVariable int id, @PathVariable int answerId, HttpServletRequest request, ModelMap modelMap) {
		supplementAnswerDao.approveSupplement(id);
		answerDao.ding(answerId);
		return CommonConst.SUCCESS;
	}
	
	@RequestMapping(value="/denialSupplement/{id}", method=RequestMethod.POST)
	@ResponseBody
	public String denialSupplement(@PathVariable int id, HttpServletRequest request, ModelMap modelMap) {
		supplementAnswerDao.denialSupplement(id);
		return CommonConst.SUCCESS;
	}
}
