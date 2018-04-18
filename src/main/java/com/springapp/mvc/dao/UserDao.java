package com.springapp.mvc.dao;

import com.springapp.mvc.model.Group;
import com.springapp.mvc.model.User;
import org.hibernate.criterion.Criterion;

import java.util.Calendar;
import java.util.List;

public interface UserDao {

    void addUser(User user);

    void updateUser(User updatedUser);

    long numberOfMatches(List<Criterion> criterions, String group);

    List<User> getUsersByCriterions(List<Criterion> criterions, String group, int offset, int count);

    boolean loginExists(String username);

    boolean emailExists(String email);

    boolean checkPassword(String username, String password);

    String punishUser(User user, Calendar term);

    String amnestyUser(User user);

    String enableUser(User user);

    String disableUser(User user);

    User getUserByUsername(String username);

    User getUserByEmail(String email);

    User getUserByToken(String token);

}