package com.springapp.mvc.controller;

import com.springapp.mvc.dto.UserDto;
import com.springapp.mvc.model.User;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.UserService;
import com.springapp.mvc.dto.PaginationWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@PreAuthorize("hasRole('ADMIN')")
@Controller
public class UserManagementController {

    @Autowired
    private UserService userService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @RequestMapping(value = "/management/users/", method = RequestMethod.GET)
    public String manageUsers(ModelMap model) {
        model.addAttribute("selectedMenu", "staff");
        return "/management/users/users";
    }

    @ResponseBody
    @RequestMapping(value = "/management/users/search", method = RequestMethod.GET)
    public PaginationWrapper searchUsers(String input, String group, Integer page, int count) {

        if (count > 100) {
            count = 100;
        }

        PaginationWrapper<UserDto> pagWrapper = this.userService.getUsersDtoByInput(input, group, page, count);
        return pagWrapper;
    }

    @ResponseBody
    @RequestMapping(value = "/management/users/role", method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public String setRoleToUser(String username, String role) {

        User currentUser = this.currentAuthentication.getCurrentUser();
        User targetUser = this.userService.getUserByUsername(username);

        if (currentUser != null && targetUser != null) {
            return this.userService.setRoleToUser(currentUser, targetUser, role);
        }
        else {
            return "Не удалось установить <b>права</b>.";
        }
    }

}