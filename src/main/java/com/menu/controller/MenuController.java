package com.menu.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.menu.model.EventBoardDAO;
import com.menu.model.EventBoardDTO;

@Controller
public class MenuController {
	@Autowired
	EventBoardDAO eventBoardDAO;

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
		ModelAndView mav = new ModelAndView();
		List<EventBoardDTO> eventBoardDTOs = eventBoardDAO.getList((page-1)*perPage, perPage);

		startPage = (page - 1) / perBlock * perBlock + 1;
		endPage = startPage + perBlock - 1;

		if (endPage > totalPage)
			endPage = totalPage;

		mav.addObject("currentPage", page);
		mav.addObject("totalCount", totalCount);
		mav.addObject("totalPage", totalPage);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("eventList", eventBoardDTOs);
		mav.setViewName("/1/menu/event");

		return mav;
	}

	@RequestMapping(value = "/notice")
	public String notice() {
		return "/1/menu/notice";
	}

	@RequestMapping(value = "/erp")
	public String erpMain() {
		return "/2/erp/main";
	}
	
	@RequestMapping(value = "/join")
	public String join() {
		return "/1/menu/join2";
	}
	@RequestMapping(value = "/join/proc")
	public String joinProc(@RequestParam Map<String , Object> map) {
		String name="";
		try {
			name = new String(map.get("name").toString().getBytes("8859_1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		/*System.out.println(map.get("id"));
		System.out.println(name);*/
		
		return "redirect:/event";
	}
}
