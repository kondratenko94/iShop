package com.springapp.mvc.dao;

import com.springapp.mvc.model.Group;

public interface GroupDao {

    Group getGroupByName(String name);

}