package com.springapp.mvc.controller;

import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class ErrorController {

    @RequestMapping(value = "errors", method = RequestMethod.GET)
    public String renderErrorPage(ModelMap model,HttpServletRequest httpRequest) {

        String errorMsg = "";
        int httpErrorCode = getErrorCode(httpRequest);

        switch (httpErrorCode) {
            case 400: {
                errorMsg = "Http Error Code: 400. Bad Request";
                break;
            }
            case 401: {
                errorMsg = "Http Error Code: 401. Unauthorized";
                break;
            }
            case 404: {
                errorMsg = "Ошибка 404. Запрашиваемая страница не найдена";
                break;
            }
            case 500: {
                errorMsg = "Http Error Code: 500. Internal Server Error";
                break;
            }
            default: {
                errorMsg = "Произошла ошибка.";
            }
        }

        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("errorMsg", errorMsg);

        return "404";
    }

    @RequestMapping(value = "/error/", method = RequestMethod.GET)
    public String defaultErrorPage(ModelMap model) {
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("errorMsg", "Произошла ошибка.");
        return "404";
    }

    private int getErrorCode(HttpServletRequest httpRequest) {
        return (Integer) httpRequest
                .getAttribute("javax.servlet.error.status_code");
    }

}