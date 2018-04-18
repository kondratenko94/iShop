package com.springapp.mvc.service;

import com.springapp.mvc.dao.MobileDao;
import com.springapp.mvc.dao.NotebookDao;
import com.springapp.mvc.dao.ProductDao;
import com.springapp.mvc.dto.ProductDto;
import com.springapp.mvc.model.Image;
import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.model.Product;
import com.springapp.mvc.dto.PaginationWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Autowired
    private MobileDao mobileDao;

    @Autowired
    private NotebookDao notebookDao;

    @Override
    public Product createProduct(String type) {

        if (type == null) {
            return null;

        } else {
            int size = Image.CAPACITY;
            List<Image> images = new ArrayList<>(size);

            for (int i = 0; i < size; i++) {
                Image image = new Image();
                image.setPosition(i);
                images.add(image);
            }

            if (type.equals(Mobile.TYPE)) {
                Mobile mobile = new Mobile();
                mobile.setImages(images);
                return mobile;
            }
            else if (type.equals(Notebook.TYPE)) {
                Notebook notebook = new Notebook();
                notebook.setImages(images);
                return notebook;
            }
        }

        return null;

    }

    @Override
    @Transactional
    public void removeProduct(int id) {
        this.productDao.removeProduct(id);
    }

    @Override
    @Transactional
    public Product getProductById(int id) {
        return this.productDao.getProductById(id);
    }

    @Override
    @Transactional
    public PaginationWrapper<Product> listProductsByName(String name, Integer page, int count) {

        long matches = this.productDao.numberOfMatches(name);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        List<Product> products = this.productDao.listProductsByName(name, offset, count);

        return new PaginationWrapper<>(products, count, matches);
    }

    @Override
    @Transactional
    public PaginationWrapper<ProductDto> listProductsDtoByName(String name, Integer page, int count) {
        long matches = this.productDao.numberOfMatches(name);
        long pagesCount = (long) Math.ceil( (float)matches / (float)count );
        if (page == null || page < 1 || page > pagesCount) {
            page = 1;
        }
        int offset = (page - 1) * count;

        List<Product> products = this.productDao.listProductsByName(name, offset, count);

        List<ProductDto> productDtoList = new ArrayList<>();
        for (Product product : products) {
            ProductDto productDto = new ProductDto(product);
            productDtoList.add( productDto );
        }

        return new PaginationWrapper<>(productDtoList, count, matches);
    }

    @Override
    @Transactional
    public PaginationWrapper<ProductDto> listProductsDtoByType(String name, String type, Integer page, int count) {

        long matches = 0;

        if (type.equals(Mobile.TYPE)) {
            matches = this.mobileDao.numberOfMatchesByName(name);
        }
        else if (type.equals(Notebook.TYPE)) {
            matches = this.notebookDao.numberOfMatchesByName(name);
        }

        if (matches > 0) {

            long pagesCount = (long) Math.ceil( (float)matches / (float)count );
            if (page == null || page < 1 || page > pagesCount) {
                page = 1;
            }
            int offset = (page - 1) * count;

            List<Product> products = null;
            if (type.equals(Mobile.TYPE)) {
                products = this.mobileDao.listMobilesByName(name, offset, count);
            }
            else if (type.equals(Notebook.TYPE)) {
                products = this.notebookDao.listNotebooksByName(name, offset, count);
            }

            List<ProductDto> productsDto = new ArrayList<>();

            if (products != null) {
                for (Product product : products) {
                    if (product != null) {
                        ProductDto productDto = new ProductDto(product);
                        productsDto.add(productDto);
                    }
                }
            }

            return new PaginationWrapper<>(productsDto, count, matches);
        } else {
            return new PaginationWrapper<>(new ArrayList<>(), count, matches);
        }

    }
}