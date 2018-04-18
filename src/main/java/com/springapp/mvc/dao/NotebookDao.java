package com.springapp.mvc.dao;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.model.Product;

import java.util.List;

public interface NotebookDao {

    void addNotebook(Notebook notebook) throws ConstraintException;

    void removeNotebook(int id);

    Notebook getNotebookById(int id);

    void updateNotebook(Notebook notebook) throws ConstraintException;

    long numberOfMatchesByName(String name);

    List<Notebook> listNotebooksByIds(List<Integer> idList);

    long numberOfMatchesFiltered(QueryFilter filter);

    List<Notebook> listNotebooksFiltered(QueryFilter filter, String sortMode, int offset, int count);

    void fillOptions(List<CriteriaOption> options);

    List<Product> listNotebooksByName(String name, int offset, int count);
}