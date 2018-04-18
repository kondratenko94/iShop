package com.springapp.mvc.criteria.sales;

import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.QueryParameter;
import org.springframework.util.StringUtils;

import java.util.HashSet;
import java.util.Set;

public class ProductSalesCriteria {

    public static QueryFilter createFilter(String name, String type, String dateStart, String dateEnd) {

        StringBuilder whereQuery = new StringBuilder(" where ");
        Set<QueryParameter> parameters = new HashSet<>();

        whereQuery.append(" i.realized_price is not null ");

        if (!StringUtils.isEmpty(name)) {
            whereQuery.append(" and p.name like :name ");
            parameters.add( new QueryParameter("name", "%" + name + "%" ) );
        }
        if (!StringUtils.isEmpty(dateStart)) {
            whereQuery.append(" and o.date_deal >=  STR_TO_DATE(:dateStart, '%d.%m.%Y %H:%i:%s')");
            parameters.add( new QueryParameter("dateStart", dateStart.concat(" 00:00:00") ) );
        }
        if (!StringUtils.isEmpty(dateEnd)) {
            whereQuery.append(" and o.date_deal <= STR_TO_DATE(:dateEnd, '%d.%m.%Y %H:%i:%s')");
            parameters.add( new QueryParameter("dateEnd", dateEnd.concat(" 23:59:59") ) );
        }
        if (!StringUtils.isEmpty(type)) {
            whereQuery.append(" and p.type=:type");
            parameters.add( new QueryParameter("type", type ) );
        }

        return new QueryFilter( whereQuery.toString() , parameters, null);
    }

}