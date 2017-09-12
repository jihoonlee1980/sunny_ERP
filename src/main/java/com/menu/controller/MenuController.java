package com.menu.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.erp.util.MailSender;
import com.erp.util.UploadFileWriter;
import com.menu.model.CommentDAO;
import com.menu.model.CommentDTO;
import com.menu.model.ErpBoardDAO;
import com.menu.model.ErpBoardDTO;
import com.menu.model.MemberDAO;
import com.menu.model.MemberDTO;

@Controller
public class MenuController {
	@Autowired
	ErpBoardDAO erpBoardDAO;
	@Autowired
	MemberDAO memberDAO;
	@Autowired
	CommentDAO commentDAO;
	@Autowired
	JavaMailSenderImpl mailSender;

	final String path = "/home/hosting_users/sunnyfactory21/tomcat/webapps/ROOT/resources";
	//final String path = "C:\\Users\\jihyun\\git\\sunny_ERP\\src\\main\\webapp\\resources";

	final int ERP_EVENT = 1;
	final int ERP_NOTICE = 2;

	@RequestMapping(value = "/ceo")
	public String ceoSunny() {
		return "/1/menu/ceo_sunny";
	}

	@RequestMapping(value = "/company")
	public String company() {
		return "/1/menu/company";
	}

	@RequestMapping(value = "/product")
	public String product() {
		return "/1/menu/product";
	}

	@RequestMapping(value = "/event")
	public ModelAndView event(@RequestParam(defaultValue = "1") int page) {
		int perPage = 5;
		int totalCount = erpBoardDAO.getCount(ERP_EVENT);
		int perBlock = 5;
		int totalPage = totalCount % perPage > 0 ? totalCount / perPage + 1 : totalCount / perPage;
		int startPage;
		int endPage;
		ModelAndView modeAndView = new ModelAndView();
		List<ErpBoardDTO> erpBoardDTOs = erpBoardDAO.getList((page - 1) * perPage, perPage, ERP_EVENT);

		startPage = (page - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;

		modeAndView.addObject("currentPage", page);
		modeAndView.addObject("totalCount", totalCount);
		modeAndView.addObject("totalPage", totalPage);
		modeAndView.addObject("startPage", startPage);
		modeAndView.addObject("endPage", endPage);
		modeAndView.addObject("eventList", erpBoardDTOs);
		modeAndView.setViewName("/1/menu/event");

		return modeAndView;
	}

	@RequestMapping(value = "/event/insert", method = RequestMethod.POST)
	public String evnetInsert(ErpBoardDTO erpBoardDTO, HttpServletRequest request) {
		MultipartFile attacehd_file = erpBoardDTO.getAttached_file();
		erpBoardDTO.setDelim(ERP_EVENT);

		if (!"".equals(attacehd_file.getOriginalFilename())) {
			String originFileName = attacehd_file.getOriginalFilename();
			String extension = originFileName.substring(originFileName.lastIndexOf("."));
			String eventPath = path + "/img/event";
			String saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000
					+ extension;

			while (erpBoardDAO.checkEventFilename(saveFileName) > 0) {
				saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000;
			}

			erpBoardDTO.setOrigin_filename(originFileName);
			erpBoardDTO.setSaved_filename(saveFileName);

			UploadFileWriter uploadFileWriter = new UploadFileWriter();
			uploadFileWriter.writeFile(attacehd_file, eventPath, saveFileName);
		}

		erpBoardDAO.insert(erpBoardDTO);

		return "redirect:/event";
	}

	@RequestMapping(value = "/event/content")
	public ModelAndView evnetContent(@RequestParam(value = "num", required = true) int num, HttpSession session) {
		String loginID = (String) session.getAttribute("loggedInID");
		ErpBoardDTO erpBoardDTO = erpBoardDAO.get(num);
		List<CommentDTO> commentDTOs = commentDAO.commentList(num);
		List<String> profile_files = new ArrayList<String>();

		for (CommentDTO commentDTO : commentDTOs) {
			profile_files.add(memberDAO.get(commentDTO.getWriter()).getSaved_filename());
		}

		if (!erpBoardDTO.getWriter().equals(loginID)) {
			erpBoardDAO.updateReadCount(num);
			erpBoardDTO = erpBoardDAO.get(num);
		}

		ModelAndView modelAndView = new ModelAndView();

		if (loginID != null) {
			modelAndView.addObject("loggedInProfile", memberDAO.get(loginID).getSaved_filename());
		}

		modelAndView.addObject("profile_file", profile_files);
		modelAndView.addObject("eventContent", erpBoardDTO);
		modelAndView.addObject("commentList", commentDTOs);
		modelAndView.setViewName("/1/menu/eventContent");

		return modelAndView;
	}

	@RequestMapping(value = "/comment/insert")
	public String insertComment(CommentDTO commentDTO, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "type", defaultValue = "event") String type) {
		erpBoardDAO.updateCommentCount(commentDTO.getBoard_num(), 1);
		commentDAO.insertComment(commentDTO);

		return "redirect:/" + type + "/content?num=" + commentDTO.getBoard_num() + "&page=" + page;
	}

