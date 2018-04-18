package com.springapp.mvc.dao;

import com.springapp.mvc.model.FavouriteItem;

import java.util.List;

public interface FavouriteDao {

    boolean isItemFavourite(String username, Integer productId);

    FavouriteItem getFavouriteItem(String username, Integer productId);

    void addFavouriteItem(FavouriteItem favouriteItem);

    void removeFavouriteItem(FavouriteItem favouriteItem);

    List<FavouriteItem> listFavouriteItems(String username, Integer page, Integer count);

    long getFavouritesCountByUsername(String username);

}