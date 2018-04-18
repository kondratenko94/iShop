package com.springapp.mvc.dao;

import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.dto.ProductSalesDto;
import com.springapp.mvc.dto.SaleDto;
import com.springapp.mvc.dto.UserSalesDto;

import java.util.List;

public interface SalesDao {

    long userSalesMatches(QueryFilter filter);

    long productSalesMatches(QueryFilter filter);

    List<UserSalesDto> listUserSales(QueryFilter filter, int offset, int count);

    List<ProductSalesDto> listProductSales(QueryFilter filter, int offset, int count);

    List<SaleDto> listSalesByProductId(int id, String dateStart, String dateEnd);

    List<SaleDto> listSalesByType(String type, String dateStart, String dateEnd);

    List<SaleDto> listSalesByUsername(String username, String dateStart, String dateEnd);

    List<UserSalesDto> listTopUsers(int month, int year);

}