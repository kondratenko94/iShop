package com.springapp.mvc.service;

import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.dto.ProductSalesDto;
import com.springapp.mvc.dto.SaleDto;
import com.springapp.mvc.dto.UserSalesDto;

import java.util.List;

public interface SalesService {

    List<SaleDto> listSalesByProductId(int id, String dateStart, String dateEnd);

    List<SaleDto> listSalesByType(String type, String dateStart, String dateEnd);

    List<SaleDto> listSalesByUsername(String username, String dateStart, String dateEnd);

    PaginationWrapper<UserSalesDto> listUserSales(String username, String dateStart, String dateEnd, int page, int count);

    PaginationWrapper<ProductSalesDto> listProductSales(String name, String type, String dateStart, String dateEnd, int page, int count);

    List<UserSalesDto> listTopUsers(int month, int year);
}