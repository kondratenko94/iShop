package com.springapp.mvc.dto;

import com.springapp.mvc.model.Product;

import java.math.BigDecimal;

public class ProductDto {

    private Integer id;

    private String type;

    private String caption;

    private String link;

    private String name;

    private BigDecimal price;

    public ProductDto() {}

    public ProductDto(Product product) {

        this.id = product.getId();
        this.type = product.getType();
        this.caption = product.getCaption();
        this.link = product.getMainScreen();
        this.name = product.getName();
        this.price = product.getPrice();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}