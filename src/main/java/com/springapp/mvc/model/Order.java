package com.springapp.mvc.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.List;

@Entity
@Table(name = "orders", catalog = "ishop")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "order_id")
    private Integer id;

    @Column(name = "email")
    private String email;

    @Column(name = "phone")
    private String phone;

    @Column(name = "name")
    private String name;

    @Column(name = "date_received")
    @Temporal(TemporalType.TIMESTAMP)
    private Calendar dateReceived;

    @Column(name = "date_accepted")
    @Temporal(TemporalType.TIMESTAMP)
    private Calendar dateAccepted;

    @Column(name = "state")
    private Integer state;

    @Column(name = "commentary")
    private String commentary;

    @Column(name = "meeting_point")
    private String meetingPoint;

    @Column(name = "date_deal")
    private Calendar dateDeal;

    @Column(name = "total_sum", precision = 8, scale = 2)
    private BigDecimal totalSum;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "manager", referencedColumnName = "username")
    private User manager;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "order", orphanRemoval = true, cascade = CascadeType.ALL)
    private List<OrderItem> items;

    public static final Integer STATE_REJECTED = -2;
    public static final Integer STATE_INVALID = -1;
    public static final Integer STATE_OPENED = 0;
    public static final Integer STATE_ACCEPTED = 1;
    public static final Integer STATE_IN_PROCESS = 2;
    public static final Integer STATE_DEAL = 3;
    public static final Integer STATE_COMPLETED = 4;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Calendar getDateReceived() {
        return dateReceived;
    }

    public void setDateReceived(Calendar dateReceived) {
        this.dateReceived = dateReceived;
    }

    public Calendar getDateAccepted() {
        return dateAccepted;
    }

    public void setDateAccepted(Calendar dateAccepted) {
        this.dateAccepted = dateAccepted;
    }

    public String getMeetingPoint() {
        return meetingPoint;
    }

    public void setMeetingPoint(String meetingPoint) {
        this.meetingPoint = meetingPoint;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getCommentary() {
        return commentary;
    }

    public void setCommentary(String commentary) {
        this.commentary = commentary;
    }

    public Calendar getDateDeal() {
        return dateDeal;
    }

    public void setDateDeal(Calendar dateDeal) {
        this.dateDeal = dateDeal;
    }

    public BigDecimal getTotalSum() {
        return totalSum;
    }

    public void setTotalSum(BigDecimal totalSum) {
        this.totalSum = totalSum;
    }

    public User getManager() {
        return manager;
    }

    public void setManager(User manager) {
        this.manager = manager;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}