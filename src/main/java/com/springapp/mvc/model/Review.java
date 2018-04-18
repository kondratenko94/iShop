package com.springapp.mvc.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Optional;

@Entity
@Table(name = "reviews", catalog = "ishop")
public class Review implements Comparable<Review>{

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "username")
    private String username;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "posted_date")
    private Calendar posted_date;

    @Column(name = "content")
    private String content;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "review_id", referencedColumnName = "id")
    private List<ReviewVote> votesList;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "username", referencedColumnName = "username", insertable = false, updatable = false)
    private User user;

    @Transient
    private int productId;

    @Transient
    private String type;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Review)) return false;

        Review review = (Review) o;

        if (productId != review.productId) return false;
        if (id != null ? !id.equals(review.id) : review.id != null) return false;
        if (username != null ? !username.equals(review.username) : review.username != null) return false;
        if (posted_date != null ? !posted_date.equals(review.posted_date) : review.posted_date != null) return false;
        if (content != null ? !content.equals(review.content) : review.content != null) return false;
        if (product != null ? !product.equals(review.product) : review.product != null) return false;
        if (votesList != null ? !votesList.equals(review.votesList) : review.votesList != null) return false;
        if (user != null ? !user.equals(review.user) : review.user != null) return false;
        return !(type != null ? !type.equals(review.type) : review.type != null);

    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (username != null ? username.hashCode() : 0);
        result = 31 * result + (posted_date != null ? posted_date.hashCode() : 0);
        result = 31 * result + (content != null ? content.hashCode() : 0);
        result = 31 * result + (product != null ? product.hashCode() : 0);
        result = 31 * result + (votesList != null ? votesList.hashCode() : 0);
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + productId;
        result = 31 * result + (type != null ? type.hashCode() : 0);
        return result;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Calendar getPosted_date() {
        return posted_date;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getPostedDateString() {
        if (posted_date == null) return "";

        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy, HH:mm");
        return sdf.format(posted_date.getTime());
    }

    public void setPosted_date(Calendar posted_date) {
        this.posted_date = posted_date;
    }

    public List<ReviewVote> getVotesList() {
        return votesList;
    }

    public void setVotesList(List<ReviewVote> votesList) {
        this.votesList = votesList;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getReputation() {
        int sum = 0;
        for (ReviewVote reviewVote : votesList) {
            sum += reviewVote.getVote();
        }
        return sum;
    }

    public boolean timeIsOver() {

        Calendar currentDate = Calendar.getInstance();
        Long currentDateTimeInMillis = currentDate.getTimeInMillis();
        Long postedDateTimeInMillis = posted_date.getTimeInMillis();

        if ( currentDateTimeInMillis - postedDateTimeInMillis < (20 * 60 * 1000)) {
            return false;
        } else {
            return true;
        }

    }

    public byte voteByUsername(String username) {

        Optional<ReviewVote> optional = votesList.stream()
                .filter(t -> t.getUsername().equals(username))
                .findFirst();

        ReviewVote reviewVote = (optional.isPresent()) ? optional.get() : null;

        return ( reviewVote != null ) ? reviewVote.getVote() : 0;
    }

    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", posted_date=" + posted_date +
                ", content='" + content + '\'' +
                ", votesList=" + votesList +
                '}';
    }

    @Override
    public int compareTo(Review review) {
        return review.getReputation() - this.getReputation();
    }
}