package com.springapp.mvc.service;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.notebook.NotebookCriteria;
import com.springapp.mvc.dto.NotebookDto;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.model.Notebook;

import java.util.List;

public interface NotebookService {

    Integer addNotebook(Notebook notebook) throws ConstraintException;

    void removeNotebook(int id);

    Notebook getNotebookById(int id);

    Integer updateNotebook(Notebook notebook) throws ConstraintException;

    List<Notebook> listNotebooksByIds(List<Integer> idList);

    PaginationWrapper<Notebook> listNotebooksFiltered(NotebookCriteria criteria, String sortMode, Integer page, int count);

    List<CriteriaOption> createCriteriaOptions();

}