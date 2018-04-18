package com.springapp.mvc.service;

import com.springapp.mvc.dto.ProductDto;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.model.Product;

public interface ProductService {

    Product createProduct(String type);

    void removeProduct(int id);

    Product getProductById(int id);

    PaginationWrapper<Product> listProductsByName(String name, Integer page, int count);

    PaginationWrapper<ProductDto> listProductsDtoByName(String name, Integer page, int count);

    PaginationWrapper<ProductDto> listProductsDtoByType(String name, String type, Integer page, int count);


}