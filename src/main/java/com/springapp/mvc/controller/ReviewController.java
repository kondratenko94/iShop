package com.springapp.mvc.controller;

import com.springapp.mvc.form.Vote;
import com.springapp.mvc.model.Review;
import com.springapp.mvc.model.User;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @RequestMapping(value = "/review/", method = RequestMethod.POST)
    public String addReview(@ModelAttribute("newReview") Review review) {

        User user = this.currentAuthentication.getCurrentUser();

        if ( user != null && !user.banned() ) {
            this.reviewService.addReview( user.getUsername(), review);
        } else {
            return "redirect:/" + review.getType() +  "/" + review.getProductId() + "?error=1";
        }

        return "redirect:/" + review.getType() +  "/" + review.getProductId() + "#review" + review.getId();
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @ResponseBody
    @RequestMapping(value = "/reviews/", method = RequestMethod.POST)
    public byte handleVote(@RequestBody Vote vote) {

        User user = this.currentAuthentication.getCurrentUser();
        if ( user != null && !user.banned() ) {
            return this.reviewService.setVote( user.getUsername(), vote.getId(), vote.getVote() );
        }

        return 0;
    }

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @ResponseBody
    @RequestMapping(value = "/review/edit/", method = RequestMethod.POST)
    public boolean editReview(@RequestBody Review review) {

        User user = this.currentAuthentication.getCurrentUser();
        if ( user != null && !user.banned() ) {
            return this.reviewService.editReview( user.getUsername(), review );
        }

        return false;
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/reviews/delete/", method = RequestMethod.POST)
    public boolean deleteReview(int id) {
        return this.reviewService.deleteReview(id);
    }

}