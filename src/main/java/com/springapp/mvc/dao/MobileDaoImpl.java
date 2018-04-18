package com.springapp.mvc.dao;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.QueryParameter;
import com.springapp.mvc.criteria.QueryParameterList;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.exception.database.mobile.MobileNameUniqueException;
import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.model.Product;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Qualifier("mobileDaoImpl")
public class MobileDaoImpl implements MobileDao {

    private SessionFactory sessionFactory;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory){
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addMobile(Mobile mobile) throws ConstraintException {
        Session session = sessionFactory.getCurrentSession();
        try {
            session.persist(mobile);
            session.flush();
        } catch (ConstraintViolationException exc) {

            session.clear();
            if (!isUniqueNameInDatabase( mobile.getName() )) {
                throw new MobileNameUniqueException();
            }
            throw exc;
        }
    }

    @Override
    public void removeMobile(int id) {
        Session session = sessionFactory.getCurrentSession();
        Mobile mobile = (Mobile) session.get(Mobile.class, id);

        if (mobile != null) {
            session.delete(mobile);
        }
    }

    @Override
    public Mobile getMobileById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        return (Mobile) session.get(Mobile.class, id);
    }

    @Override
    public void updateMobile(Mobile mobile) throws ConstraintException {
        Session session = this.sessionFactory.getCurrentSession();
        try {
            session.update(mobile);
            session.flush();
        } catch (ConstraintViolationException exc) {

            session.clear();
            if (!isUniqueNameInDatabase( mobile.getName() )) {
                throw new MobileNameUniqueException();
            }
            throw exc;
        }
    }

    @Override
    public long numberOfMatchesByName(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count(*) from Mobile m where m.name like :name");
        query.setParameter("name", "%" + name + "%");

        Object obj = query.uniqueResult();
        return obj != null ? (long) obj : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Mobile> listMobilesByIds(List<Integer> idList) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Mobile m WHERE m.id IN (:ids)");
        query.setParameterList("ids", idList);

        return query.list();
    }

    @Override
    public long numberOfMatchesFiltered(QueryFilter filter) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count (*) " +
                " from  Mobile m " + filter.getWhereQuery());

        filter.fillParameters(query);

        Object obj = query.uniqueResult();
        return obj != null ? (long) obj : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Mobile> listMobilesFiltered(QueryFilter filter, String sortMode, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Mobile " + filter.getWhereQuery() + sortMode);

        filter.fillParameters(query);

        query.setFirstResult(offset);
        query.setMaxResults(count);

        return query.list();
    }

    @Override
    @SuppressWarnings("unchecked")
    public void fillOptions(List<CriteriaOption> options) {
        Session session = sessionFactory.getCurrentSession();

        for (CriteriaOption option : options) {
            if (option.getType() == CriteriaOption.Category.LIST) {
                String name = option.getName();

                List<String> valuesList = session.createQuery("select distinct " + name + " from Mobile " +
                        "where " + name + " <> '' " +
                        "order by " + name + " asc").list();

                option.setCheckBoxList(valuesList);
            }
        }
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> listMobilesByName(String name, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Mobile m where m.name like :name");
        query.setParameter("name", "%" + name + "%");
        query.setFirstResult(offset);
        query.setMaxResults(count);

        return query.list();
    }

    boolean isUniqueNameInDatabase(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select 1 from Product p where p.name = :name");
        query.setParameter("name", name);

        return (query.uniqueResult() == null);
    }
}
