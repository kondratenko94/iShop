package com.springapp.mvc.service;

import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.dto.UserDto;
import com.springapp.mvc.model.User;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface UserService {

    User getUserByUsername(String username);

    User getUserByEmail(String email);

    User getUserByToken(String token);

    void addUser(User user);

    void updateUser(User user);

    void createPasswordResetToken(User user, String token);

    PaginationWrapper<UserDto> getUsersDtoByInput(String input, String group, Integer page, int count);

    String setRoleToUser(User currentUser, User targetUser, String role);

    boolean loginExists(String username);

    boolean emailExists(String email);

    boolean checkPassword(String username, String password);

    String punishUser(User punisher, User targetUser, int mode);

    String amnestyUser(User punisher, User targetUser, int mode);

    boolean setPassword(User user, String password);

    void setPhoto(String username, MultipartFile multipartFile);


}