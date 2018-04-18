package com.springapp.mvc.dao;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.model.Product;

import java.util.List;

public interface MobileDao {

    void addMobile(Mobile mobile) throws ConstraintException;

    void removeMobile(int id);

    Mobile getMobileById(int id);

    void updateMobile(Mobile mobile) throws ConstraintException;

    long numberOfMatchesByName(String name);

    List<Mobile> listMobilesByIds(List<Integer> idList);

    long numberOfMatchesFiltered(QueryFilter filter);

    List<Mobile> listMobilesFiltered(QueryFilter mobileFilter, String sortMode, int offset, int count);

    void fillOptions(List<CriteriaOption> options);

    List<Product> listMobilesByName(String name, int offset, int count);

}
