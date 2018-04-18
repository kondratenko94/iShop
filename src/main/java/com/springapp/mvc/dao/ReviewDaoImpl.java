package com.springapp.mvc.dao;

import com.springapp.mvc.model.Review;
import com.springapp.mvc.model.ReviewVote;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public class ReviewDaoImpl implements ReviewDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addReview(Review review) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(review);
    }

    @Override
    public boolean deleteReview(Review review) {
        Session session = this.sessionFactory.getCurrentSession();

        boolean success = false;
        if (review != null) {
            session.delete(review);
            success = true;
        }

        return success;
    }

    @Override
    public boolean isVoteExist(String username, int reviewId) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select 1 from ReviewVote r " +
                "where r.username = :username and r.reviewId = :reviewId");
        query.setString("username", username);
        query.setInteger("reviewId", reviewId);

        return query.uniqueResult() != null;
    }

    @Override
    public void setVote(ReviewVote reviewVote) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(reviewVote);
    }

    @Override
    public Review getReviewById(int id) {

        Session session = this.sessionFactory.getCurrentSession();
        Review review = (Review) session.get(Review.class, id);

        return review;
    }

    @Override
    public long numberOfMatches(String username) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count(*) from  Review r " +
                "where r.username = :username");
        query.setParameter("username", username);

        Object obj = query.uniqueResult();
        return obj != null ? (long) obj : 0;
    }

    @Override
    public int reputationByUsername(String username) {
        Session session = this.sessionFactory.getCurrentSession();
        SQLQuery query = session.createSQLQuery("SELECT SUM((SELECT SUM(vote) FROM reviews_votes where review_id=r.id)) " +
                "FROM reviews r where username= :username");

        query.setParameter("username", username);
        Object object = query.uniqueResult();
        return object != null ? ((BigDecimal)object).intValue() : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Review> listReviewsByUsername(String username, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Review r where r.username = :username");

        query.setParameter("username", username);
        query.setFirstResult(offset);
        query.setMaxResults(count);

        return query.list();

    }


}