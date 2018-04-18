package com.springapp.mvc.security;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.springframework.context.ApplicationContextException;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityMessageSource;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

public class CustomJdbcDaoImpl extends JdbcDaoSupport implements UserDetailsService {
    public static final String DEF_USERS_BY_USERNAME_QUERY = "select username,password,enabled,photo,name,surname,patronymic,email,phone,address from users where username = ?";
    public static final String DEF_AUTHORITIES_BY_USERNAME_QUERY = "select username,authority from authorities where username = ?";
    public static final String DEF_GROUP_AUTHORITIES_BY_USERNAME_QUERY = "select g.id, g.group_name, ga.authority from groups g, group_members gm, group_authorities ga where gm.username = ? and g.id = ga.group_id and g.id = gm.group_id";
    protected final MessageSourceAccessor messages = SpringSecurityMessageSource.getAccessor();
    private String authoritiesByUsernameQuery = "select username,authority from authorities where username = ?";
    private String groupAuthoritiesByUsernameQuery = "select g.id, g.group_name, ga.authority from groups g, group_members gm, group_authorities ga where gm.username = ? and g.id = ga.group_id and g.id = gm.group_id";
    private String usersByUsernameQuery = "select username,password,enabled,photo,name,surname,patronymic,email,phone,address from users where username = ?";
    private String rolePrefix = "";
    private boolean usernameBasedPrimaryKey = true;
    private boolean enableAuthorities = true;
    private boolean enableGroups;

    public CustomJdbcDaoImpl() {
    }

    protected void addCustomAuthorities(String username, List<GrantedAuthority> authorities) {
    }

    public String getUsersByUsernameQuery() {
        return this.usersByUsernameQuery;
    }

    protected void initDao() throws ApplicationContextException {
        Assert.isTrue(this.enableAuthorities || this.enableGroups, "Use of either authorities or groups must be enabled");
    }

    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        List users = this.loadUsersByUsername(username);
        if(users.size() == 0) {
            this.logger.debug("Query returned no results for user \'" + username + "\'");
            throw new UsernameNotFoundException(this.messages.getMessage("CustomJdbcDaoImpl.notFound", new Object[]{username}, "Username {0} not found"));
        } else {
            UserDetails user = (UserDetails)users.get(0);
            HashSet dbAuthsSet = new HashSet();
            if(this.enableAuthorities) {
                dbAuthsSet.addAll(this.loadUserAuthorities(user.getUsername()));
            }

            if(this.enableGroups) {
                dbAuthsSet.addAll(this.loadGroupAuthorities(user.getUsername()));
            }

            ArrayList dbAuths = new ArrayList(dbAuthsSet);
            this.addCustomAuthorities(user.getUsername(), dbAuths);
            if(dbAuths.size() == 0) {
                this.logger.debug("User \'" + username + "\' has no authorities and will be treated as \'not found\'");
                throw new UsernameNotFoundException(this.messages.getMessage("CustomJdbcDaoImpl.noAuthority", new Object[]{username}, "User {0} has no GrantedAuthority"));
            } else {
                return this.createUserDetails(username, user, dbAuths);
            }
        }
    }
    protected List<UserDetails> loadUsersByUsername(String username) {
        return this.getJdbcTemplate().query(this.usersByUsernameQuery, new String[]{username}, new RowMapper() {
            public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
                String username = rs.getString(1);
                String password = rs.getString(2);
                boolean enabled = rs.getBoolean(3);
                String photo = rs.getString(4);
                String firstName = rs.getString(5);
                String lastName = rs.getString(6);
                String patronymic = rs.getString(7);
                String email = rs.getString(8);
                String phone = rs.getString(9);
                String address = rs.getString(10);

                String name = constructName(lastName, firstName, patronymic);
                return new CustomUser(username, password, enabled, true, true, true, AuthorityUtils.NO_AUTHORITIES,
                        photo, name, email, phone, address);
            }
        });
    }

    private String constructName(String lastName, String firstName, String patronymic) {
        String name = "";

        if (!StringUtils.isEmpty(lastName)) {
            name = lastName;
        }
        if (!StringUtils.isEmpty(firstName)) {
            name = name.equals("") ? firstName : name.concat(" " + firstName);
        }
        if (!StringUtils.isEmpty(patronymic)) {
            name = name.equals("") ? patronymic : name.concat(" " + patronymic);
        }

        return name;
    }

    protected List<GrantedAuthority> loadUserAuthorities(String username) {
        return this.getJdbcTemplate().query(this.authoritiesByUsernameQuery, new String[]{username}, new RowMapper() {
            public GrantedAuthority mapRow(ResultSet rs, int rowNum) throws SQLException {
                String roleName = CustomJdbcDaoImpl.this.rolePrefix + rs.getString(2);
                return new SimpleGrantedAuthority(roleName);
            }
        });
    }

    protected List<GrantedAuthority> loadGroupAuthorities(String username) {
        return this.getJdbcTemplate().query(this.groupAuthoritiesByUsernameQuery, new String[]{username}, new RowMapper() {
            public GrantedAuthority mapRow(ResultSet rs, int rowNum) throws SQLException {
                String roleName = CustomJdbcDaoImpl.this.getRolePrefix() + rs.getString(3);
                return new SimpleGrantedAuthority(roleName);
            }
        });
    }

    protected UserDetails createUserDetails(String username, UserDetails userFromUserQuery, List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();
        if(!this.usernameBasedPrimaryKey) {
            returnUsername = username;
        }

        String photo = null;
        String name = null;
        String email = null;
        String phone = null;
        String address = null;
        if(userFromUserQuery instanceof CustomUser) {
            CustomUser customUser = (CustomUser) userFromUserQuery;

            photo = customUser.getPhoto();
            name = customUser.getName();
            email = customUser.getEmail();
            phone = customUser.getPhone();
            address = customUser.getAddress();
        }

        return new CustomUser(returnUsername, userFromUserQuery.getPassword(), userFromUserQuery.isEnabled(), true, true, true, combinedAuthorities,
                photo, name, email, phone, address);
    }

    public void setAuthoritiesByUsernameQuery(String queryString) {
        this.authoritiesByUsernameQuery = queryString;
    }

    protected String getAuthoritiesByUsernameQuery() {
        return this.authoritiesByUsernameQuery;
    }

    public void setGroupAuthoritiesByUsernameQuery(String queryString) {
        this.groupAuthoritiesByUsernameQuery = queryString;
    }

    public void setRolePrefix(String rolePrefix) {
        this.rolePrefix = rolePrefix;
    }

    protected String getRolePrefix() {
        return this.rolePrefix;
    }

    public void setUsernameBasedPrimaryKey(boolean usernameBasedPrimaryKey) {
        this.usernameBasedPrimaryKey = usernameBasedPrimaryKey;
    }

    protected boolean isUsernameBasedPrimaryKey() {
        return this.usernameBasedPrimaryKey;
    }

    public void setUsersByUsernameQuery(String usersByUsernameQueryString) {
        this.usersByUsernameQuery = usersByUsernameQueryString;
    }

    protected boolean getEnableAuthorities() {
        return this.enableAuthorities;
    }

    public void setEnableAuthorities(boolean enableAuthorities) {
        this.enableAuthorities = enableAuthorities;
    }

    protected boolean getEnableGroups() {
        return this.enableGroups;
    }

    public void setEnableGroups(boolean enableGroups) {
        this.enableGroups = enableGroups;
    }
}
