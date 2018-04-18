package com.springapp.mvc.service;

import com.springapp.mvc.dto.MessageDto;
import com.springapp.mvc.dto.OrderDto;
import com.springapp.mvc.model.Order;
import com.springapp.mvc.model.User;
import com.springapp.mvc.dto.PaginationWrapper;

import java.util.Calendar;
import java.util.List;


public interface OrderService {

    Integer addOrder(OrderDto orderDto);

    OrderDto getOrderDtoById(Integer id);

    boolean acceptOrder(User user, Integer orderId);

    boolean acceptValidation(boolean decision, Integer id, String commentary, String username);

    MessageDto assignDeal(Integer id, String address, Calendar dealDate, String commentary, String username);

    MessageDto deferDeal(Integer id, String commentary, String username);

    MessageDto finishDeal(Integer id, String commentary, String username);

    MessageDto lockDeal(Integer id, String commentary, String reason, String username);

    MessageDto unlockDeal(Integer id, String username);

    MessageDto updateProducts(OrderDto orderDto, String username);

    PaginationWrapper<OrderDto> getOrdersDto(Integer status, Integer state, Integer page, int count);

    PaginationWrapper<OrderDto> getOrdersDtoByUser(Integer status, Integer state, Integer page, int count, String username);

    PaginationWrapper<OrderDto> getOrdersDtoByInput(Integer status, Integer state, Integer page, int count, String username, String email, String phone);

    PaginationWrapper<OrderDto> getFinishedOrdersDto(String username, String dateStart, String dateEnd, int page, int count);

    List<OrderDto> getTasksByUsername(String username);
}