package com.springapp.mvc.service;

import com.springapp.mvc.dao.ProductDao;
import com.springapp.mvc.dao.ReviewDao;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.model.Review;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.Calendar;

import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class ReviewServiceImplTest {

    @Mock
    ReviewDao reviewDao;

    @Mock
    ProductDao productDao;

    @InjectMocks
    ReviewServiceImpl reviewServiceImpl;

    @Test
    public void testAddReview_ShouldAddReview() {
        Review review = new Review();
        review.setContent("something interesting");

        reviewServiceImpl.addReview("any", review);

        verify(reviewDao).addReview(review);
    }

    @Test
    public void testEditReview_ShouldCheckOwner() {
        Review review = createReview(1, null, null);

        Review oldReview = createReview(1, "first", Calendar.getInstance());
        when(reviewDao.getReviewById(1)).thenReturn( oldReview );

        assertTrue(reviewServiceImpl.editReview("first", review ));
        assertFalse(reviewServiceImpl.editReview("another", review));
    }

    @Test
    public void testEditReview_CheckSuitableEditingTime() {

        Calendar suitableDate = Calendar.getInstance();
        suitableDate.setTimeInMillis(Calendar.getInstance().getTimeInMillis() - (19 * 60 * 1000));

        Review oldReview = createReview(1, "first", suitableDate);
        Review review = createReview(1, null, null);
        when(reviewDao.getReviewById(1)).thenReturn( oldReview );

        assertTrue(reviewServiceImpl.editReview("first", review));
    }

    @Test
    public void testEditReview_EditingTimeIsUp() {
        Calendar expiredDate = Calendar.getInstance();
        expiredDate.setTimeInMillis(Calendar.getInstance().getTimeInMillis() - (20 * 60 * 1000));

        Review oldReview = createReview(1, "first", expiredDate);
        Review review = createReview(1, null, null);
        when(reviewDao.getReviewById(1)).thenReturn( oldReview );

        assertFalse(reviewServiceImpl.editReview("first", review));
    }

    @Test
    public void testSetVote_ShouldAcceptVote() {
        when(reviewDao.isVoteExist("any", 1)).thenReturn(false);

        assertEquals(1, reviewServiceImpl.setVote("any", 1, true));
        assertEquals(-1, reviewServiceImpl.setVote("any", 1, false));
    }

    @Test
    public void testSetVote_ShouldRejectVote() {
        when(reviewDao.isVoteExist("second", 2)).thenReturn(true);

        assertEquals(0, reviewServiceImpl.setVote("second", 2, true));
        assertEquals(0, reviewServiceImpl.setVote("second", 2, false));
    }

    @Test
    public void testListReviewsByUsername_NegativePageShouldWork() {
        int negativePage = -42;
        int count = 5;
        long matches = 12L;
        int expectedOffset = 0;

        when(reviewDao.numberOfMatches("anyone")).thenReturn(matches);

        reviewServiceImpl.listReviewsByUsername("anyone", negativePage, count);

        verify(reviewDao).listReviewsByUsername("anyone", expectedOffset, count);
    }

    @Test
    public void testListReviewsByUsername_TooBigPageShouldWork() {
        int page = Integer.MAX_VALUE;
        int count = 5;
        long matches = 12L;
        int expectedOffset = 0;

        when(reviewDao.numberOfMatches("anyone")).thenReturn(matches);

        reviewServiceImpl.listReviewsByUsername("anyone", page, count);

        verify(reviewDao).listReviewsByUsername("anyone", expectedOffset, count);
    }

    private Review createReview(int id, String username, Calendar postedDate) {
        Review review = new Review();
        review.setId(id);
        review.setUsername(username);
        review.setPosted_date(postedDate);
        return review;
    }

}