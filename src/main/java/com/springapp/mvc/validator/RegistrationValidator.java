package com.springapp.mvc.validator;

import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.model.User;
import com.springapp.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Component
public class RegistrationValidator implements Validator {

    EmailValidator emailValidator;

    private UserService userService;

    @Autowired
    public void setEmailValidator(EmailValidator emailValidator) {
        this.emailValidator = emailValidator;
    }

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass) || ComparedSet.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "UserRegistration.username.empty");
        if (user.getUsername().length() < 4) {
            errors.rejectValue("username", "UserRegistration.username.short");
        }

        if (user.getUsername().length() > 12) {
            errors.rejectValue("username", "UserRegistration.username.long");
        }

        Matcher matcher = Pattern.compile("^[A-Za-z_0-9]+$").matcher(user.getUsername());
        if (!matcher.matches()) {
            errors.rejectValue("username", "UserRegistration.username.invalid");
        }

        if (this.userService.loginExists(user.getUsername())) {
            errors.rejectValue("username", "UserRegistration.username.exists");
        }


        if (user.getSurname().length() > 40) {
            errors.rejectValue("surname", "UserRegistration.long");
        }

        if (user.getName().length() > 40) {
            errors.rejectValue("name", "UserRegistration.long");
        }

        if (user.getPatronymic().length() > 40) {
            errors.rejectValue("patronymic", "UserRegistration.long");
        }

        if (user.getPhone().length() > 40) {
            errors.rejectValue("phone", "UserRegistration.long");
        }

        if (user.getAddress().length() > 100) {
            errors.rejectValue("address", "UserRegistration.long");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "UserRegistration.email.empty");
        if (!emailValidator.valid(user.getEmail())) {
            errors.rejectValue("email", "UserRegistration.email.invalid");
        }

        if (this.userService.emailExists(user.getEmail())){
            errors.rejectValue("email", "UserRegistration.email.exists");
        }

        if (user.getEmail().length() > 64) {
            errors.rejectValue("email", "UserRegistration.email.long");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "UserRegistration.password.empty");
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            errors.rejectValue("password", "UserRegistration.password.different");
        }

        if (user.getPassword().length() > 30) {
            errors.rejectValue("password", "UserRegistration.password.long");
        }

        if (user.getPassword().length() < 8) {
            errors.rejectValue("password", "UserRegistration.password.short");
        }

        if (user.getPassword().contains(" ")) {
            errors.rejectValue("password", "UserRegistration.password.space");
        }

    }
}