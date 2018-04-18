package com.springapp.mvc.dao;

import com.springapp.mvc.model.User;
import org.hibernate.*;
import org.hibernate.criterion.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@Repository
public class UserDaoImpl implements UserDao{

    private SessionFactory sessionFactory;

    private PasswordEncoder passwordEncoder;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory){
        this.sessionFactory = sessionFactory;
    }

    @Autowired
    public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void addUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(user);

        session.flush();
    }

    @Override
    public void updateUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);
    }

    @Override
    public long numberOfMatches(List<Criterion> criterions, String group) {

        Session session = this.sessionFactory.getCurrentSession();

        Criteria criteria = session.createCriteria(User.class, "user")
                .setProjection(Projections.rowCount());

        if (group != null && !group.equals("")) {
            criteria.createAlias("user.group", "group");
            criteria.add( Restrictions.eq("group.name", group) );
        }


        Disjunction disjunction = Restrictions.disjunction();
        for (Criterion criterion : criterions) {
            disjunction.add(criterion);
        }
        criteria.add(disjunction);


        Object obj = criteria.uniqueResult();
        return obj != null ? (long) obj : 0;

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<User> getUsersByCriterions(List<Criterion> criterions, String group, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();

        Criteria criteria = session.createCriteria(User.class, "user");

        if (group != null && !group.equals("")) {
            criteria.createAlias("user.group", "group");
            criteria.add( Restrictions.eq("group.name", group) );
        }


        Disjunction disjunction = Restrictions.disjunction();
        for (Criterion criterion : criterions) {
            disjunction.add(criterion);
        }

        criteria.add(disjunction);
        criteria.setFirstResult(offset);
        criteria.setMaxResults(count);

        return criteria.list();
    }

    @Override
    public boolean loginExists(String username) {
        Session session = this.sessionFactory.getCurrentSession();

        Query query = session.createQuery("select 1 from User u where u.username = :username");
        query.setString("username", username );

        return (query.uniqueResult() != null);

    }

    @Override
    public boolean emailExists(String email) {
        Session session = this.sessionFactory.getCurrentSession();

        Query query = session.createQuery("select 1 from User u where u.email = :email");
        query.setString("email", email );

        return (query.uniqueResult() != null);
    }

    @Override
    public boolean checkPassword(String username, String password) {

        Session session = this.sessionFactory.getCurrentSession();

        Query query = session.createQuery("select password from User u where u.username = :username");
        query.setParameter("username", username);
        String hashedPassword = (String) query.uniqueResult();

        return passwordEncoder.matches(password, hashedPassword);
    }

    @Override
    public String punishUser(User user, Calendar term) {

        user.setBannedUntil(term);

        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);

        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy, HH:mm");
        return sdf.format(term.getTime());

    }

    @Override
    public String amnestyUser(User user) {

        user.setBannedUntil(null);

        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);

        return "amnestied";

    }

    @Override
    public String enableUser(User user) {
        user.setEnabled(true);
        user.setBannedUntil(null);

        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);

        return "enabled";
    }

    @Override
    public String disableUser(User user) {
        user.setEnabled(false);

        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);

        return "disabled";
    }

    @Override
    public User getUserByUsername(String username) {
        Session session = this.sessionFactory.getCurrentSession();
        return (User) session.get(User.class, username);
    }

    @Override
    public User getUserByEmail(String email) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User u where u.email = :email");
        query.setString("email", email);
        query.setMaxResults(1);

        Object o = query.uniqueResult();
        return (o != null) ? (User)o : null;
    }

    @Override
    public User getUserByToken(String token) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from User u where u.token = :token");
        query.setString("token", token);
        query.setMaxResults(1);

        Object o = query.uniqueResult();
        return (o != null) ? (User)o : null;
    }

}