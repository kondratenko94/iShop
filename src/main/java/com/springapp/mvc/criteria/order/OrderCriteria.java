package com.springapp.mvc.criteria.order;

import com.springapp.mvc.model.Order;
import org.hibernate.criterion.*;
import org.springframework.util.StringUtils;

import java.util.Calendar;

public class OrderCriteria {

    public static final String DATE_ACCEPTED = "dateAccepted";

    public static Criterion buildCriterion(Integer status, Integer state, String email, String phone, String username) {

        Disjunction disjunction = Restrictions.disjunction();

        if (!StringUtils.isEmpty(email)) {
            disjunction.add( Restrictions.eq("email", email) );
        }
        if (!StringUtils.isEmpty(phone)) {
            disjunction.add( Restrictions.eq("phone", phone) );
        }
        if (!StringUtils.isEmpty(username)) {
            disjunction.add( Restrictions.eq("manager.username", username) );
        }

        Conjunction conjunction = Restrictions.conjunction();
        conjunction.add(disjunction);

        if (state != null) {

            if (state == 2) {
                Criterion c1 = Restrictions.eq("state", 2);
                Criterion c2 = Restrictions.eq("state", 3);
                conjunction.add( Restrictions.or(c1, c2) );

            } else {
                conjunction.add( Restrictions.eq("state", state) );
            }

        }

        if (status != null) {

            if (status == 0) {
                Criterion c1 = Restrictions.ge("state", Order.STATE_OPENED);
                Criterion c2 = Restrictions.le("state", Order.STATE_DEAL);
                conjunction.add( Restrictions.and(c1, c2) );

            } else {
                Criterion c1 = Restrictions.lt("state", Order.STATE_OPENED);
                Criterion c2 = Restrictions.gt("state", Order.STATE_DEAL);
                conjunction.add( Restrictions.or(c1, c2) );
            }
        }

        return conjunction;
    }

    public static Criterion byUsernameAndState(String username, Integer state) {

        Conjunction conjunction = Restrictions.conjunction();

        if (!StringUtils.isEmpty(username)) {
            conjunction.add( Restrictions.eq("manager.username", username) );
        }
        if (state != null) {
            conjunction.add( Restrictions.eq("state", state) );
        }

        return conjunction;
    }

    public static Criterion byNameStatePeriod(String username, Integer state, Calendar dateStart, Calendar dateEnd) {

        Conjunction conjunction = Restrictions.conjunction();

        if (!StringUtils.isEmpty(username)) {
            conjunction.add( Restrictions.eq("manager.username", username) );
        }
        if (state != null) {
            conjunction.add( Restrictions.eq("state", state) );
        }
        if (!StringUtils.isEmpty(dateStart)) {
            conjunction.add( Restrictions.ge("dateDeal", dateStart) );
        }
        if (!StringUtils.isEmpty(dateEnd)) {
            conjunction.add( Restrictions.le("dateDeal", dateEnd) );
        }

        return conjunction;
    }

}