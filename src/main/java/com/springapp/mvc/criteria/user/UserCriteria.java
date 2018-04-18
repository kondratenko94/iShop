package com.springapp.mvc.criteria.user;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

import java.util.ArrayList;
import java.util.List;

public class UserCriteria {

    public static List<Criterion> getCriterions(String input) {

        List<Criterion> criterions = new ArrayList<>();

        criterions.add( Restrictions.like("username", input, MatchMode.START) );
        criterions.add( Restrictions.like("phone", input, MatchMode.START) );
        criterions.add( Restrictions.like("email", input, MatchMode.START) );

        criterions.add( Restrictions.like("name", input, MatchMode.START) );
        criterions.add( Restrictions.like("surname", input, MatchMode.START) );
        criterions.add( Restrictions.like("patronymic", input, MatchMode.START) );
        criterions.add( Restrictions.like("address", input, MatchMode.ANYWHERE) );

        return criterions;
    }

}