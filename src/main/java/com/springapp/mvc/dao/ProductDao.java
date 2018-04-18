package com.springapp.mvc.dao;

import com.springapp.mvc.model.Product;

import java.util.List;

public interface ProductDao {

    Product getProductById(int id);

    void removeProduct(int id);

    long numberOfMatches(String name);

    List<Product> listProductsByName(String name, int start, int count);

}