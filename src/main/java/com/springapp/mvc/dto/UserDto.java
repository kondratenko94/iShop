package com.springapp.mvc.dto;

import com.springapp.mvc.model.Group;
import com.springapp.mvc.model.User;

public class UserDto {

    private String username;

    private String name;

    private String surname;

    private String phone;

    private String email;

    private String patronymic;

    private String address;

    private String photo;

    private String group;

    private Boolean status;

    public UserDto() {}

    public UserDto(User user) {

        if (user != null) {
            this.username = user.getUsername();
            this.name = user.getName();
            this.surname = user.getSurname();
            this.phone = user.getPhone();
            this.email = user.getEmail();
            this.patronymic = user.getPatronymic();
            this.address = user.getAddress();
            this.photo = user.getPhoto();
            this.status = user.banned();

            Group group = user.getGroup();
            this.group = (group != null) ? group.getCaption() : "";
        }
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public String getGroup() {
        return group;
    }

    public void setGroup(String group) {
        this.group = group;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}