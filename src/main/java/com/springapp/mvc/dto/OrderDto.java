package com.springapp.mvc.dto;

import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.model.Order;
import com.springapp.mvc.model.OrderItem;
import com.springapp.mvc.model.Product;
import org.hibernate.ObjectNotFoundException;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class OrderDto {

    private Integer id;

    private String email;

    private String phone;

    private String name;

    private String dateReceived;

    private String dateAccepted;

    private Integer state;

    private String commentary;

    private String meetingPoint;

    private String dateDeal;

    private BigDecimal totalSum;

    private String manager;

    private String managerPhoto;

    private List<OrderItemDto> products;

    private SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy HH:mm");

    public OrderDto() {}

    public OrderDto(Order order) {

        id = order.getId();
        email = order.getEmail();
        phone = order.getPhone();
        name = order.getName();

        dateReceived = extractDate( order.getDateReceived() );
        dateAccepted = extractDate( order.getDateAccepted() );

        state = order.getState();
        commentary = order.getCommentary();
        meetingPoint = order.getMeetingPoint();

        dateDeal = extractDate( order.getDateDeal() );

        totalSum = BigDecimal.ZERO;

        for (OrderItem orderItem : order.getItems()) {

            try {
                if (orderItem.getPrice() != null) {
                    BigDecimal sum = orderItem.getPrice().multiply( BigDecimal.valueOf( orderItem.getCount() ));
                    totalSum = totalSum.add(sum);

                } else {
                    BigDecimal sum = orderItem.getProduct().getPrice().multiply(BigDecimal.valueOf(orderItem.getCount() ));
                    totalSum = totalSum.add(sum);
                }

            } catch (ObjectNotFoundException e) {
                if (orderItem.getPrice() != null) {
                    BigDecimal sum = orderItem.getPrice().multiply(BigDecimal.valueOf(orderItem.getCount() ) );
                    totalSum = totalSum.add(sum);
                }
            }
        }

        if (order.getManager() != null) {
            manager = order.getManager().getUsername();
            managerPhoto = order.getManager().getPhoto();
        }

        products = createList( order.getItems() );
    }

    public Order produceOrder() {

        Order order = new Order();
        order.setId(id);
        order.setName(name);
        order.setEmail(email);
        order.setPhone(phone);
        order.setCommentary(commentary);
        order.setMeetingPoint(meetingPoint);

        List<OrderItem> items = new ArrayList<>();

        for (OrderItemDto p : products) {

            OrderItem item = new OrderItem();
            item.setId( p.getId() );
            item.setCount( p.getCount() );
            item.setOrder(order);

            Product product = new Product();
            product.setId( p.getProductId() );
            item.setProduct(product);

            items.add(item);
        }
        order.setItems(items);

        return order;
    }

    private String extractDate(Calendar calendar) {
        return (calendar != null) ? sdf.format(calendar.getTime()) : "";
    }

    private List<OrderItemDto> createList(List<OrderItem> items) {

        List<OrderItemDto> products = new ArrayList<>();

        for (OrderItem item : items) {

            OrderItemDto product = new OrderItemDto();

            product.setId( item.getId() );
            product.setCount( item.getCount() );

            try {
                product.setName( item.getProduct().getName() );
                product.setType( item.getProduct().getType() );
                product.setProductId(item.getProduct().getId());
                product.setPreview( item.getProduct().getMainScreen() );

                if (item.getPrice() != null) {
                    product.setPrice( item.getPrice() );
                } else {
                    product.setPrice( item.getProduct().getPrice() );
                }

            } catch (ObjectNotFoundException e) {
                product.setName("Товар удален");
                product.setPrice( item.getPrice() );
                product.setType(Mobile.TYPE);
                product.setProductId(null);
                product.setPreview("");
            }

            products.add( product );
        }

        return products;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDateReceived() {
        return dateReceived;
    }

    public void setDateReceived(String dateReceived) {
        this.dateReceived = dateReceived;
    }

    public String getDateAccepted() {
        return dateAccepted;
    }

    public void setDateAccepted(String dateAccepted) {
        this.dateAccepted = dateAccepted;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getCommentary() {
        return commentary;
    }

    public void setCommentary(String commentary) {
        this.commentary = commentary;
    }

    public String getMeetingPoint() {
        return meetingPoint;
    }

    public void setMeetingPoint(String meetingPoint) {
        this.meetingPoint = meetingPoint;
    }

    public String getDateDeal() {
        return dateDeal;
    }

    public void setDateDeal(String dateDeal) {
        this.dateDeal = dateDeal;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getTotalSum() {
        return totalSum;
    }

    public void setTotalSum(BigDecimal totalSum) {
        this.totalSum = totalSum;
    }

    public String getManagerPhoto() {
        return managerPhoto;
    }

    public void setManagerPhoto(String managerPhoto) {
        this.managerPhoto = managerPhoto;
    }

    public List<OrderItemDto> getProducts() {
        return products;
    }

    public void setProducts(List<OrderItemDto> products) {
        this.products = products;
    }
}