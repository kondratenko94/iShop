package com.springapp.mvc.model;

import com.springapp.mvc.dto.UserDto;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "users", catalog = "ishop")
public class User {

    private static final int EXPIRATION = 60 * 24;

    @Id
    @Column(name = "username", unique = true, nullable = false)
    private String username;

    @Column(name = "password")
    private String password;

    @Column(name = "enabled")
    private Boolean enabled;

    @Column(name = "name")
    private String name;

    @Column(name = "surname")
    private String surname;

    @Column(name = "phone")
    private String phone;

    @Column(name = "email")
    private String email;

    @Column(name = "patronymic")
    private String patronymic;

    @Column(name = "address")
    private String address;

    @Column(name = "photo")
    private String photo;

    @Column(name = "banned")
    private Calendar bannedUntil;

    @Column(name = "token")
    private String token;

    @Column(name = "token_expiration")
    @Temporal(TemporalType.TIMESTAMP)
    private Calendar tokenExpiration;

    @Transient
    private String confirmPassword;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(name = "group_members",
                joinColumns = {@JoinColumn(name = "username", referencedColumnName = "username")},
                inverseJoinColumns = {@JoinColumn(name = "group_id")})
    private Group group;


    @OneToMany(fetch = FetchType.LAZY)
    @JoinColumn(name = "username", referencedColumnName = "username")
    private List<FavouriteItem> favouriteItems;

    public UserDto produceDto() {
        return new UserDto(this);
    }

    public List<FavouriteItem> getFavouriteItems() {
        return favouriteItems;
    }

    public void setFavouriteItems(List<FavouriteItem> favouriteItems) {
        this.favouriteItems = favouriteItems;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPatronymic() {
        return patronymic;
    }

    public void setPatronymic(String patronymic) {
        this.patronymic = patronymic;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public Calendar getBannedUntil() {
        return bannedUntil;
    }

    public void setBannedUntil(Calendar bannedUntil) {
        this.bannedUntil = bannedUntil;
    }

    public String getBannedTerm() {
        if (!enabled) {
            return "Заблокирован";
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy, HH:mm");
            return "Забанен до " + sdf.format(bannedUntil.getTime());
        }
    }

    public boolean banned() {

        boolean banned = false;
        if (bannedUntil != null) {
            Long currentDateTimeInMillis = Calendar.getInstance().getTimeInMillis();
            Long bannedDateTimeInMillis = bannedUntil.getTimeInMillis();

            if (bannedDateTimeInMillis > currentDateTimeInMillis) {
                banned = true;
            } else {
                bannedUntil = null;
            }
        }

        return (!enabled || banned);
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Calendar getTokenExpiration() {
        return tokenExpiration;
    }

    public void setTokenExpiration(Calendar tokenExpiration) {
        this.tokenExpiration = tokenExpiration;
    }

    public void setTokenExpiration() {
        this.tokenExpiration = calculateExpiryDate(EXPIRATION);
    }

    private Calendar calculateExpiryDate(final int expiryTimeInMinutes) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.MINUTE, expiryTimeInMinutes);
        return cal;
    }
}
