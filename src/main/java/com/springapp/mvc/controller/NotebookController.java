package com.springapp.mvc.controller;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.FieldTypeDeterminer;
import com.springapp.mvc.criteria.notebook.NotebookCriteria;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.model.FavouriteItem;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.model.Review;
import com.springapp.mvc.model.User;
import com.springapp.mvc.security.CurrentAuthentication;
import com.springapp.mvc.service.FavouriteService;
import com.springapp.mvc.service.NotebookService;
import com.springapp.mvc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class NotebookController {

    final String SECTION = "Ноутбуки";

    @Autowired
    private NotebookService notebookService;

    @Autowired
    private FavouriteService favouriteService;

    @Autowired
    private CurrentAuthentication currentAuthentication;

    @RequestMapping(value = "/notebook/", method = RequestMethod.GET)
    public String productList(@ModelAttribute("criteria") NotebookCriteria criteria,
                              @ModelAttribute("sort") String sortMode,
                              @RequestParam(required = false) Integer page,
                              @CookieValue(value="tabMode", required=false) String tabMode,
                              ModelMap model) {

        final int COUNT = 12;

        PaginationWrapper<Notebook> pagWrapper = this.notebookService.listNotebooksFiltered(criteria, sortMode, page, COUNT);
        List<Notebook> notebooks = pagWrapper.getList();
        List<CriteriaOption> filtersPanel = notebookService.createCriteriaOptions();

        User user = this.currentAuthentication.getCurrentUser();
        if (user != null) {

            List<FavouriteItem> favouriteItems = user.getFavouriteItems();

            for (FavouriteItem f : favouriteItems) {
                Integer productId = f.getProduct().getId();

                for (Notebook notebook : notebooks) {
                    Integer id = notebook.getId();

                    if ( productId.equals(id) ) {
                        notebook.setFavourite(true);
                        break;
                    }
                }
            }

        }

        model.addAttribute("section", SECTION);
        model.addAttribute("type", Notebook.TYPE);

        String maxWidth = (tabMode != null && tabMode.equals("row")) ? "notebook_max_width_row" : "notebook_max_width_table" ;
        model.addAttribute("maxWidth", maxWidth);

        String height = (tabMode != null && tabMode.equals("row")) ? "notebook_height_row" : "notebook_height_table";
        model.addAttribute("height", height);

        model.addAttribute("productsList", notebooks);
        model.addAttribute("filtersPanel", filtersPanel);
        model.addAttribute("compareProduct", new ComparedSet());

        long pagesCount = pagWrapper.getPagesCount();
        model.addAttribute("pagesCount", pagesCount);

        model.addAttribute("page", (page == null) ? 1 : page);
        model.addAttribute("productFilter", criteria != null ? criteria : new NotebookCriteria());
        model.addAttribute("fieldTypeDeterminer", new FieldTypeDeterminer());
        model.addAttribute("sortMode", sortMode.equals("") ? "0" : sortMode);
        model.addAttribute("tabMode", (tabMode == null) ? "table" : tabMode);

        return "/shop/products";
    }

    @RequestMapping(value = "/notebook/{id}", method = RequestMethod.GET)
    public String getMobile(@PathVariable("id") int id, ModelMap model) {
        Notebook notebook = notebookService.getNotebookById(id);

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

        model.addAttribute("product_height", "product_height_notebook");

        model.addAttribute("product", notebook);
        model.addAttribute("compareProduct", new ComparedSet());
        model.addAttribute("editReview", new Review());

        return "shop/product/product";
    }

}