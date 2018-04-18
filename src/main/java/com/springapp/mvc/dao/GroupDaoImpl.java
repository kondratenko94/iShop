package com.springapp.mvc.dao;

import com.springapp.mvc.model.Group;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GroupDaoImpl implements GroupDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Group getGroupByName(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("FROM Group g where g.name = :name");
        query.setParameter("name", name);
        query.setMaxResults(1);

        return (Group) query.uniqueResult();
    }
}