package com.springapp.mvc.validator;

import com.springapp.mvc.form.NewPassword;
import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.model.User;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class ProfileValidator implements Validator {

    @Autowired
    private UserService userService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @Override
    public boolean supports(Class<?> aClass) {

        return NewPassword.class.equals(aClass) || ComparedSet.class.equals(aClass) || User.class.isAssignableFrom(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {

        if (o instanceof NewPassword) {
            NewPassword newPassword = (NewPassword) o;

            ValidationUtils.rejectIfEmptyOrWhitespace(errors, "oldPassword", "UserRegistration.password.empty");
            ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "UserRegistration.password.empty");
            ValidationUtils.rejectIfEmptyOrWhitespace(errors, "confirmPassword", "UserRegistration.password.empty");

            if (!newPassword.getPassword().equals(newPassword.getConfirmPassword())) {
                errors.rejectValue("password", "UserRegistration.password.different");
            }

            if (newPassword.getPassword().length() > 30) {
                errors.rejectValue("password", "UserRegistration.password.long");
            }

            if (newPassword.getPassword().length() < 8) {
                errors.rejectValue("password", "UserRegistration.password.short");
            }

            if (newPassword.getPassword().contains(" ")) {
                errors.rejectValue("password", "UserRegistration.password.space");
            }

            String username = this.currentAuthentication.getCurrentUsername();
            if (!this.userService.checkPassword(username, newPassword.getOldPassword())) {
                errors.rejectValue("oldPassword", "ProfileValidator.password.wrong");
            }

        } else if (o instanceof User) {
            User user = (User) o;

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
        }

    }
}