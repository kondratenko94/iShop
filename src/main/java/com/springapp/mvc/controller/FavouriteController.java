package com.springapp.mvc.controller;

import com.springapp.mvc.form.Item;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.FavouriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FavouriteController {

    @Autowired
    private FavouriteService favouriteService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @PreAuthorize("isFullyAuthenticated() or isRememberMe()")
    @ResponseBody
    @RequestMapping(value = "/favourite/item", method = RequestMethod.POST)
    public byte handleItem(@RequestBody Item item) {

        Integer productId = item.getId();
        String productType = item.getType();

        String username = currentAuthentication.getCurrentUsername();

        return username == null ? 0 : this.favouriteService.setFavouriteItem(username, productId, productType);
    }

}