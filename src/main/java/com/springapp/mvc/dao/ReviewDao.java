package com.springapp.mvc.dao;

import com.springapp.mvc.model.Review;
import com.springapp.mvc.model.ReviewVote;

import java.util.List;

public interface ReviewDao {

    void addReview(Review review);

    boolean deleteReview(Review review);

    boolean isVoteExist(String username, int reviewId);

    void setVote(ReviewVote reviewVote);

    Review getReviewById(int id);

    long numberOfMatches(String username);

    int reputationByUsername(String username);

    List<Review> listReviewsByUsername(String username, int offset, int count);
}