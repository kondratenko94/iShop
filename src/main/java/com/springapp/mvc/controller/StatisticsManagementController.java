package com.springapp.mvc.controller;


import com.springapp.mvc.dto.*;
import com.springapp.mvc.service.OrderService;
import com.springapp.mvc.service.SalesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@PreAuthorize("hasRole('ADMIN')")
@Controller
public class StatisticsManagementController {

    @Autowired
    private SalesService salesService;

    @Autowired
    private OrderService orderService;

    @RequestMapping(value = "/management/statistics/users/", method = RequestMethod.GET)
    public String userStatistics(ModelMap model) {
        model.addAttribute("selectedMenu", "stats/users");
        return "/management/stats/users";
    }

    @ResponseBody
    @RequestMapping(value = "/management/statistics/users/sales/", method = RequestMethod.GET)
    public PaginationWrapper<UserSalesDto> getUserSales(String username, int page, int count,
                                                        String dateStart, String dateEnd) {
        if (count > 100) count = 100;
        PaginationWrapper<UserSalesDto> pagWrapper = this.salesService.listUserSales(username, dateStart, dateEnd, page, count);

        return pagWrapper;
    }

    @ResponseBody
    @RequestMapping(value = "management/statistics/users/top/", method = RequestMethod.GET)
    public List<UserSalesDto> getTopUsers(int year, int month) {
        return this.salesService.listTopUsers(year, month);
    }

    @ResponseBody
    @RequestMapping(value = "/management/statistics/users/history/", method = RequestMethod.GET)
    public PaginationWrapper<OrderDto> getUserSalesHistory(String username, String dateStart, String dateEnd,
                                                           int page, int count) {
        if (count > 100) count = 100;
        return this.orderService.getFinishedOrdersDto(username, dateStart, dateEnd, page, count);
    }

    @ResponseBody
    @RequestMapping(value = "/management/statistics/users/sales/{username}", method = RequestMethod.GET)
    public List<SaleDto> getSalesByUsername(@PathVariable("username") String username, String dateStart, String dateEnd) {
        return this.salesService.listSalesByUsername(username, dateStart, dateEnd);
    }


    @RequestMapping(value = "/management/statistics/products/", method = RequestMethod.GET)
    public String productStatistics(ModelMap model) {
        model.addAttribute("selectedMenu", "stats/products");
        return "/management/stats/products";
    }

    @ResponseBody
    @RequestMapping(value = "/management/statistics/products/sales/", method = RequestMethod.GET)
    public PaginationWrapper<ProductSalesDto> getProductSales(String name, String type, int page,
                                                              int count, String dateStart, String dateEnd) {
        if (count > 100) count = 100;
        PaginationWrapper<ProductSalesDto> pagWrapper = this.salesService.listProductSales(name, type, dateStart, dateEnd, page, count);

        return pagWrapper;
    }

    @ResponseBody
    @RequestMapping(value = "/management/statistics/products/sales/{id}", method = RequestMethod.GET)
    public List<SaleDto> getSalesByProduct(@PathVariable("id") int id, String dateStart, String dateEnd) {
        return this.salesService.listSalesByProductId(id, dateStart, dateEnd);
    }

    @ResponseBody
    @RequestMapping(value = "/management/statistics/products/sales/all/", method = RequestMethod.GET)
    public List<SaleDto> getAllSales(String type, String dateStart, String dateEnd) {
        return this.salesService.listSalesByType(type, dateStart, dateEnd);
    }


}