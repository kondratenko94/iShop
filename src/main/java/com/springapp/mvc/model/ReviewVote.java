package com.springapp.mvc.model;

import javax.persistence.*;

@Entity
@Table(name = "reviews_votes", catalog = "ishop")
public class ReviewVote {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "review_id")
    private Integer reviewId;

    @Column(name = "username")
    private String username;

    @Column(name = "vote")
    private Byte vote;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getReviewId() {
        return reviewId;
    }

    public void setReviewId(Integer reviewId) {
        this.reviewId = reviewId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Byte getVote() {
        return vote;
    }

    public void setVote(Byte vote) {
        this.vote = vote;
    }
}