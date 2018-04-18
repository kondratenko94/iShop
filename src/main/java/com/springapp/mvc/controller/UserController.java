package com.springapp.mvc.controller;

import com.springapp.mvc.dto.MessageDto;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.form.NewPassword;
import com.springapp.mvc.model.*;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.EmailService;
import com.springapp.mvc.service.FavouriteService;
import com.springapp.mvc.service.ReviewService;
import com.springapp.mvc.service.UserService;
import com.springapp.mvc.validator.ProfileValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.env.Environment;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private FavouriteService favouriteService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @Autowired
    private ProfileValidator profileValidator;

    @Autowired
    private EmailService emailService;

    @Autowired
    @Qualifier("authenticationManager")
    private AuthenticationManager authManager;

    private static final String fromAddress = "ishop.email@yandex.ru";

    @InitBinder
    protected void initBinder(WebDataBinder binder) {
        binder.setValidator(profileValidator);
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/profile/", method = RequestMethod.GET)
    public String profilePage(ModelMap model) {

        String username = this.currentAuthentication.getCurrentUsername();
        User user = null;

        long reviewsCount = 0;
        int reputation = 0;
        if (username != null) {
            user = userService.getUserByUsername(username);
            reviewsCount = this.reviewService.countByUsername(username);
            reputation = this.reviewService.reputationByUsername(username);
        }

        model.addAttribute("reviewsCount", reviewsCount);
        model.addAttribute("reputation", reputation);
        model.addAttribute("user", user);
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("updateUser", user);

        return "user/profile";
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/profile/settings", method = RequestMethod.GET)
    public String profileSettings(ModelMap model) {
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("newPassword", new NewPassword());

        return "user/settings";
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/profile/settings", method = RequestMethod.POST)
    public String setNewPassword(@ModelAttribute("newPassword") @Validated NewPassword newPassword, BindingResult result, ModelMap model) {

        if (result.hasErrors()) {
            model.addAttribute("newPassword", newPassword);
        } else {
            model.addAttribute("newPassword", new NewPassword());
        }

        model.addAttribute("compareProduct", new ComparedSet());

        return "user/settings";
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/profile/photo", method = RequestMethod.POST)
    public String editProfile(@RequestParam("file") MultipartFile multipartFile) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            this.userService.setPhoto(username, multipartFile);
        }

        return "redirect:/profile/";
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/profile/favourite", method = RequestMethod.GET)
    public String favouritePage(@RequestParam(required = false) Integer page,
                                ModelMap model) {
        final int COUNT = 10;

        List<Product> productList = new ArrayList<>();
        long pagesCount = 0;

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {



            pagesCount = (long) Math.ceil( (float)this.favouriteService.countByUsername(username) / (float)COUNT );
            if (page == null || page < 1 || page > pagesCount) {
                page = 1;
            }
            List<FavouriteItem> favouritesList = this.favouriteService.listFavouriteItems(username, page, COUNT);

            for (FavouriteItem item : favouritesList) {
                Product product = item.getProduct();
                productList.add(product);
            }
        }

        model.addAttribute("productsList", productList);
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("page", page);

        return "user/favourite";
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/profile/reviews", method = RequestMethod.GET)
    public String profileReviews(@RequestParam(required = false) Integer page,
                                 ModelMap model) {
        final int COUNT = 10;

        List<Review> reviews = null;
        long pagesCount = 0;

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            PaginationWrapper<Review> pagWrapper = this.reviewService.listReviewsByUsername(username, page, COUNT);

            reviews = pagWrapper.getList();
            pagesCount = pagWrapper.getPagesCount();
        }

        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("reviewsList", reviews);
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("page", (page == null) ? 1 : page);

        return "user/reviews";
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/profile/", method = RequestMethod.POST)
    public String updateProfile(@ModelAttribute("updateUser") @Validated User updatedUser , BindingResult result,
                                ModelMap model) {

        String username = this.currentAuthentication.getCurrentUsername();

        User user = null;
        long reviewsCount = 0;
        int reputation = 0;

        if (username != null) {

            if ( !result.hasErrors() && username.equals( updatedUser.getUsername() ) ) {
                this.userService.updateUser(updatedUser);
            } else {
                if (result.hasErrors()) {
                    model.addAttribute("autoShowModal", true);
                }
            }

            user = userService.getUserByUsername(username);
            reviewsCount = this.reviewService.countByUsername(username);
            reputation = this.reviewService.reputationByUsername(username);
        }

        model.addAttribute("reviewsCount", reviewsCount);
        model.addAttribute("reputation", reputation);
        model.addAttribute("user", user);
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("updateUser", updatedUser);

        return "user/profile";
    }

    @RequestMapping(value = "/user/{name}", method = RequestMethod.GET)
    public String userPage(@PathVariable("name") String name, ModelMap model) {

        if (this.userService.loginExists(name)) {
            User user = this.userService.getUserByUsername(name);
            long reviewsCount = this.reviewService.countByUsername(name);
            int reputation = this.reviewService.reputationByUsername(name);

            model.addAttribute("user", user);
            model.addAttribute("reviewsCount", reviewsCount);
            model.addAttribute("reputation", reputation);
        } else {
            model.addAttribute("user", null);
        }

        model.addAttribute("compareProduct", new ComparedSet());

        return "user/user";
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/user/punishment/", method = RequestMethod.POST)
    public String banUser(String username, int mode) {

        User currentUser = this.currentAuthentication.getCurrentUser();
        User targetUser = this.userService.getUserByUsername(username);

        return this.userService.punishUser(currentUser, targetUser, mode);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/user/amnesty/", method = RequestMethod.POST)
    public String amnestyUser(String username, int mode) {
        User currentUser = this.currentAuthentication.getCurrentUser();
        User targetUser = this.userService.getUserByUsername(username);

        return this.userService.amnestyUser(currentUser, targetUser, mode);
    }

    @ResponseBody
    @RequestMapping(value = "/user/password/reset/", method = RequestMethod.POST)
    public boolean resetPassword(final HttpServletRequest request, String email) {
        User user = userService.getUserByEmail(email);
        if (user != null) {
            String token = UUID.randomUUID().toString();
            userService.createPasswordResetToken(user, token);

            final String appUrl = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();

            String msgBody = appUrl + "/password/reset/" + token;

            emailService.sendEmail(email, fromAddress, "Восстановление пароля : ", msgBody);

            return true;
        }
        return false;
    }

    @RequestMapping(value = "/password/reset/{token}", method = RequestMethod.GET)
    public String passwordRecoveryPage(@PathVariable("token") String token, ModelMap model) {

        User user = userService.getUserByToken(token);

        model.addAttribute("success", user != null);
        model.addAttribute("token", token);
        model.addAttribute("compareProduct", new ComparedSet());
        return "password_recovery";
    }

    @ResponseBody
    @RequestMapping(value = "/user/password/change/", method = RequestMethod.POST)
    public boolean changePassword(HttpServletRequest request, String password, String token) {

        User user = userService.getUserByToken(token);

        boolean success = false;
        if (user != null) {

            success = userService.setPassword(user, password);

            if (success) {
                authenticateUserAndSetSession(user.getUsername(), password, request);
            }
        }

        return success;
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