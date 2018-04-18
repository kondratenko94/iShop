package com.springapp.mvc.service;

import com.springapp.mvc.model.FavouriteItem;

import java.util.List;

public interface FavouriteService {

    boolean isItemFavourite(String username, Integer productId);

    long countByUsername(String username);

    byte setFavouriteItem(String username, Integer id, String type);

    List<FavouriteItem> listFavouriteItems(String username, Integer page, Integer count);

}