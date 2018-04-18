package com.springapp.mvc.service;

import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.sales.ProductSalesCriteria;
import com.springapp.mvc.criteria.sales.SalesCriteria;
import com.springapp.mvc.dao.SalesDao;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.dto.ProductSalesDto;
import com.springapp.mvc.dto.SaleDto;
import com.springapp.mvc.dto.UserSalesDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SalesServiceImpl implements SalesService{

    @Autowired
    private SalesDao salesDao;

    @Override
    @Transactional
    public List<SaleDto> listSalesByProductId(int id, String dateStart, String dateEnd) {
        return this.salesDao.listSalesByProductId(id, dateStart, dateEnd);
    }

    @Override
    @Transactional
    public List<SaleDto> listSalesByType(String type, String dateStart, String dateEnd) {
        return this.salesDao.listSalesByType(type, dateStart, dateEnd);
    }

    @Override
    @Transactional
    public List<SaleDto> listSalesByUsername(String username, String dateStart, String dateEnd) {

        return this.salesDao.listSalesByUsername(username, dateStart, dateEnd);
    }

    @Override
    @Transactional
    public PaginationWrapper<UserSalesDto> listUserSales(String username, String dateStart, String dateEnd, int page, int count) {

        QueryFilter filter = SalesCriteria.createFilter(username, dateStart, dateEnd);
        long matches = this.salesDao.userSalesMatches(filter);

        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page < 1 || page > pagesCount) {
            page = 1;
        }

        int offset = (page - 1) * count;

        List<UserSalesDto> sales = this.salesDao.listUserSales(filter, offset, count);

        return new PaginationWrapper<>(sales, count, matches);
    }

    @Override
    @Transactional
    public PaginationWrapper<ProductSalesDto> listProductSales(String name, String type, String dateStart, String dateEnd, int page, int count) {

        QueryFilter filter = ProductSalesCriteria.createFilter(name, type, dateStart, dateEnd);
        long matches = this.salesDao.productSalesMatches(filter);

        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page < 1 || page > pagesCount) {
            page = 1;
        }

        int offset = (page - 1) * count;

        List<ProductSalesDto> productSales = this.salesDao.listProductSales(filter, offset, count);

        return new PaginationWrapper<>(productSales, count, matches);
    }

    @Override
    @Transactional
    public List<UserSalesDto> listTopUsers(int month, int year) {
        return this.salesDao.listTopUsers(month, year);
    }

}