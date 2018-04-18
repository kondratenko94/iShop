package com.springapp.mvc.controller;

import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.dto.ProductDto;
import com.springapp.mvc.model.Product;
import com.springapp.mvc.service.ProductService;
import com.springapp.mvc.dto.PaginationWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class SearchController {

    @Autowired
    private ProductService productService;


    @ResponseBody
    @RequestMapping(value = "/search/product/", method = RequestMethod.GET)
    public PaginationWrapper<ProductDto> findByName(String name, Integer page) {
        final int COUNT = 5;
        return this.productService.listProductsDtoByName(name, page, COUNT);
    }

    @RequestMapping(value = "/search/", method = RequestMethod.GET)
    public String searchPage(@RequestParam(required = false) String input,
                             @RequestParam(required = false) Integer page,
                             ModelMap model) {

        final int COUNT = 10;

        PaginationWrapper<Product> pagWrapper = this.productService.listProductsByName(input, page, COUNT);

        long matches = pagWrapper.getMaxCount();
        List<Product> products = pagWrapper.getList();
        long pagesCount = pagWrapper.getPagesCount();

        model.addAttribute("input", input);
        model.addAttribute("totalCount", matches);
        model.addAttribute("productsList", products);
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("pagesCount", pagesCount);
        model.addAttribute("page", (page == null) ? 1 : page);

        return "/shop/search";
    }

}