package com.menu.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.erp.util.UploadFileWriter;
import com.menu.model.EventBoardDAO;
import com.menu.model.EventBoardDTO;
import com.menu.model.MemberDAO;
import com.menu.model.MemberDTO;
import com.menu.model.NoticeDAO;
import com.menu.model.NoticeDTO;

@Controller
public class MenuController {
	@Autowired
	EventBoardDAO eventBoardDAO;
	@Autowired
	NoticeDAO noticeDAO;
	@Autowired
	MemberDAO memberDAO;

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
		int totalCount = eventBoardDAO.getCount();
		int perBlock = 5;
		int totalPage = totalCount % perPage > 0 ? totalCount / 5 + 1 : totalCount / 5;
		int startPage;
		int endPage;
		ModelAndView modeAndView = new ModelAndView();
		List<EventBoardDTO> eventBoardDTOs = eventBoardDAO.getList((page - 1) * perPage, perPage);

		startPage = (page - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;

		modeAndView.addObject("currentPage", page);
		modeAndView.addObject("totalCount", totalCount);
		modeAndView.addObject("totalPage", totalPage);
		modeAndView.addObject("startPage", startPage);
		modeAndView.addObject("endPage", endPage);
		modeAndView.addObject("eventList", eventBoardDTOs);
		modeAndView.setViewName("/1/menu/event");

		return modeAndView;
	}

	@RequestMapping(value = "/event/insert", method = RequestMethod.POST)
	public String evnetInsert(EventBoardDTO eventBoardDTO) {
		MultipartFile attacehd_file = eventBoardDTO.getAttached_file();

		if (!"".equals(attacehd_file.getOriginalFilename())) {
			String originFileName = attacehd_file.getOriginalFilename();
			String extension = originFileName.substring(originFileName.lastIndexOf("."));
			String eventPath = "C:\\Users\\jihyun\\git\\sunny_ERP\\src\\main\\webapp\\resources\\img\\event";
			// String eventPath =
			// "C:\\workspace\\SunnyERP\\src\\main\\webapp\\resources\\img\\event";
			String saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000
					+ extension;

			while (eventBoardDAO.checkEventFilename(saveFileName) > 0) {
				saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000;
			}

			eventBoardDTO.setOrigin_filename(originFileName);
			eventBoardDTO.setSaved_filename(saveFileName);

			UploadFileWriter uploadFileWriter = new UploadFileWriter();
			uploadFileWriter.writeFile(attacehd_file, eventPath, saveFileName);
		}

		eventBoardDAO.insert(eventBoardDTO);

		return "redirect:/event";
	}

	@RequestMapping(value = "/event/content")
	public ModelAndView evnetContent(@RequestParam(value = "num", required = true) int num, HttpSession session) {
		String loginID = (String) session.getAttribute("login");
		EventBoardDTO eventBoardDTO = eventBoardDAO.get(num);

		if (!eventBoardDTO.getWriter().equals(loginID)) {
			eventBoardDAO.updateReadCount(num);
			eventBoardDTO = eventBoardDAO.get(num);
		}

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("eventContent", eventBoardDTO);
		modelAndView.setViewName("/1/menu/eventContent");

		return modelAndView;
	}

