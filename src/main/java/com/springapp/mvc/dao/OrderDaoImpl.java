package com.springapp.mvc.dao;

import com.springapp.mvc.model.Order;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OrderDaoImpl implements OrderDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addOrder(Order order) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(order);
    }

    @Override
    public void updateOrder(Order order) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(order);
    }

    @Override
    public Order getOrderById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        return (Order) session.get(Order.class, id);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Order> getTasksByUsername(String username) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Order o " +
                "where o.manager.username = :username and o.state > 0 and o.state < 4 " +
                "order by o.state DESC, o.dateDeal ASC");
        query.setParameter("username", username);
        query.setMaxResults(5);

        return query.list();
    }

    @Override
    @SuppressWarnings("unchecked")
    public long numberOfMatches(Criterion criterion) {
        Session session = this.sessionFactory.getCurrentSession();

        Criteria criteria = session.createCriteria(Order.class)
                .setProjection(Projections.rowCount());

        criteria.add(criterion);

        Object obj = criteria.uniqueResult();
        return obj != null ? (long) obj : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Order> listOrders(Criterion criterion, String sorting, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();

        Criteria criteria = session.createCriteria(Order.class);

        criteria.add(criterion);
        criteria.setFirstResult(offset);
        criteria.setMaxResults(count);
        if (sorting != null) {
            criteria.addOrder(org.hibernate.criterion.Order.desc( sorting ));
        } else {
            criteria.addOrder(org.hibernate.criterion.Order.desc("id"));
        }

        return criteria.list();

    }


}