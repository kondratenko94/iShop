package com.springapp.mvc.controller;

import com.springapp.mvc.dto.OrderDto;
import com.springapp.mvc.form.Item;
import com.springapp.mvc.dto.ProductDto;
import com.springapp.mvc.model.Product;
import com.springapp.mvc.service.OrderService;
import com.springapp.mvc.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ShoppingCartController {

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;

    @RequestMapping(value = "/cart/update", method = RequestMethod.POST)
    public @ResponseBody List<ProductDto> updateProductOnClient(@RequestBody Item[] itemList) {

        List<ProductDto> productList = new ArrayList<>();

        for (Item item : itemList) {
            Product product = this.productService.getProductById(item.getId());

            if (product != null) {
                ProductDto productDto = new ProductDto(product);
                productList.add(productDto);
            }

        }

        return productList;
    }

    @ResponseBody
    @RequestMapping(value = "/cart/order", method = RequestMethod.POST)
    public boolean getOrder(@RequestBody OrderDto orderDto) {
        Integer orderId = this.orderService.addOrder(orderDto);
        return (orderId != null);
    }


}