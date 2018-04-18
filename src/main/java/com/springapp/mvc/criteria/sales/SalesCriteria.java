package com.springapp.mvc.criteria.sales;

import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.QueryParameter;
import com.springapp.mvc.model.Order;
import org.springframework.util.StringUtils;

import java.util.HashSet;
import java.util.Set;

public class SalesCriteria {

    public static QueryFilter createFilter(String username, String dateStart, String dateEnd) {

        StringBuilder whereQuery = new StringBuilder(" where ");
        Set<QueryParameter> parameters = new HashSet<>();

        whereQuery.append(" o.state=").append(Order.STATE_COMPLETED).append(" ");

        if (!StringUtils.isEmpty(username)) {
            whereQuery.append(" and o.manager like :username");
            parameters.add( new QueryParameter("username", "%" + username + "%" ) );
        }
        if (!StringUtils.isEmpty(dateStart)) {
            whereQuery.append(" and o.date_deal >=  STR_TO_DATE(:dateStart, '%d.%m.%Y %H:%i:%s')");
            parameters.add( new QueryParameter("dateStart", dateStart.concat(" 00:00:00") ) );
        }
        if (!StringUtils.isEmpty(dateEnd)) {
            whereQuery.append(" and o.date_deal <= STR_TO_DATE(:dateEnd, '%d.%m.%Y %H:%i:%s')");
            parameters.add( new QueryParameter("dateEnd", dateEnd.concat(" 23:59:59") ) );
        }

        return new QueryFilter( whereQuery.toString() , parameters, null);
    }
}