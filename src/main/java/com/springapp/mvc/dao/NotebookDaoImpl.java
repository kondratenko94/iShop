package com.springapp.mvc.dao;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.exception.database.notebook.NotebookNameUniqueException;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.model.Product;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NotebookDaoImpl implements NotebookDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addNotebook(Notebook notebook) throws ConstraintException {
        Session session = this.sessionFactory.getCurrentSession();
        try {
            session.persist(notebook);
            session.flush();
        } catch (ConstraintViolationException exc) {

            session.clear();
            if (!isUniqueNameInDatabase( notebook.getName() )) {
                throw new NotebookNameUniqueException();
            }
            throw exc;
        }
    }

    @Override
    public void removeNotebook(int id) {
        Session session = sessionFactory.getCurrentSession();
        Notebook notebook = (Notebook) session.get(Notebook.class, id);

        if (notebook != null) {
            session.delete(notebook);
        }
    }

    @Override
    public Notebook getNotebookById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return (Notebook) session.get(Notebook.class, id);
    }

    @Override
    public void updateNotebook(Notebook notebook) throws ConstraintException{
        Session session = sessionFactory.getCurrentSession();
        try {
            session.update(notebook);
            session.flush();
        } catch (ConstraintViolationException exc) {

            session.clear();
            if (!isUniqueNameInDatabase( notebook.getName() )) {
                throw new NotebookNameUniqueException();
            }
            throw exc;
        }
    }

    @Override
    public long numberOfMatchesByName(String name) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count(*) from Notebook n where n.name like :name");
        query.setParameter("name", "%" + name + "%");

        Object obj = query.uniqueResult();
        return obj != null ? (long) obj : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Notebook> listNotebooksByIds(List<Integer> idList) {
        Session session = sessionFactory.getCurrentSession();

        Query query = session.createQuery("FROM Notebook n WHERE n.id IN (:ids)");
        query.setParameterList("ids", idList);

        return query.list();
    }

    @Override
    public long numberOfMatchesFiltered(QueryFilter filter) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("select count (*) " +
                " from  Notebook n " + filter.getWhereQuery());

        filter.fillParameters(query);

        Object obj = query.uniqueResult();
        return obj != null ? (long) obj : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Notebook> listNotebooksFiltered(QueryFilter filter, String sortMode, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Notebook " + filter.getWhereQuery() + sortMode);

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

                List<String> valuesList = session.createQuery("select distinct " + name + " from Notebook " +
                        "where " + name + " <> '' " +
                        "order by " + name + " asc").list();

                option.setCheckBoxList(valuesList);
            }
        }

    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Product> listNotebooksByName(String name, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createQuery("from Notebook n where n.name like :name");
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