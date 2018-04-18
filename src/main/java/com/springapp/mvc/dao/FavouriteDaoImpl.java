package com.springapp.mvc.dao;

import com.springapp.mvc.model.FavouriteItem;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class FavouriteDaoImpl implements FavouriteDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public boolean isItemFavourite(String username, Integer productId) {
        Session session = this.sessionFactory.getCurrentSession();

        Query query = session.createQuery("select 1 from FavouriteItem f " +
                "where f.username = :username and f.product.id = :product_id");

        query.setString("username", username);
        query.setInteger("product_id", productId);

        return query.uniqueResult() != null;
    }

    @Override
    public FavouriteItem getFavouriteItem(String username, Integer productId) {

        Session session = this.sessionFactory.getCurrentSession();

        Query query = session.createQuery("from FavouriteItem f " +
                "where f.username = :username and f.product.id = :product_id");

        query.setString("username", username);
        query.setInteger("product_id", productId);
        query.setMaxResults(1);

        Object favouriteItem = query.uniqueResult();

        return favouriteItem != null ? (FavouriteItem) favouriteItem : null;
    }

    @Override
    public void addFavouriteItem(FavouriteItem favouriteItem) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(favouriteItem);
    }

    @Override
    public void removeFavouriteItem(FavouriteItem favouriteItem) {
        Session session = sessionFactory.getCurrentSession();

        if (favouriteItem != null) {
            session.delete(favouriteItem);
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<FavouriteItem> listFavouriteItems(String username, Integer page, Integer count) {

        if (count == null || count < 1) count = 10;
        if (page == null  || page < 1) page = 1;

        Session session =  this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from FavouriteItem f " +
                "where f.username = :username");
        query.setString("username", username);
        query.setFirstResult( page * count - count);
        query.setMaxResults(count);

        return query.list();
    }

    @Override
    public long getFavouritesCountByUsername(String username) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count(*) from FavouriteItem f " +
                "where f.username = :username");
        query.setParameter("username", username);

        Object o = query.uniqueResult();

        return o != null ? (long) o : 0;
    }


}