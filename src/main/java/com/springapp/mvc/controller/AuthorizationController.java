package com.springapp.mvc.controller;

import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.model.User;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.UserService;
import com.springapp.mvc.validator.RegistrationValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AuthorizationController {

    @Autowired
    private UserService userService;

    @Autowired
    RegistrationValidator registrationValidator;

    @Autowired
    @Qualifier("authenticationManager")
    private AuthenticationManager authManager;

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(registrationValidator);
    }

    @PreAuthorize("isAnonymous()")
    @RequestMapping(value = "/registration/", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") @Validated User user, BindingResult result,
                          HttpServletRequest request, ModelMap model){

        if (result.hasErrors()) {
            model.addAttribute("user", user);
            model.addAttribute("compareProduct", new ComparedSet());
            model.addAttribute("mode", "reg");

            return "authorization";
        } else {

            String username = user.getUsername();
            String password = user.getPassword(); // password value before encrypting

            this.userService.addUser(user);

            authenticateUserAndSetSession(username, password, request);

            return "redirect:/profile/";
        }
    }

    @PreAuthorize("isAnonymous()")
    @RequestMapping(value = "/authorization", method = RequestMethod.GET)
    public String authorization(ModelMap model) {
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("user", new User());
        model.addAttribute("mode", "auth");

        return "authorization";
    }

    @RequestMapping(value = "/error")
    public String accessError(ModelMap model){
        model.addAttribute("compareProduct", new ComparedSet());
        return "error";
    }

    private void authenticateUserAndSetSession(String username, String password, HttpServletRequest request) {

        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);
        // generate session if one doesn't exist
        request.getSession();

        token.setDetails(new WebAuthenticationDetails(request));
        Authentication authenticatedUser = authManager.authenticate(token);

        SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
    }
}