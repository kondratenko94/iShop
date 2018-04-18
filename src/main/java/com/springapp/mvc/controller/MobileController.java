package com.springapp.mvc.controller;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.FieldTypeDeterminer;
import com.springapp.mvc.criteria.mobile.MobileCriteria;
import com.springapp.mvc.model.*;
import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.FavouriteService;
import com.springapp.mvc.service.MobileService;
import com.springapp.mvc.dto.PaginationWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class MobileController {

    final String SECTION = "Мобильные телефоны";

    @Autowired
    private MobileService mobileService;

    @Autowired
    private FavouriteService favouriteService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @RequestMapping(value = "/mobile/", method = RequestMethod.GET)
    public String productList(@ModelAttribute("criteria") MobileCriteria criteria,
                              @ModelAttribute("sort") String sortMode,
                              @RequestParam(required = false) Integer page,
                              @CookieValue(value="tabMode", required=false) String tabMode,
                              ModelMap model) {

        final int COUNT = 12;

        PaginationWrapper<Mobile> pagWrapper = mobileService.listMobilesFiltered(criteria, sortMode, page, COUNT);
        List<Mobile> mobiles = pagWrapper.getList();
        List<CriteriaOption> filtersPanel = mobileService.createCriteriaOptions();

        User user = this.currentAuthentication.getCurrentUser();
        if (user != null) {

            List<FavouriteItem> favouriteItems = user.getFavouriteItems();

            for (FavouriteItem f : favouriteItems) {
                Integer productId = f.getProduct().getId();

                for (Mobile mobile : mobiles) {
                    Integer id = mobile.getId();

                    if ( productId.equals(id) ) {
                        mobile.setFavourite(true);
                        break;
                    }
                }
            }
        }

        model.addAttribute("section", SECTION);
        model.addAttribute("type", Mobile.TYPE);

        String maxWidth = (tabMode != null && tabMode.equals("row")) ? "mobile_max_width_row" : "mobile_max_width_table" ;
        model.addAttribute("maxWidth", maxWidth);

        String height = (tabMode != null && tabMode.equals("row")) ? "mobile_height_row" : "mobile_height_table";
        model.addAttribute("height", height);

        model.addAttribute("productsList", mobiles);
        model.addAttribute("filtersPanel", filtersPanel);
        model.addAttribute("compareProduct", new ComparedSet());

        long pagesCount = pagWrapper.getPagesCount();
        model.addAttribute("pagesCount", pagesCount);

        model.addAttribute("page", (page == null) ? 1 : page);
        model.addAttribute("productFilter", criteria != null ? criteria : new MobileCriteria());
        model.addAttribute("fieldTypeDeterminer", new FieldTypeDeterminer());
        model.addAttribute("sortMode", sortMode.equals("") ? "0" : sortMode);
        model.addAttribute("tabMode", (tabMode == null) ? "table" : tabMode);

        return "shop/products";
    }

    @RequestMapping(value = "/mobile/{id}", method = RequestMethod.GET)
    public String getMobile(@PathVariable("id") int id, ModelMap model) throws org.hibernate.ObjectNotFoundException {

        Mobile mobile = mobileService.getMobileById(id);

        Boolean isFavouriteItem = null;

        String username = this.currentAuthentication.getCurrentUsername();
        if (username != null) {
            if ( this.favouriteService.isItemFavourite( username, id ) ) {
                isFavouriteItem = true;
            }
        }
        model.addAttribute("favourite", isFavouriteItem);
        model.addAttribute("newReview", new Review());

        model.addAttribute("section", SECTION);

        model.addAttribute("product_height", "product_height_mobile");

        model.addAttribute("product", mobile);
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("editReview", new Review());

        return "shop/product/product";
    }

}
