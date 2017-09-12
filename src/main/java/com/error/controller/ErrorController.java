package com.error.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {
	@RequestMapping(value = "errors", method = RequestMethod.GET)
    public ModelAndView renderErrorPage(HttpServletRequest httpRequest) {
         
        ModelAndView errorPage = new ModelAndView("errorPage");
        String errorCode = "";
        String errorMsg = "";
        int httpErrorCode = getErrorCode(httpRequest);
 
        switch (httpErrorCode) {
            case 403: {
            	errorCode = "403 Error.";
                errorMsg = "Http Error Code: 403. 접근 금지.";
                break;
            }
            case 404: {
            	errorCode = "404 Error.";
                errorMsg = "Http Error Code: 404. 요청한 리소스가 없음.";
                break;
            }
            case 500: {
            	errorCode = "500 Error.";
                errorMsg = "Http Error Code: 500. 요청 처리중 에러 발생.";
                break;
            }
            case 503: {
            	errorCode = "503 Error.";
                errorMsg = "Http Error Code: 500. 일시적인 요청처리 불가.";
                break;
            }
        }
        
        errorPage.addObject("errorCode", errorCode);
        errorPage.addObject("errorMsg", errorMsg);        
        return errorPage;
    }
     
    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
          .getAttribute("javax.servlet.error.status_code");
    }
}