	@RequestMapping(value = "/reply/insert")
	public String inserReply(CommentDTO commentDTO, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "type", defaultValue = "event") String type) {
		commentDAO.updateReplyCount(commentDTO.getComment_num(), 1);
		commentDAO.insertReply(commentDTO);

		return "redirect:/" + type + "/content?num=" + commentDTO.getBoard_num() + "&page=" + page;
	}

	@RequestMapping(value = "/comment/update")
	public String updateComment(CommentDTO commentDTO, int page, String type) {
		commentDAO.update(commentDTO);

		return "redirect:/" + type + "/content?num=" + commentDTO.getBoard_num() + "&page=" + page;
	}

	@RequestMapping(value = "/comment/delete")
	public String deleteComment(int num, int board_num, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "type", defaultValue = "event") String type) {
		erpBoardDAO.updateCommentCount(board_num, -1);
		commentDAO.deleteComment(num);
		return "redirect:/" + type + "/content?num=" + board_num + "&page=" + page;
	}

	@RequestMapping(value = "/reply/delete")
	public String deleteReply(int num, int board_num, int comment_num,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "type", defaultValue = "event") String type) {
		commentDAO.updateReplyCount(comment_num, -1);
		commentDAO.deleteReply(num);
		return "redirect:/" + type + "/content?num=" + board_num + "&page=" + page;
	}

	@RequestMapping(value = "/reply/list")
	public @ResponseBody Map<String, Object> replyList(
			@RequestParam(value = "comment_num", required = true) int comment_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<CommentDTO> commentDTOs = commentDAO.replyList(comment_num);
		List<String> profile_files = new ArrayList<String>();

		for (CommentDTO commentDTO : commentDTOs) {
			profile_files.add(memberDAO.get(commentDTO.getWriter()).getSaved_filename());
		}

		map.put("profile_files", profile_files);
		map.put("commentDTO", commentDTOs);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/event/update/preproc")
	public @ResponseBody Map<String, Object> evnetAjax(@RequestParam(value = "num", required = true) int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		ErpBoardDTO erpBoardDTO = erpBoardDAO.get(num);

		map.put("eventContent", erpBoardDTO);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/event/update")
	public String eventUpdate(ErpBoardDTO erpBoardDTO, @RequestParam(value = "page", defaultValue = "1") int page) {
		if (erpBoardDTO.getAttached_file().getOriginalFilename().equals("")) {
			erpBoardDTO.setOrigin_filename(erpBoardDAO.get(erpBoardDTO.getNum()).getOrigin_filename());
			erpBoardDTO.setSaved_filename(erpBoardDAO.get(erpBoardDTO.getNum()).getSaved_filename());
		} else {
			MultipartFile attacehd_file = erpBoardDTO.getAttached_file();

			if (!"".equals(attacehd_file.getOriginalFilename())) {
				String originFileName = attacehd_file.getOriginalFilename();
				String extension = originFileName.substring(originFileName.lastIndexOf("."));
				String eventPath = path + "img/event";
				String saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000
						+ extension;

				while (erpBoardDAO.checkEventFilename(saveFileName) > 0) {
					saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000;
				}

				erpBoardDTO.setOrigin_filename(originFileName);
				erpBoardDTO.setSaved_filename(saveFileName);

				UploadFileWriter uploadFileWriter = new UploadFileWriter();
				uploadFileWriter.writeFile(attacehd_file, eventPath, saveFileName);
			}
		}
		erpBoardDAO.updateEvent(erpBoardDTO);

		return "redirect:/event/content?num=" + erpBoardDTO.getNum() + "&page=" + page;
	}

	@RequestMapping(value = "/event/delete")
	public String eventDelete(@RequestParam(value = "num", required = true) int num,
			@RequestParam(value = "page", defaultValue = "1") int page) {
		String savedFileName = erpBoardDAO.get(num).getSaved_filename();
		File file = new File(path + "/img/event" + savedFileName);

		file.delete();
		erpBoardDAO.delete(num);

		return "redirect:/event?page=" + page;
	}

	@RequestMapping(value = "/event/download")
	public void eventDownload(@RequestParam(value = "num", required = true) int num, HttpServletResponse response)
			throws Exception {
		ErpBoardDTO erpBoardDTO = erpBoardDAO.get(num);
		String saved_fileName = erpBoardDTO.getSaved_filename();

		byte fileByte[] = FileUtils.readFileToByteArray(new File(path + "/img/event/" + saved_fileName));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(saved_fileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);

		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@RequestMapping(value = "/notice")
	public ModelAndView notice(@RequestParam(defaultValue = "1") int page) {
		int perPage = 5;
		int totalCount = erpBoardDAO.getCount(ERP_NOTICE);
		int perBlock = 5;
		int totalPage = totalCount % perPage > 0 ? totalCount / perPage + 1 : totalCount / perPage;
		int startPage;
		int endPage;
		ModelAndView modelAndView = new ModelAndView();
		List<ErpBoardDTO> erpBoardDTOs = erpBoardDAO.getList((page - 1) * perPage, perPage, ERP_NOTICE);

		startPage = (page - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;

		modelAndView.addObject("currentPage", page);
		modelAndView.addObject("totalCount", totalCount);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.addObject("noticeList", erpBoardDTOs);
		modelAndView.setViewName("/1/menu/notice");

		return modelAndView;
	}

	@RequestMapping(value = "/notice/insert", method = RequestMethod.POST)
	public String noticeInsert(ErpBoardDTO erpBoardDTO) {
		erpBoardDTO.setDelim(ERP_NOTICE);
		erpBoardDAO.insert(erpBoardDTO);

		return "redirect:/notice";
	}

	@RequestMapping(value = "/notice/content")
	public ModelAndView noticeContent(@RequestParam(value = "num", required = true) int num, HttpSession session) {
		String loginID = (String) session.getAttribute("loggedInID");
		ErpBoardDTO erpBoardDTO = erpBoardDAO.get(num);
		List<CommentDTO> commentDTOs = commentDAO.commentList(num);
		List<String> profile_files = new ArrayList<String>();

		for (CommentDTO commentDTO : commentDTOs) {
			profile_files.add(memberDAO.get(commentDTO.getWriter()).getSaved_filename());
		}

		if (!erpBoardDTO.getWriter().equals(loginID)) {
			erpBoardDAO.updateReadCount(num);
			erpBoardDTO = erpBoardDAO.get(num);
		}

		ModelAndView modelAndView = new ModelAndView();

		if (loginID != null) {
			modelAndView.addObject("loggedInProfile", memberDAO.get(loginID).getSaved_filename());
		}

		modelAndView.addObject("profile_file", profile_files);
		modelAndView.addObject("noticeContent", erpBoardDTO);
		modelAndView.addObject("commentList", commentDTOs);
		modelAndView.setViewName("/1/menu/noticeContent");

		return modelAndView;
	}

	@RequestMapping(value = "/notice/update/preproc")
	public @ResponseBody Map<String, Object> noticeAjax(@RequestParam(value = "num", required = true) int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		ErpBoardDTO erpBoardDTO = erpBoardDAO.get(num);

		map.put("noticeContent", erpBoardDTO);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/notice/update")
	public String noticeUpdate(ErpBoardDTO erpBoardDTO, @RequestParam(value = "page", defaultValue = "1") int page) {
		erpBoardDAO.updateNotice(erpBoardDTO);

		return "redirect:/notice/content?num=" + erpBoardDTO.getNum() + "&page=" + page;
	}

	@RequestMapping(value = "/notice/delete")
	public String noticeDelete(@RequestParam(value = "num", required = true) int num,
			@RequestParam(value = "page", defaultValue = "1") int page) {
		erpBoardDAO.delete(num);

		return "redirect:/notice?page=" + page;
	}

	@RequestMapping(value = "/erp")
	public String erpMain() {
		return "/2/erp/main";
	}

	@RequestMapping(value = "/join")
	public String join() {
		return "/1/menu/join";
	}

	@RequestMapping(value = "/join/checkID")
	public @ResponseBody Map<String, Object> checkID(@RequestParam(value = "id", required = true) String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isValid = true;

		if (memberDAO.checkMemberID(id) > 0)
			isValid = false;

		map.put("isValid", isValid);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/checkCK", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkCK(
			@RequestParam(value = "certification_key", required = true) String certification_key) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isValid = false;

		if (memberDAO.checkCertification_key(certification_key) > 0)
			isValid = true;

		map.put("isValid", isValid);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/join/proc", method = RequestMethod.POST)
	public String joinProc(MemberDTO memberDTO,
			@RequestParam(value = "certification_key", required = false) String certification_key) {
		MultipartFile profile_image_file = memberDTO.getProfile_image_file();

		if (!"".equals(profile_image_file.getOriginalFilename())) {
			String originFileName = profile_image_file.getOriginalFilename();
			String extension = originFileName.substring(originFileName.lastIndexOf("."));
			String profilePath = path + "/profile";
			String savedFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000
					+ extension;

			while (memberDAO.checkMemberFilename(savedFileName) > 0) {
				savedFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000;
			}

			memberDTO.setOrigin_filename(originFileName);
			memberDTO.setSaved_filename(savedFileName);

			UploadFileWriter uploadFileWriter = new UploadFileWriter();
			uploadFileWriter.writeFile(profile_image_file, profilePath, savedFileName);
		}
		memberDTO.setPass(memberDTO.getPass().toLowerCase());

		memberDAO.insert(memberDTO);

		return "redirect:/login";
	}

	@RequestMapping(value = "/member/delete", params = "num", method = RequestMethod.GET)
	public String deleteMember(@RequestParam(value = "num", required = true) int num,
			@RequestParam(value = "id", required = true) String id, HttpSession session) {
		List<HashMap<String, Object>> list1 = commentDAO.getCommentCountOnDeleteMember(id);
		List<HashMap<String, Object>> list2 = commentDAO.getReplyCountOnDeleteMember(id);

		for (HashMap<String, Object> hashMap : list1) {
			Integer board_num = (Integer) hashMap.get("board_num");
			Long countValue = (Long) hashMap.get("count");
			erpBoardDAO.updateCommentCount(board_num, (-1) * countValue.intValue());
		}

		for (HashMap<String, Object> hashMap : list2) {
			Integer comment_num = (Integer) hashMap.get("comment_num");
			Long countValue = (Long) hashMap.get("count");
			commentDAO.updateReplyCount(comment_num.intValue(), (-1) * countValue.intValue());
		}

		String profilePath = path + "/profile";
		File file = new File(profilePath + "/" + memberDAO.get(id).getSaved_filename());

		if (file.exists())
			file.delete();

		session.removeAttribute("isLogin");
		session.removeAttribute("loggedInID");

		memberDAO.deleteMember(num, id);

		return "redirect:/";
	}

	@RequestMapping(value = "/members/delete", params = "nums", method = RequestMethod.GET)
	public String deleteMembers(@RequestParam(value = "nums", required = true) String nums) {
		String[] num_array = nums.split(",");
		String profilePath = path + "/profile";

		for (int i = 0; i < num_array.length; i++) {
			int num = Integer.parseInt(num_array[i]);
			String id = memberDAO.get(num).getId();
			System.out.println(num);
			System.out.println(id);
			List<HashMap<String, Object>> list1 = commentDAO.getCommentCountOnDeleteMember(id);
			List<HashMap<String, Object>> list2 = commentDAO.getReplyCountOnDeleteMember(id);

			for (HashMap<String, Object> hashMap : list1) {
				Integer board_num = (Integer) hashMap.get("board_num");
				Long countValue = (Long) hashMap.get("count");
				erpBoardDAO.updateCommentCount(board_num, (-1) * countValue.intValue());
			}

			for (HashMap<String, Object> hashMap : list2) {
				Integer comment_num = (Integer) hashMap.get("comment_num");
				Long countValue = (Long) hashMap.get("count");
				commentDAO.updateReplyCount(comment_num.intValue(), (-1) * countValue.intValue());
			}

			File file = new File(profilePath + "/" + memberDAO.get(id).getSaved_filename());

			if (file.exists())
				file.delete();

			memberDAO.deleteMember(num, id);
		}
		return "redirect:/";
	}

	@RequestMapping(value = "/member/search", method = RequestMethod.GET)
	public ModelAndView searchMembers(@RequestParam(value = "search_type", required = true) String search_type,
			@RequestParam(value = "keyword", required = true) String keyword,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "sort", defaultValue = "date") String sort, HttpSession session) {
		String id = (String) session.getAttribute("loggedInID");
		int perPage = 15;
		int totalCount = memberDAO.getCount(search_type, keyword);
		int perBlock = 5;
		int totalPage = totalCount % perPage > 0 ? totalCount / perPage + 1 : totalCount / perPage;
		int startPage;
		int endPage;
		List<MemberDTO> memberDTOs = memberDAO.searchList((page - 1) * perPage, perPage, sort, search_type, keyword);
		ModelAndView modelAndView = new ModelAndView();

		startPage = (page - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;

		MemberDTO memberDTO = memberDAO.get(id);

		modelAndView.addObject("loggedInAuthority", memberDTO.getAuthority());
		modelAndView.addObject("currentPage", page);
		modelAndView.addObject("totalCount", totalCount);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.addObject("memberList", memberDTOs);
		modelAndView.setViewName("/1/menu/admin");
		return modelAndView;
	}

	@RequestMapping(value = "/login")
	public String loginForm(HttpSession session) {
		String returnURL = "/1/menu/login";
		if (session.getAttribute("isLogin") != null)
			returnURL = "redirect:/";
		return returnURL;
	}

	@RequestMapping(value = "/login/proc", method = RequestMethod.POST)
	public String loginProc(HttpSession session, MemberDTO loginInfo, RedirectAttributes redirectAttributes,
			@RequestParam(value = "saveID", required = false) String saveID) {
		String returnURL = "";
		// 0일때 성공, 1일때 실패(비밀번호 틀림), 2일때 아이디도 없음, 3일떄 아이디 lock상태
		int loginResult = 0;

		loginInfo.setPass(loginInfo.getPass().toLowerCase());

		if (session.getAttribute("isLogin") != null) {
			session.removeAttribute("isLogin");

			if (!"YES".equals(session.getAttribute("isSave"))) {
				session.removeAttribute("loggedInID");
			}
		}

		MemberDTO memberDTO = memberDAO.login(loginInfo);

		if (memberDTO != null) {
			if (memberDAO.get(loginInfo.getId()).getIs_account_lock().equals("Y")) {
				returnURL = "redirect:/login";
				loginResult = 3;
			} else {
				session.setAttribute("isLogin", "YES");
				session.setAttribute("loggedInID", memberDTO.getId());

				MemberDTO memberDTO2 = memberDAO.get(memberDTO.getId());

				if (memberDTO2.getAuthority() >= 5)
					session.setAttribute("isAdmin", "YES");

				if ("YES".equals(saveID)) {
					session.setAttribute("isSave", saveID);
				} else {
					session.removeAttribute("isSave");
				}

				memberDAO.initLoginFailCount(memberDTO.getId());
				returnURL = "redirect:/";
			}
		} else {
			if (memberDAO.checkMemberID(loginInfo.getId()) == 1) {
				if (memberDAO.get(loginInfo.getId()).getIs_account_lock().equals("Y")) {
					returnURL = "redirect:/login";
					loginResult = 3;
				} else {
					loginResult = 1;

					if (memberDAO.get(loginInfo.getId()).getLogin_fail_count() < 5) {
						memberDAO.increaseLoginFailCount(loginInfo.getId());
						redirectAttributes.addFlashAttribute("loginID", loginInfo.getId());
						redirectAttributes.addFlashAttribute("failCount",
								memberDAO.get(loginInfo.getId()).getLogin_fail_count());
					}

					if (memberDAO.get(loginInfo.getId()).getLogin_fail_count() == 5) {
						memberDAO.alterAccountLock(loginInfo.getId(), "Y");
						loginResult = 3;
					}
				}
			} else {
				loginResult = 2;
			}

			returnURL = "redirect:/login";
		}

		redirectAttributes.addFlashAttribute("result", loginResult);

		return returnURL;
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		// 세션 전체를 날려버림
		// session.invalidate();
		session.removeAttribute("isLogin");

		if (!"YES".equals(session.getAttribute("isSave"))) {
			session.removeAttribute("loggedInID");
		}

		return "redirect:/";
	}

	@RequestMapping(value = "/mypage")
	public ModelAndView myPage(HttpSession session) {
		MemberDTO memberDTO = memberDAO.get((String) session.getAttribute("loggedInID"));
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("memberDTO", memberDTO);
		modelAndView.setViewName("/1/menu/mypage");

		return modelAndView;
	}

	@RequestMapping(value = "/profile/update", method = RequestMethod.POST)
	public ModelAndView profileUpdate(MemberDTO memberDTO) {
		MultipartFile profile_image_file = memberDTO.getProfile_image_file();

		if (!"".equals(profile_image_file.getOriginalFilename())) {
			String profilePath = path + "/profile";
			File file = new File(profilePath + "/" + memberDAO.get(memberDTO.getNum()).getSaved_filename());

			if (file != null)
				file.delete();

			String originFileName = profile_image_file.getOriginalFilename();
			String extension = originFileName.substring(originFileName.lastIndexOf("."));
			String savedFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000
					+ extension;

			while (memberDAO.checkMemberFilename(savedFileName) > 0) {
				savedFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000;
			}

			memberDTO.setOrigin_filename(originFileName);
			memberDTO.setSaved_filename(savedFileName);

			UploadFileWriter uploadFileWriter = new UploadFileWriter();
			uploadFileWriter.writeFile(profile_image_file, profilePath, savedFileName);
		} else {
			memberDTO.setSaved_filename(memberDAO.get(memberDTO.getNum()).getSaved_filename());
			memberDTO.setOrigin_filename(memberDAO.get(memberDTO.getNum()).getOrigin_filename());
		}

		ModelAndView modelAndView = new ModelAndView();

		memberDTO = memberDAO.update(memberDTO, "profile");
		modelAndView.addObject("memberDTO", memberDTO);
		modelAndView.setViewName("redirect:/mypage");

		return modelAndView;
	}

	@RequestMapping(value = "/call/update", method = RequestMethod.POST)
	public ModelAndView callUpdate(MemberDTO memberDTO) {
		ModelAndView modelAndView = new ModelAndView();

		memberDTO = memberDAO.update(memberDTO, "call");
		modelAndView.addObject("memberDTO", memberDTO);
		modelAndView.setViewName("redirect:/mypage");

		return modelAndView;
	}

	@RequestMapping(value = "/pass/update", method = RequestMethod.POST)
	public ModelAndView passUpdate(MemberDTO memberDTO, HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();

		session.removeAttribute("isLogin");

		if (!"YES".equals(session.getAttribute("isSave"))) {
			session.removeAttribute("loggedInID");
		}

		memberDTO.setPass(memberDTO.getPass().toLowerCase());

		memberDTO = memberDAO.update(memberDTO, "pass");
		modelAndView.addObject("memberDTO", memberDTO);
		modelAndView.setViewName("redirect:/mypage");

		return modelAndView;
	}

	@RequestMapping(value = "/lock/update", method = RequestMethod.GET)
	public String lockUpdate(MemberDTO memberDTO, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "sort", defaultValue = "date") String sort) {
		memberDAO.update(memberDTO, "lock");

		return "redirect:/admin?page=" + page + "&sort=" + sort;
	}

	@RequestMapping(value = "/auth/update", method = RequestMethod.GET)
	public String authUpdate(MemberDTO memberDTO, @RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "sort", defaultValue = "date") String sort) {
		memberDAO.update(memberDTO, "auth");

		return "redirect:/admin?page=" + page + "&sort=" + sort;
	}

	@RequestMapping(value = "/checkpass")
	public @ResponseBody Map<String, Object> checkPss(@RequestParam(value = "num", required = true) int num,
			@RequestParam(value = "pass", required = true) String pass) {
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("result", memberDAO.passUpdateCheck(num, pass.toLowerCase()));

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/admin")
	public ModelAndView admin(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "sort", defaultValue = "date") String sort, HttpSession session) {
		String id = (String) session.getAttribute("loggedInID");
		int perPage = 15;
		int totalCount = memberDAO.getCount();
		int perBlock = 5;
		int totalPage = totalCount % perPage > 0 ? totalCount / perPage + 1 : totalCount / perPage;
		int startPage;
		int endPage;
		List<MemberDTO> memberDTOs = memberDAO.getList((page - 1) * perPage, perPage, sort);
		ModelAndView modelAndView = new ModelAndView();

		startPage = (page - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;

		MemberDTO memberDTO = memberDAO.get(id);

		modelAndView.addObject("loggedInAuthority", memberDTO.getAuthority());
		modelAndView.addObject("currentPage", page);
		modelAndView.addObject("totalCount", totalCount);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.addObject("memberList", memberDTOs);
		modelAndView.setViewName("/1/menu/admin");
		return modelAndView;
	}

	@RequestMapping(value = "/sendmail")
	public @ResponseBody Map<String, Object> sendMail(@RequestParam(value = "id", required = true) String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isValid = true;

		if (memberDAO.checkMemberID(id) > 0) {
			isValid = false;

			MemberDTO memberDTO = memberDAO.get(id);
			MailSender mailController = new MailSender();
			String receiver = memberDTO.getEmail();
			String subject = "[SunnyFactory]" + id + "님 비밀번호 찾기 메일입니다.";
			String pass = UUID.randomUUID().toString().split("-")[0];
			String content = "새로운 비밀번호를 발급해 드렸습니다.\n\n새로운 비밀번호는 " + pass + " 입니다.\n\n로그인후 비밀번호를 다시 변경해주세요.";

			memberDTO.setPass(pass);
			memberDAO.update(memberDTO, "pass");

			map.put("email", memberDTO.getEmail());

			try {
				mailController.sendEmail(mailSender, subject, content, receiver);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				isValid = true;
				e.printStackTrace();
			}
		}
		map.put("isValid", isValid);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/certifi/update")
	public String updateCertifi(String certification_key) {
		memberDAO.updateCertification_key(certification_key);

		return "redirect:/admin";
	}
}
