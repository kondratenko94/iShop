package com.springapp.mvc.service;

import com.springapp.mvc.dao.FavouriteDao;
import com.springapp.mvc.model.FavouriteItem;
import com.springapp.mvc.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FavouriteServiceImpl implements FavouriteService {

    @Autowired
    private FavouriteDao favouriteDao;

    @Autowired
    private ProductService productService;

    @Override
    @Transactional
    public boolean isItemFavourite(String username, Integer productId) {
        return this.favouriteDao.isItemFavourite(username, productId);
    }

    @Override
    @Transactional
    public long countByUsername(String username) {
        return this.favouriteDao.getFavouritesCountByUsername(username);
    }

    @Override
    @Transactional
    public byte setFavouriteItem(String username, Integer productId, String type) {

        FavouriteItem favouriteItem = this.favouriteDao.getFavouriteItem(username, productId);

        if (favouriteItem == null) {

            favouriteItem = new FavouriteItem();

            Product product = this.productService.getProductById(productId);
            favouriteItem.setProduct(product);
            favouriteItem.setUsername(username);

            this.favouriteDao.addFavouriteItem(favouriteItem);
            return 1;
        } else {

            this.favouriteDao.removeFavouriteItem(favouriteItem);
            return 2;
        }
    }

    @Override
    @Transactional
    public List<FavouriteItem> listFavouriteItems(String username, Integer page, Integer count) {
        return this.favouriteDao.listFavouriteItems(username, page, count);
    }


}