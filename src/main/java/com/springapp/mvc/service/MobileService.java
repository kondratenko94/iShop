package com.springapp.mvc.service;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.mobile.MobileCriteria;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.dto.PaginationWrapper;

import java.util.List;

public interface MobileService {

    Integer addMobile(Mobile mobile) throws ConstraintException;

    void removeMobile(int id);

    Mobile getMobileById(int id);

    void updateMobile(Mobile mobile) throws ConstraintException;

    List<Mobile> listMobilesByIds(List<Integer> idList);

    PaginationWrapper<Mobile> listMobilesFiltered(MobileCriteria mobileCriteria, String sortMode, Integer page, int count);

    List<CriteriaOption> createCriteriaOptions();

}