	@RequestMapping(value = "/event/ajax")
	public @ResponseBody Map<String, Object> evnetAjax(@RequestParam(value = "num", required = true) int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		EventBoardDTO eventBoardDTO = eventBoardDAO.get(num);

		map.put("eventContent", eventBoardDTO);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/event/update")
	public String eventUpdate(EventBoardDTO eventBoardDTO, @RequestParam(value = "page", defaultValue = "1") int page) {
		if (eventBoardDTO.getAttached_file().getOriginalFilename().equals("")) {
			eventBoardDTO.setOrigin_filename(eventBoardDAO.get(eventBoardDTO.getNum()).getOrigin_filename());
			eventBoardDTO.setSaved_filename(eventBoardDAO.get(eventBoardDTO.getNum()).getSaved_filename());
		} else {
			MultipartFile attacehd_file = eventBoardDTO.getAttached_file();

			if (!"".equals(attacehd_file.getOriginalFilename())) {
				String originFileName = attacehd_file.getOriginalFilename();
				String extension = originFileName.substring(originFileName.lastIndexOf("."));
				String eventPath = "C:\\Users\\jihyun\\git\\sunny_ERP\\src\\main\\webapp\\resources\\img\\event";
				// String eventPath =
				// "C:\\workspace\\SunnyERP\\src\\main\\webapp\\resources\\img\\event";
				String saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000
						+ extension;

				while (eventBoardDAO.checkEventFilename(saveFileName) > 0) {
					saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000;
				}

				eventBoardDTO.setOrigin_filename(originFileName);
				eventBoardDTO.setSaved_filename(saveFileName);

				UploadFileWriter uploadFileWriter = new UploadFileWriter();
				uploadFileWriter.writeFile(attacehd_file, eventPath, saveFileName);
			}
		}
		eventBoardDAO.update(eventBoardDTO);

		return "redirect:/event/content?num=" + eventBoardDTO.getNum() + "&page=" + page;
	}

	@RequestMapping(value = "/event/delete")
	public String eventDelete(@RequestParam(value = "num", required = true) int num,
			@RequestParam(value = "page", defaultValue = "1") int page) {
		eventBoardDAO.delete(num);

		return "redirect:/event?page=" + page;
	}

	@RequestMapping(value = "/event/download")
	public void eventDownload(@RequestParam(value = "num", required = true) int num, HttpServletResponse response)
			throws Exception {
		EventBoardDTO eventBoardDTO = eventBoardDAO.get(num);
		// String storedFileName = (String) map.get("STORED_FILE_NAME");
		String saved_fileName = eventBoardDTO.getSaved_filename();

		byte fileByte[] = FileUtils.readFileToByteArray(new File(
				"C:\\Users\\jihyun\\git\\sunny_ERP\\src\\main\\webapp\\resources\\img\\event\\" + saved_fileName));
		// byte fileByte[] = FileUtils.readFileToByteArray(
		// new
		// File("C:\\workspace\\SunnyERP\\src\\main\\webapp\\resources\\img\\event"
		// + saved_fileName));

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
		int totalCount = noticeDAO.getCount();
		int perBlock = 5;
		int totalPage = totalCount % perPage > 0 ? totalCount / 5 + 1 : totalCount / 5;
		int startPage;
		int endPage;
		ModelAndView modelAndView = new ModelAndView();
		List<NoticeDTO> noticeDTOs = noticeDAO.getList((page - 1) * perPage, perPage);

		startPage = (page - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;

		modelAndView.addObject("currentPage", page);
		modelAndView.addObject("totalCount", totalCount);
		modelAndView.addObject("totalPage", totalPage);
		modelAndView.addObject("startPage", startPage);
		modelAndView.addObject("endPage", endPage);
		modelAndView.addObject("noticeList", noticeDTOs);
		modelAndView.setViewName("/1/menu/notice");

		return modelAndView;
	}

	@RequestMapping(value = "/notice/insert", method = RequestMethod.POST)
	public String noticeInsert(NoticeDTO noticeDTO) {
		noticeDAO.insert(noticeDTO);

		return "redirect:/notice";
	}

	@RequestMapping(value = "/notice/content")
	public ModelAndView noticeContent(@RequestParam(value = "num", required = true) int num, HttpSession session) {

		String loginID = (String) session.getAttribute("login");
		NoticeDTO noticeDTO = noticeDAO.get(num);

		if (!noticeDTO.getWriter().equals(loginID)) {
			eventBoardDAO.updateReadCount(num);
			noticeDTO = noticeDAO.get(num);
		}

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("noticeContent", noticeDTO);
		modelAndView.setViewName("/1/menu/noticeContent");

		return modelAndView;
	}

	@RequestMapping(value = "/notice/ajax")
	public @ResponseBody Map<String, Object> noticeAjax(@RequestParam(value = "num", required = true) int num) {
		Map<String, Object> map = new HashMap<String, Object>();
		NoticeDTO noticeDTO = noticeDAO.get(num);

		map.put("noticeContent", noticeDTO);

		ModelAndView modelAndView = new ModelAndView("jsonView", map);

		return map;
	}

	@RequestMapping(value = "/notice/update")
	public String noticeUpdate(NoticeDTO noticeDTO, @RequestParam(value = "page", defaultValue = "1") int page) {
		noticeDAO.update(noticeDTO);

		return "redirect:/notice/content?num=" + noticeDTO.getNum() + "&page=" + page;
	}

	@RequestMapping(value = "/notice/delete")
	public String noticeDelete(@RequestParam(value = "num", required = true) int num,
			@RequestParam(value = "page", defaultValue = "1") int page) {
		noticeDAO.delete(num);

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

	@RequestMapping(value = "/join/id")
	public @ResponseBody Map<String, Object> noticeID(@RequestParam(value = "id", required = true) String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean isValid = true;

		if (memberDAO.checkMemberID(id) > 0)
			isValid = false;

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
			String profilePath = "C:\\Users\\jihyun\\git\\sunny_ERP\\src\\main\\webapp\\resources\\profile";
			// String profilePath =
			// "C:\\workspace\\SunnyERP\\src\\main\\webapp\\resources\\img\\profile";
			String saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000
					+ extension;

			while (memberDAO.checkMemberFilename(saveFileName) > 0) {
				saveFileName = UUID.randomUUID().toString().split("-")[0] + System.currentTimeMillis() % 10000000;
			}

			memberDTO.setOrigin_filename(originFileName);
			memberDTO.setProfile_image(saveFileName);

			UploadFileWriter uploadFileWriter = new UploadFileWriter();
			uploadFileWriter.writeFile(profile_image_file, profilePath, saveFileName);
		}

		if (memberDAO.checkCertification_key(certification_key) > 0)
			System.out.println(true);

		memberDAO.insert(memberDTO);

		return "redirect:/login";
	}

	@RequestMapping(value = "/login")
	public String loginForm(HttpSession session) {
		String returnURL = "/1/menu/login";
		if (session.getAttribute("login") != null)
			returnURL = "redirect:/";
		return returnURL;
	}

	@RequestMapping(value = "/login/proc", method = RequestMethod.POST)
	public String loginProc(HttpSession session, MemberDTO loginInfo) {
		String returnURL = "";

		if (session.getAttribute("login") != null) {
			session.removeAttribute("login");
		}

		MemberDTO memberDTO = memberDAO.login(loginInfo);

		if (memberDTO != null) {
			session.setAttribute("login", memberDTO.getId());
			returnURL = "redirect:/";
		} else {
			returnURL = "redirect:/login";
		}
		return returnURL;
	}

	@RequestMapping(value = "logout")
	public String logout(HttpSession session) {
		session.invalidate(); // 세션 전체를 날려버림
		return "redirect:/";
	}
}
