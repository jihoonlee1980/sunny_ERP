package com.sunnyerp.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/")
	public String main() {
		return "tempLayout";
	}
	
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
	public String event() {
		return "/1/menu/event";
	}
	
	@RequestMapping(value = "/notice")
	public String notice() {
		return "/1/menu/notice";
	}
	
	@RequestMapping(value = "/erp/")
	public String erpMain() {
		return "/2/erp/main";
	}
	
}
