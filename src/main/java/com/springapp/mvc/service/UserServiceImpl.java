package com.springapp.mvc.service;

import com.springapp.mvc.criteria.user.UserCriteria;
import com.springapp.mvc.dao.GroupDao;
import com.springapp.mvc.dao.UserDao;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.dto.UserDto;
import com.springapp.mvc.model.Group;
import com.springapp.mvc.model.User;
import com.springapp.mvc.storage.Hash;
import com.springapp.mvc.storage.StorageService;
import org.hibernate.criterion.Criterion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.xml.bind.DatatypeConverter;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private GroupDao groupDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private StorageService storageService;

    @Override
    @Transactional
    public User getUserByEmail(String email) {
        return this.userDao.getUserByEmail(email);
    }

    @Override
    @Transactional
    public User getUserByToken(String token) {

        String hashedToken = Hash.SHA512.hash(token);
        User user = this.userDao.getUserByToken(hashedToken);

        if (user != null) {
            Long currentTimeMs = Calendar.getInstance().getTimeInMillis();
            Long expiredTimeMs = user.getTokenExpiration().getTimeInMillis();

            if (currentTimeMs <= expiredTimeMs) {
                return user;
            }
        }

        return null;
    }

    @Override
    @Transactional
    public void addUser(User user) {
        Group group = groupDao.getGroupByName("user");

        String password = user.getPassword();
        String hashedPassword = passwordEncoder.encode(password);

        user.setPassword(hashedPassword);
        user.setEnabled(true);
        user.setGroup(group);

        this.userDao.addUser(user);
    }

    @Override
    @Transactional
    public void updateUser(User updatedUser) {

        User user = this.userDao.getUserByUsername(updatedUser.getUsername());
        user.setSurname( updatedUser.getSurname() );
        user.setName( updatedUser.getName() );
        user.setPatronymic( updatedUser.getPatronymic() );
        //user.setEmail( updatedUser.getEmail() ); Disabled
        user.setPhone( updatedUser.getPhone() );
        user.setAddress( updatedUser.getAddress() );

        this.userDao.updateUser(user);
    }

    @Override
    @Transactional
    public void createPasswordResetToken(User user, String token) {

        String hashedToken = Hash.SHA512.hash(token);

        user.setToken(hashedToken);
        user.setTokenExpiration();

        this.userDao.updateUser(user);
    }

    @Override
    @Transactional
    public PaginationWrapper<UserDto> getUsersDtoByInput(String input, String group, Integer page, int count) {

        List<Criterion> criterions = UserCriteria.getCriterions(input);

        long matches = this.userDao.numberOfMatches(criterions, group);

        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }

        int offset = (page - 1) * count;

        List<User> users = this.userDao.getUsersByCriterions(criterions, group, offset, count);
        List<UserDto> usersDto= new ArrayList<>();
        for (User user : users) {
            UserDto userDto = new UserDto(user);
            usersDto.add(userDto);
        }

        PaginationWrapper<UserDto> paginationWrapper = new PaginationWrapper<>();
        paginationWrapper.setList(usersDto);
        paginationWrapper.setCount(count);
        paginationWrapper.setMaxCount(matches);

        return paginationWrapper;

    }

    @Override
    @Transactional
    public String setRoleToUser(User currentUser, User targetUser, String role) {

        Group group = this.groupDao.getGroupByName(role);

        Group currUserGroup = currentUser.getGroup();
        Group targetGroup = targetUser.getGroup();

        if (group != null) {

            if ( currUserGroup.compareTo(targetGroup) > 0 && currUserGroup.compareTo(group) > 0) {
                targetUser.setGroup(group);
                this.userDao.updateUser(targetUser);
                return "Права пользователя успешно <b>изменены</b>.";
            } else {
                return "Недостаточно прав для совершения <b>действия</b>.";
            }

        } else {
            return "Вы указали несуществующую <b>группу</b>.";
        }

    }

    @Override
    @Transactional
    public boolean loginExists(String username) {
        return userDao.loginExists(username);
    }

    @Override
    @Transactional
    public boolean emailExists(String email) {
        return userDao.emailExists(email);
    }

    @Override
    @Transactional
    public boolean checkPassword(String username, String password) {
        return userDao.checkPassword(username, password);
    }

    @Override
    @Transactional
    public String punishUser(User punisher, User targetUser, int mode) {

        if (punisher == null || targetUser == null) return null;
        if (targetUser.getEnabled() != null && !targetUser.getEnabled()) return "disabled";

        Group punisherGroup = punisher.getGroup();
        Group targetGroup = targetUser.getGroup();

        //Rank #1 is the best
        if ( punisherGroup.compareTo(targetGroup) > 0 ) {

            if (mode < 6) {
                Calendar calendar = Calendar.getInstance();

                switch (mode) {
                    case 0 : {
                        calendar.add(Calendar.HOUR, 1);
                        break;
                    }
                    case 1 : {
                        calendar.add(Calendar.HOUR, 6);
                        break;
                    }
                    case 2 : {
                        calendar.add(Calendar.DAY_OF_YEAR, 1);
                        break;
                    }
                    case 3 : {
                        calendar.add(Calendar.DAY_OF_YEAR, 7);
                        break;
                    }
                    case 4 : {
                        calendar.add(Calendar.MONTH, 1);
                        break;
                    }
                    case 5 : {
                        calendar.add(Calendar.YEAR, 1);
                        break;
                    }

                }

                return this.userDao.punishUser(targetUser, calendar);

            } else {
                return this.userDao.disableUser(targetUser);
            }

        } else {
            return "fail";
        }

    }

    @Override
    @Transactional
    public String amnestyUser(User punisher, User targetUser, int mode) {
        if (punisher == null || targetUser == null) return null;

        Group punisherGroup = punisher.getGroup();
        Group targetGroup = targetUser.getGroup();

        //Rank #1 is the best
        if ( punisherGroup.compareTo(targetGroup) > 0 ) {

            if (mode == 0) {
                return this.userDao.amnestyUser(targetUser);

            } else {
                return this.userDao.enableUser(targetUser);
            }

        } else {
            return "fail";
        }
    }

    @Override
    @Transactional
    public boolean setPassword(User user, String password) {

        if ( !StringUtils.isEmpty(password) && password.length() >= 8) {

            String hashedPassword = passwordEncoder.encode(password);
            user.setPassword(hashedPassword);
            user.setToken(null);
            user.setTokenExpiration(null);

            this.userDao.updateUser(user);

            return true;
        }

        return false;
    }

    @Override
    @Transactional
    public User getUserByUsername(String username) {
        return userDao.getUserByUsername(username);
    }

    @Override
    @Transactional
    public void setPhoto(String username, MultipartFile multipartFile) {

        User user = this.userDao.getUserByUsername(username);
        if (multipartFile != null && !multipartFile.isEmpty()) {
            String link = this.storageService.saveFile(multipartFile, "photos");
            user.setPhoto(link);
        } else {
            user.setPhoto(null);
        }
    }


}