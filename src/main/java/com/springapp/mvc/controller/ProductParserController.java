package com.springapp.mvc.controller;

import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.parser.mobile.MobileBuilder;
import com.springapp.mvc.parser.mobile.MobileDirector;
import com.springapp.mvc.parser.mobile.ShopByMobileBuilder;
import com.springapp.mvc.parser.notebook.NotebookBuilder;
import com.springapp.mvc.parser.notebook.NotebookDirector;
import com.springapp.mvc.parser.notebook.ShopByNotebookBuilder;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ProductParserController {

    @PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
    @ResponseBody
    @RequestMapping(value = "management/stock/parse_page/", method = RequestMethod.POST)
    public Object getDataFromLink(String url, String productType){

        switch (productType) {

            case Mobile.TYPE : {
                MobileBuilder builder = getMobileBuilder(url);
                MobileDirector director = new MobileDirector(builder);
                director.constructMobileDto(url);

                return director.getMobileDto();
            }

            case Notebook.TYPE : {
                NotebookBuilder builder = getNotebookBuilder(url);
                NotebookDirector director = new NotebookDirector(builder);
                director.constructNotebookDto(url);

                return director.getNotebookDto();
            }
        }

        return null;
    }

    private static MobileBuilder getMobileBuilder(String url) {

        if (url != null) {

            if (url.contains("shop.by/")) {
                return new ShopByMobileBuilder();
            }

        }

        return null;
    }

    private static NotebookBuilder getNotebookBuilder(String url) {
        if (url != null) {

            if (url.contains("shop.by/")) {
                return new ShopByNotebookBuilder();
            }

        }

        return null;
    }

}
