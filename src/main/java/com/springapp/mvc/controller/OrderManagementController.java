package com.springapp.mvc.controller;

import com.springapp.mvc.dto.MessageDto;
import com.springapp.mvc.dto.OrderDto;
import com.springapp.mvc.model.Order;
import com.springapp.mvc.model.User;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.OrderService;
import com.springapp.mvc.dto.PaginationWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@Controller
public class OrderManagementController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @RequestMapping(value = "/management/desktop/", method = RequestMethod.GET)
    public String manageOrders(ModelMap model) {
        model.addAttribute("selectedMenu", "desktop");
        return "/management/orders/desktop";
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/", method = RequestMethod.GET)
    public PaginationWrapper searchOrders(Integer status, Integer state, Integer page, int count) {

        if (count > 100) {
            count = 100;
        }

        PaginationWrapper<OrderDto> pagWrapper = this.orderService.getOrdersDto(status, state, page, count);
        return pagWrapper;
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/{username}", method = RequestMethod.GET)
    public PaginationWrapper searchOrdersByUser(Integer status, Integer state, Integer page, int count,
                                                @PathVariable("username") String username) {
        if (count > 100) {
            count = 100;
        }

        PaginationWrapper<OrderDto> pagWrapper = this.orderService.getOrdersDtoByUser(status, state, page, count, username);
        return pagWrapper;
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/accept", method = RequestMethod.POST)
    public boolean acceptOrder(Integer orderId) {

        User user = this.currentAuthentication.getCurrentUser();

        if ( orderId != null && user != null ) {
            return this.orderService.acceptOrder(user, orderId);
        }

        return false;
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @RequestMapping(value = "/management/tasks/orders/", method = RequestMethod.GET)
    public String userOrders(ModelMap model) {
        model.addAttribute("selectedMenu", "tasks");
        return "/management/orders/orders";
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/search/", method = RequestMethod.GET)
    public PaginationWrapper searchOrders(Integer status, Integer state, Integer page, int count, String username,
                                          String email, String phone) {
        if (count > 100) {
            count = 100;
        }

        PaginationWrapper<OrderDto> paginationWrapper = this.orderService.getOrdersDtoByInput(status, state, page, count, username, email, phone);
        return paginationWrapper;
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/valid/", method = RequestMethod.POST)
    public boolean validateOrder(boolean decision, Integer id, String commentary) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            return this.orderService.acceptValidation(decision, id, commentary, username);
        }

        return false;
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/assign/", method = RequestMethod.POST)
    public MessageDto assignOrder(Integer id, String address, String dealDate, String commentary) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {

            if (StringUtils.isEmpty(address)) {
                return new MessageDto("Вы должны указать <b>адрес доставки</b>.", false);
            }

            if (StringUtils.isEmpty(dealDate)) {
                return new MessageDto("Вы должны указать <b>дату сделки</b>.", false);
            }

            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy HH:mm");
            try {
                calendar.setTime(sdf.parse(dealDate));
            } catch (ParseException e) {
                return new MessageDto("Вы указали <b>некорректную</b> дату!", false);
            }

            long currentTime = Calendar.getInstance().getTimeInMillis();
            long targetTime = calendar.getTimeInMillis();
            if (targetTime <= currentTime) {
                return new MessageDto("Вы указали <b>прошедшую</b> дату!", false);
            }

            return this.orderService.assignDeal(id, address, calendar, commentary, username);
        }

        return new MessageDto("Для выполнения операции необходимо <b<авторизоваться</b>.", false);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/finish/", method = RequestMethod.POST)
    public MessageDto finishOrder(Integer id, String commentary) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            return this.orderService.finishDeal(id, commentary, username);
        }

        return new MessageDto("Для выполнения операции необходимо <b<авторизоваться</b>.", false);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/reject/", method = RequestMethod.POST)
    public MessageDto lockOrder(Integer id, String commentary, String reason) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {

            if (StringUtils.isEmpty(reason)) {
                return new MessageDto("Вы должны указать <b>причину</b> отклонения сделки.", false);
            }

            return this.orderService.lockDeal(id, commentary, reason, username);
        }

        return new MessageDto("Для выполнения операции необходимо <b<авторизоваться</b>.", false);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/unlock/", method = RequestMethod.POST)
    public MessageDto unlockOrder(Integer id) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            return this.orderService.unlockDeal(id, username);
        }

        return new MessageDto("Для выполнения операции необходимо <b<авторизоваться</b>.", false);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/defer/", method = RequestMethod.POST)
    public MessageDto deferOrder(Integer id, String commentary) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            return this.orderService.deferDeal(id, commentary, username);
        }

        return new MessageDto("Для выполнения операции необходимо <b<авторизоваться</b>.", false);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/orders/products/", method = RequestMethod.POST)
    public MessageDto updateProducts(@RequestBody OrderDto orderDto) {

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            return this.orderService.updateProducts(orderDto, username);
        }

        return new MessageDto("Для выполнения операции необходимо <b<авторизоваться</b>.", false);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/tasks/", method = RequestMethod.GET)
    public List<OrderDto> getReminders() {
        String username = this.currentAuthentication.getCurrentUsername();
        return this.orderService.getTasksByUsername(username);
    }

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "/management/tasks/order/", method = RequestMethod.GET)
    public OrderDto getOrder(Integer id) {

        String username = this.currentAuthentication.getCurrentUsername();
        OrderDto orderDto = this.orderService.getOrderDtoById(id);

        if (orderDto != null) {
            if (orderDto.getManager().equals(username)) {
                return orderDto;
            }
        }

        return new OrderDto();
    }
}