package com.springapp.mvc.dao;

import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.dto.ProductSalesDto;
import com.springapp.mvc.dto.SaleDto;
import com.springapp.mvc.dto.UserSalesDto;
import com.springapp.mvc.model.Order;
import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SalesDaoImpl implements SalesDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public long userSalesMatches(QueryFilter filter) {
        Session session = this.sessionFactory.getCurrentSession();

        SQLQuery query = session.createSQLQuery("SELECT count(distinct o.manager) " +
                "FROM ishop.orders as o " + filter.getWhereQuery() );

        filter.fillParameters(query);

        Object obj = query.uniqueResult();
        return obj != null ? ((BigInteger) obj).longValue() : 0;
    }

    @Override
    public long productSalesMatches(QueryFilter filter) {
        Session session = this.sessionFactory.getCurrentSession();

        SQLQuery query = session.createSQLQuery("SELECT count(distinct i.product_id) " +
                " FROM ishop.order_items as i " +
                " LEFT JOIN ishop.products as p on i.product_id = p.product_id " +
                " LEFT JOIN ishop.orders as o on i.order_id = o.order_id " + filter.getWhereQuery() );

        filter.fillParameters(query);

        Object obj = query.uniqueResult();
        return obj != null ? ((BigInteger) obj).longValue() : 0;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<UserSalesDto> listUserSales(QueryFilter filter, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();

        SQLQuery query = session.createSQLQuery("SELECT o.manager, u.photo, u.name, u.surname, u.patronymic, COUNT(o.manager), SUM(o.total_sum)" +
                " FROM ishop.orders as o" +
                " LEFT JOIN ishop.users as u on o.manager = u.username " + filter.getWhereQuery() +
                " GROUP BY o.manager " +
                " order by SUM(o.total_sum) DESC");

        filter.fillParameters(query);
        query.setFirstResult(offset);
        query.setMaxResults(count);

        List<Object[]> objects = query.list();

        return parseUserSales(objects);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<ProductSalesDto> listProductSales(QueryFilter filter, int offset, int count) {

        Session session = this.sessionFactory.getCurrentSession();

        SQLQuery query = session.createSQLQuery("SELECT i.product_id, p.name, p.type, p.preview, sum(i.count) as quantity, sum(i.realized_price * i.count) as realized_sum " +
                " FROM ishop.order_items as i" +
                " LEFT JOIN ishop.products as p on i.product_id = p.product_id" +
                " LEFT JOIN ishop.orders as o on i.order_id = o.order_id " + filter.getWhereQuery() +
                " GROUP BY i.product_id " +
                " ORDER BY realized_sum DESC");

        filter.fillParameters(query);
        query.setFirstResult(offset);
        query.setMaxResults(count);

        List<Object[]> objects = query.list();

        return parseProductSales(objects);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<SaleDto> listSalesByProductId(int id, String dateStart, String dateEnd) {
        Session session = this.sessionFactory.getCurrentSession();

        SQLQuery query = session.createSQLQuery("SELECT (i.realized_price * i.count), o.date_deal " +
                " FROM ishop.order_items as i " +
                " LEFT JOIN ishop.orders as o on i.order_id = o.order_id " +
                " WHERE i.product_id = :product_id and o.state=" + Order.STATE_COMPLETED +
                " and o.date_deal between STR_TO_DATE(:dateStart, '%d.%m.%Y %H:%i:%s') and STR_TO_DATE(:dateEnd, '%d.%m.%Y %H:%i:%s') ");

        query.setParameter("product_id", id);
        query.setParameter("dateStart", dateStart.concat(" 00:00:00"));
        query.setParameter("dateEnd", dateEnd.concat(" 23:59:59"));

        List<Object[]> objects = query.list();

        List<SaleDto> sales = new ArrayList<>();
        for (Object[] o : objects) {
            SaleDto s = new SaleDto();
            s.setTotalSum( (BigDecimal) o[0] );
            s.setDateDeal( (Timestamp) o[1]);

            sales.add(s);
        }

        return sales;
    }

    @Override
    public List<SaleDto> listSalesByType(String type, String dateStart, String dateEnd) {
        Session session = this.sessionFactory.getCurrentSession();

        String typeExpression = "";
        if (!StringUtils.isEmpty(type)) {
            typeExpression = " and p.type = :type ";
        }

        SQLQuery query = session.createSQLQuery("SELECT i.order_id, (i.realized_price * i.count), o.date_deal  " +
                " FROM ishop.orders as o " +
                " LEFT JOIN ishop.order_items as i on o.order_id = i.order_id " +
                " LEFT JOIN ishop.products as p on i.product_id = p.product_id " +
                " WHERE o.state=" + Order.STATE_COMPLETED + typeExpression +
                " and o.date_deal between STR_TO_DATE(:dateStart, '%d.%m.%Y %H:%i:%s') and STR_TO_DATE(:dateEnd, '%d.%m.%Y %H:%i:%s') ");

        if (!StringUtils.isEmpty(type)) {
            query.setParameter("type", type);
        }

        query.setParameter("dateStart", dateStart.concat(" 00:00:00"));
        query.setParameter("dateEnd", dateEnd.concat(" 23:59:59"));

        List<Object[]> objects = query.list();

        List<SaleDto> sales = new ArrayList<>();
        for (Object[] o : objects) {
            SaleDto s = new SaleDto();
            s.setTotalSum( (BigDecimal) o[1] );
            s.setDateDeal( (Timestamp) o[2]);

            sales.add(s);
        }

        return sales;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<SaleDto> listSalesByUsername(String username, String dateStart, String dateEnd) {

        Session session = this.sessionFactory.getCurrentSession();

        SQLQuery query = session.createSQLQuery("SELECT o.total_sum, o.date_deal" +
                " FROM ishop.orders as o" +
                " WHERE o.state=" + Order.STATE_COMPLETED + " and o.manager=:username" +
                " and o.date_deal between STR_TO_DATE(:dateStart, '%d.%m.%Y %H:%i:%s') and STR_TO_DATE(:dateEnd, '%d.%m.%Y %H:%i:%s') ");

        query.setParameter("username", username);
        query.setParameter("dateStart", dateStart.concat(" 00:00:00"));
        query.setParameter("dateEnd", dateEnd.concat(" 23:59:59"));

        List<Object[]> objects = query.list();

        List<SaleDto> sales = new ArrayList<>();
        for (Object[] o : objects) {
            SaleDto s = new SaleDto();
            s.setTotalSum( (BigDecimal) o[0] );
            s.setDateDeal( (Timestamp) o[1]);

            sales.add(s);
        }

        return sales;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<UserSalesDto> listTopUsers(int month, int year) {

        Session session = this.sessionFactory.getCurrentSession();

        SQLQuery query = session.createSQLQuery("SELECT o.manager, u.photo, u.name, u.surname, u.patronymic, COUNT(o.manager), SUM(o.total_sum)" +
                " FROM ishop.orders as o" +
                " LEFT JOIN ishop.users as u on o.manager = u.username " +
                " WHERE o.state=" + Order.STATE_COMPLETED + " and YEAR(o.date_deal) = :year and MONTH(o.date_deal) = :month " +
                " GROUP BY o.manager " +
                " order by SUM(o.total_sum) DESC");

        query.setParameter("year", year);
        query.setParameter("month", month + 1);
        query.setMaxResults(5);

        List<Object[]> objects = query.list();

        return parseUserSales(objects);
    }

    private List<UserSalesDto> parseUserSales(List<Object[]> objects) {
        List<UserSalesDto> userSales = new ArrayList<>();
        for (Object[] o : objects) {
            UserSalesDto s = new UserSalesDto();
            s.setUsername( (String) o[0] );
            s.setPhoto( (String) o[1] );
            s.setName( (String) o[2] );
            s.setSurname( (String) o[3] );
            s.setPatronymic( (String) o[4] );
            s.setQuantity( ((BigInteger)o[5]).intValue() );
            s.setTotalSum( (BigDecimal)o[6] );

            userSales.add(s);
        }

        return userSales;
    }

    private List<ProductSalesDto> parseProductSales(List<Object[]> objects) {
        List<ProductSalesDto> productSales = new ArrayList<>();
        for (Object[] o : objects) {
            ProductSalesDto s = new ProductSalesDto();
            s.setId( Integer.parseInt( (String) o[0]) );
            s.setName( (String) o[1] );
            s.setType( (String) o[2] );
            s.setPreview( (String) o[3] );
            s.setQuantity( ((BigDecimal)o[4]).intValue() );
            s.setTotalSum( (BigDecimal)o[5] );

            productSales.add(s);
        }

        return productSales;
    }
}