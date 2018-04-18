package com.springapp.mvc.dao;

import com.springapp.mvc.model.Product;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProductDaoImpl implements ProductDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Product getProductById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        return (Product) session.get(Product.class, id);

    }

    @Override
    public void removeProduct(int id) {
        Session session = sessionFactory.getCurrentSession();
        Product product = (Product) session.get(Product.class, id);

        if (product != null) {
            session.delete(product);
        }
    }

    @Override
    public long numberOfMatches(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count(*) from Product p where p.name like :name");
        query.setParameter("name", "%" + name + "%");

        Object obj = query.uniqueResult();
        return obj != null ? (long) obj : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> listProductsByName(String name, int start, int count) {

        if (start < 0) start = 0;

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Product p where p.name like :name");
        query.setParameter("name", "%" + name + "%");
        query.setFirstResult(start);
        query.setMaxResults(count);

        return query.list();
    }
}