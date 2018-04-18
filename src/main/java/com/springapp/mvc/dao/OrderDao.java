package com.springapp.mvc.dao;

import com.springapp.mvc.model.Order;
import org.hibernate.criterion.Criterion;

import java.util.List;

public interface OrderDao {

    void addOrder(Order order);

    void updateOrder(Order order);

    Order getOrderById(int id);

    List<Order> getTasksByUsername(String username);

    long numberOfMatches(Criterion criterion);

    List<Order> listOrders(Criterion criterion, String sorting, int offset, int count);


}