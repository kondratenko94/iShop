package com.springapp.mvc.service;

import com.springapp.mvc.criteria.order.OrderCriteria;
import com.springapp.mvc.dao.OrderDao;
import com.springapp.mvc.dto.MessageDto;
import com.springapp.mvc.dto.OrderDto;
import com.springapp.mvc.dto.OrderItemDto;
import com.springapp.mvc.model.Order;
import com.springapp.mvc.model.OrderItem;
import com.springapp.mvc.model.Product;
import com.springapp.mvc.model.User;
import com.springapp.mvc.dto.PaginationWrapper;
import org.hibernate.ObjectNotFoundException;
import org.hibernate.criterion.Criterion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao orderDao;

    @Override
    @Transactional
    public Integer addOrder(OrderDto orderDto) {

        Order order = orderDto.produceOrder();
        order.setState( Order.STATE_OPENED );
        order.setDateReceived(Calendar.getInstance());

        this.orderDao.addOrder(order);

        return order.getId();
    }

    @Override
    @Transactional
    public OrderDto getOrderDtoById(Integer id) {
        Order order = this.orderDao.getOrderById(id);
        if (order != null) {
            return new OrderDto(order);
        }
        return null;
    }

    @Override
    @Transactional
    public boolean acceptOrder(User user, Integer orderId) {

        Order order = this.orderDao.getOrderById(orderId);

        if (order.getManager() == null) {
            order.setManager(user);
            order.setDateAccepted( Calendar.getInstance() );
            order.setState( Order.STATE_ACCEPTED );
            this.orderDao.updateOrder(order);

            return true;
        }

        return false;
    }

    @Override
    @Transactional
    public boolean acceptValidation(boolean decision, Integer id, String commentary, String username) {

        Order order = this.orderDao.getOrderById(id);
        if ( order != null && ( order.getState().equals( Order.STATE_ACCEPTED ) ) ) {
            if (order.getManager().getUsername().equals(username)) {
                Integer state;

                if (decision) {
                    state = Order.STATE_IN_PROCESS;
                } else {
                    state = Order.STATE_INVALID;
                    String message = StringUtils.isEmpty(commentary) ? "Некорректные данные." : "\nНекорректные данные.";
                    commentary = commentary.concat(message);
                }

                order.setState(state);
                order.setCommentary(commentary);
                this.orderDao.updateOrder(order);

                return true;
            }
        }

        return false;
    }

    @Override
    @Transactional
    public MessageDto assignDeal(Integer id, String address, Calendar dealDate, String commentary, String username) {

        Order order = this.orderDao.getOrderById(id);
        if (order != null && ( order.getState().equals( Order.STATE_IN_PROCESS ) ) ) {

            if (order.getManager().getUsername().equals(username)) {
                Integer state = Order.STATE_DEAL;

                order.setState(state);
                order.setMeetingPoint(address);
                order.setDateDeal(dealDate);
                order.setCommentary(commentary);
                this.orderDao.updateOrder(order);

                return new MessageDto("Сделка успешно <b>назначена</b>.", true);
            }
        }

        return new MessageDto("Вы указали некорректные <b>данные</b>.", false);
    }

    @Override
    @Transactional
    public MessageDto deferDeal(Integer id, String commentary, String username) {
        Order order = this.orderDao.getOrderById(id);
        if (order != null && ( order.getState().equals( Order.STATE_DEAL ) ) ) {

            if (order.getManager().getUsername().equals(username)) {
                Integer state = Order.STATE_IN_PROCESS;

                order.setState(state);
                order.setCommentary(commentary);
                this.orderDao.updateOrder(order);

                return new MessageDto("Сделка <b>отложена</b>.", true);
            }
        }

        return new MessageDto("Вы указали некорректные <b>данные</b>.", false);
    }

    @Override
    @Transactional
    public MessageDto finishDeal(Integer id, String commentary, String username) {

        Order order = this.orderDao.getOrderById(id);
        if (order != null && ( order.getState().equals( Order.STATE_DEAL ) ) ) {

            if (order.getManager().getUsername().equals(username)) {
                try {
                    for (OrderItem item : order.getItems()) {
                        item.getProduct().getPrice();
                    }
                } catch (ObjectNotFoundException e) {
                    return new MessageDto("Необходимо удалить все <b>пустые</b> товары.", false);
                }

                Integer state = Order.STATE_COMPLETED;

                order.setState(state);
                order.setCommentary(commentary);

                BigDecimal totalSum = BigDecimal.ZERO;
                for (OrderItem item : order.getItems()) {
                    item.setPrice( item.getProduct().getPrice() );

                    BigDecimal price = item.getProduct().getPrice();
                    BigDecimal count = BigDecimal.valueOf(item.getCount());

                    totalSum = totalSum.add( price.multiply(count) );
                }
                order.setTotalSum(totalSum);

                this.orderDao.updateOrder(order);

                return new MessageDto("Сделка успешно <b>завершена</b>.", true);
            }
        }


        return new MessageDto("Вы указали некорректные <b>данные</b>.", false);
    }

    @Override
    @Transactional
    public MessageDto lockDeal(Integer id, String commentary, String reason, String username) {

        Order order = this.orderDao.getOrderById(id);
        if (order != null && (order.getState() >= Order.STATE_OPENED) ) {

            if (order.getManager().getUsername().equals(username)) {
                Integer state = Order.STATE_REJECTED;
                String message = StringUtils.isEmpty(commentary) ? ("Отказано : " + reason) : ("\nОтказано : " + reason);
                commentary = commentary.concat(message);

                order.setState(state);
                order.setCommentary(commentary);
                this.orderDao.updateOrder(order);
                return new MessageDto("Заказ успешно <b>отклонен</b>.", true);
            }
        }

        return new MessageDto("Вы указали некорректные <b>данные</b>.", false);
    }

    @Override
    @Transactional
    public MessageDto unlockDeal(Integer id, String username) {
        Order order = this.orderDao.getOrderById(id);
        if (order != null && (order.getState() < Order.STATE_OPENED) ) {

            if (order.getManager().getUsername().equals(username)) {
                Integer state = Order.STATE_IN_PROCESS;

                order.setState(state);
                this.orderDao.updateOrder(order);
                return new MessageDto("Заказ успешно <b>разблокирован</b>.", true);
            }
        }

        return new MessageDto("Вы указали некорректные <b>данные</b>.", false);
    }

    @Override
    @Transactional
    public MessageDto updateProducts(OrderDto orderDto, String username) {

        Order order = this.orderDao.getOrderById( orderDto.getId() );
        if (order != null) {

            if (order.getManager().getUsername().equals(username)) {

                if (order.getState().equals(Order.STATE_IN_PROCESS) || order.getState().equals(Order.STATE_DEAL)) {

                    List<OrderItem> items = order.getItems();
                    List<OrderItemDto> productsDto = orderDto.getProducts();

                    if ( productsDto.size() > 0 ) {

                        List<OrderItem> deletedItems = new ArrayList<>();

                        for (OrderItem item : items) {
                            boolean contains = false;
                            for (OrderItemDto product : productsDto) {
                                if (item.getProduct().getId().equals(product.getProductId())) {
                                    item.setCount( product.getCount() );
                                    contains = true;
                                    break;
                                }
                            }

                            if (!contains) {
                                deletedItems.add(item);
                            }
                        }

                        for (OrderItem deletedItem : deletedItems) {
                            items.remove( deletedItem );
                        }

                        for (OrderItemDto product : productsDto) {
                            boolean contains = false;
                            for (OrderItem item : items) {
                                if (item.getProduct().getId().equals(product.getProductId())) {
                                    contains = true;
                                    break;
                                }
                            }

                            if (!contains) {
                                OrderItem orderItem = new OrderItem();

                                Product p = new Product();
                                p.setId( product.getProductId() );
                                orderItem.setProduct(p);
                                orderItem.setCount( product.getCount() );
                                orderItem.setOrder(order);

                                items.add(orderItem);
                            }
                        }

                        this.orderDao.updateOrder(order);
                        return new MessageDto("Товары успешно <b>обновлены</b>.", true);

                    } else {
                        return new MessageDto("Укажите хотя бы <b>один</b> товар.", false);
                    }
                }

            } else {
                return new MessageDto("Недостаточно прав для выполнения <b>действия</b>.", false);
            }
        }


        return new MessageDto("Вы указали некорректные <b>данные</b>.", false);
    }

    @Override
    @Transactional
    public PaginationWrapper<OrderDto> getOrdersDto(Integer status, Integer state, Integer page, int count) {
        Criterion criterion = OrderCriteria.buildCriterion(status, state, null, null, null);

        long matches = this.orderDao.numberOfMatches(criterion);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        List<Order> orders = this.orderDao.listOrders(criterion, null, offset, count);

        List<OrderDto> ordersDto = new ArrayList<>();
        for (Order order : orders) {
            OrderDto orderDto = new OrderDto(order);
            ordersDto.add( orderDto );
        }

        PaginationWrapper<OrderDto> pagWrapper = new PaginationWrapper<>();
        pagWrapper.setList(ordersDto);
        pagWrapper.setCount(count);
        pagWrapper.setMaxCount(matches);

        return pagWrapper;
    }

    @Override
    @Transactional
    public PaginationWrapper<OrderDto> getOrdersDtoByUser(Integer status, Integer state, Integer page, int count, String username) {
        Criterion criterion = OrderCriteria.buildCriterion(status, state, null, null, username);

        long matches = this.orderDao.numberOfMatches(criterion);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        List<Order> orders = this.orderDao.listOrders(criterion, OrderCriteria.DATE_ACCEPTED, offset, count);

        List<OrderDto> ordersDto = new ArrayList<>();
        for (Order order : orders) {
            OrderDto orderDto = new OrderDto(order);
            ordersDto.add( orderDto );
        }

        PaginationWrapper<OrderDto> pagWrapper = new PaginationWrapper<>();
        pagWrapper.setList(ordersDto);
        pagWrapper.setCount(count);
        pagWrapper.setMaxCount(matches);

        return pagWrapper;
    }

    @Override
    @Transactional
    public PaginationWrapper<OrderDto> getOrdersDtoByInput(Integer status, Integer state, Integer page, int count, String username, String email, String phone) {

        Criterion criterion = OrderCriteria.buildCriterion(status, state, email, phone, username);

        long matches = this.orderDao.numberOfMatches(criterion);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        List<Order> orders = this.orderDao.listOrders(criterion, "id", offset, count);

        List<OrderDto> ordersDto = new ArrayList<>();
        for (Order order : orders) {
            OrderDto orderDto = new OrderDto(order);
            ordersDto.add( orderDto );
        }

        PaginationWrapper<OrderDto> pagWrapper = new PaginationWrapper<>();
        pagWrapper.setList(ordersDto);
        pagWrapper.setCount(count);
        pagWrapper.setMaxCount(matches);

        return pagWrapper;
    }

    @Override
    @Transactional
    public PaginationWrapper<OrderDto> getFinishedOrdersDto(String username, String dateStart, String dateEnd, int page, int count) {

        SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
        Calendar start = Calendar.getInstance();
        Calendar end = Calendar.getInstance();

        try {
            start.setTime(sdf.parse(dateStart.concat(" 00:00:00")));
            end.setTime(sdf.parse(dateEnd.concat(" 23:59:59")));
        } catch (ParseException e) {
            return new PaginationWrapper<>();
        }

        Criterion criterion = OrderCriteria.byNameStatePeriod(username, Order.STATE_COMPLETED, start, end);

        long matches = this.orderDao.numberOfMatches(criterion);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        List<Order> orders = this.orderDao.listOrders(criterion, OrderCriteria.DATE_ACCEPTED, offset, count);

        List<OrderDto> ordersDto = new ArrayList<>();
        for (Order order : orders) {
            OrderDto orderDto = new OrderDto(order);
            ordersDto.add( orderDto );
        }

        return new PaginationWrapper<>(ordersDto, count, matches);
    }

    @Override
    @Transactional
    public List<OrderDto> getTasksByUsername(String username) {

        List<Order> orders = this.orderDao.getTasksByUsername(username);

        List<OrderDto> ordersDto = new ArrayList<>();
        for (Order order : orders) {
            OrderDto orderDto = new OrderDto(order);
            ordersDto.add( orderDto );
        }
        return ordersDto;
    }


}