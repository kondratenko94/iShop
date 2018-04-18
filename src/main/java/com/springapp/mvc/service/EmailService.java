package com.springapp.mvc.service;

public interface EmailService {

    void sendEmail(String toAddress, String fromAddress, String subject, String msgBody);

}