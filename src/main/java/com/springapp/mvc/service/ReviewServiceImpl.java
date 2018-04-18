package com.springapp.mvc.service;

import com.springapp.mvc.dao.ProductDao;
import com.springapp.mvc.dao.ReviewDao;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.model.Product;
import com.springapp.mvc.model.Review;
import com.springapp.mvc.model.ReviewVote;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDao reviewDao;

    @Autowired
    private ProductDao productDao;

    @Override
    @Transactional
    public void addReview(String username, Review review) {
        Product product = this.productDao.getProductById(review.getProductId());

        review.setUsername(username);
        review.setProduct(product);
        review.setPosted_date(Calendar.getInstance());
        this.reviewDao.addReview(review);
    }

    @Override
    @Transactional
    public boolean editReview(String username, Review review) {

        Review oldReview = this.reviewDao.getReviewById( review.getId() );

        if (oldReview != null && oldReview.getUsername().equals(username)) {

            Calendar currentDate = Calendar.getInstance();

            Long currentDateTimeInMillis = currentDate.getTimeInMillis();
            Long postedDateTimeInMillis = oldReview.getPosted_date().getTimeInMillis();

            if ( currentDateTimeInMillis - postedDateTimeInMillis < (20 * 60 * 1000) ) {
                oldReview.setContent(review.getContent());

                return true;
            }
        }

        return false;
    }

    @Override
    @Transactional
    public boolean deleteReview(int reviewId) {
        Review review = this.reviewDao.getReviewById(reviewId);
        return this.reviewDao.deleteReview(review);
    }

    @Override
    @Transactional
    public byte setVote(String username, int reviewId, Boolean vote) {

        if (!this.reviewDao.isVoteExist(username, reviewId)) {

            ReviewVote reviewVote = new ReviewVote();
            Byte value = calcVoteValue(vote);

            reviewVote.setUsername(username);
            reviewVote.setReviewId(reviewId);
            reviewVote.setVote(value);

            this.reviewDao.setVote(reviewVote);
            return value;
        }

        return 0;
    }

    @Override
    @Transactional
    public long countByUsername(String username) {
        return this.reviewDao.numberOfMatches(username);
    }

    @Override
    @Transactional
    public int reputationByUsername(String username) {
        return this.reviewDao.reputationByUsername(username);
    }

    @Override
    @Transactional
    public PaginationWrapper<Review> listReviewsByUsername(String username, Integer page, int count) {

        long matches = this.reviewDao.numberOfMatches(username);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        List<Review> reviews = this.reviewDao.listReviewsByUsername(username, offset, count);

        PaginationWrapper<Review> pagWrapper = new PaginationWrapper<>();
        pagWrapper.setList(reviews);
        pagWrapper.setCount(count);
        pagWrapper.setMaxCount(matches);

        return pagWrapper;
    }

    private Byte calcVoteValue(Boolean vote) {

        if (vote == null) {
            return 0;
        } else {
            return vote ? (byte)1 : (byte)-1;
        }

    }


}