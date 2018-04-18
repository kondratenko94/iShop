package com.springapp.mvc.controller;

import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainPageController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String authorization(ModelMap model) {
        model.addAttribute("compareProduct", new ComparedSet());
        return "/shop/main";
    }
}