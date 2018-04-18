package com.springapp.mvc.security;

import com.springapp.mvc.model.User;
import com.springapp.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class CurrentAuthentication {

    @Autowired
    private UserService userService;

    public String getCurrentUsername() {

        try {
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            String username;
            if (principal instanceof UserDetails) {
                username = ((UserDetails)principal).getUsername();

            } else {
                username = principal.toString();
            }

            return !username.equals("anonymousUser") ? username : null;
        } catch (NullPointerException e) {
            System.out.println(e.getMessage());
            return null;
        }
    }

    public User getCurrentUser() {
        String username = getCurrentUsername();
        return (username != null) ? this.userService.getUserByUsername(username) : null;

    }
}