package com.springapp.mvc.service;

import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.model.Review;

public interface ReviewService {

    void addReview(String username, Review review);

    boolean editReview(String username, Review review);

    boolean deleteReview(int reviewId);

    byte setVote(String username, int reviewId, Boolean vote);

    long countByUsername(String username);

    int reputationByUsername(String username);

    PaginationWrapper<Review> listReviewsByUsername(String username, Integer page, int count);

}