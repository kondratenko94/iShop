package com.springapp.mvc.controller;

import com.springapp.mvc.dto.NotebookDto;
import com.springapp.mvc.dto.PaginationWrapper;
import com.springapp.mvc.dto.ProductDto;
import com.springapp.mvc.exception.database.ConstraintException;
import com.springapp.mvc.exception.database.mobile.MobileNameUniqueException;
import com.springapp.mvc.exception.database.notebook.NotebookNameUniqueException;
import com.springapp.mvc.model.Image;
import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.model.Product;
import com.springapp.mvc.service.MobileService;
import com.springapp.mvc.service.NotebookService;
import com.springapp.mvc.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Collections;

@PreAuthorize("hasRole('ADMIN') or hasRole('MODER')")
@Controller
public class StockController {

    @Autowired
    private ProductService productService;

    @Autowired
    private MobileService mobileService;

    @Autowired
    private NotebookService notebookService;

    @RequestMapping(value = "/management/stock/create/{type}", method = RequestMethod.GET)
    public String createProduct(@PathVariable("type") String type, ModelMap model) {

        Product product = this.productService.createProduct(type);

        model.addAttribute("selectedMenu", "stock/add");
        model.addAttribute("product", product);
        model.addAttribute("type", product.getType());

        return "management/stock/create_product";
    }

    @RequestMapping(value = "/management/stock/create/" + Mobile.TYPE, method = RequestMethod.POST)
    public String createMobile(@ModelAttribute("product") @Valid Mobile mobile,
                               BindingResult result,
                               ModelMap model) {

        if (!result.hasErrors()) {
            try {
                Integer id = mobileService.addMobile(mobile);
                return "redirect:/" + Mobile.TYPE + "/" + id.toString();

            } catch (MobileNameUniqueException exc) {
                for (Image i : mobile.getImages()) {
                    i.setLink("");
                }

                result.rejectValue("name", "Product.name.unique");

            } catch (ConstraintException exc) {
                return "redirect:/error/";
            }
        }

        model.addAttribute("selectedMenu", "stock/add");
        model.addAttribute("type", Mobile.TYPE);

        return "management/stock/create_product";
    }

    @RequestMapping(value = "/management/stock/create/" + Notebook.TYPE, method = RequestMethod.POST)
    public String createNotebook(@ModelAttribute("product") @Valid Notebook notebook,
                               BindingResult result,
                               ModelMap model) {

        if (!result.hasErrors()) {
            try {
                Integer id = notebookService.addNotebook(notebook);
                return "redirect:/" + Notebook.TYPE + "/" + id.toString();

            } catch (NotebookNameUniqueException exc) {
                for (Image i : notebook.getImages()) {
                    i.setLink("");
                }

                result.rejectValue("name", "Product.name.unique");
            } catch (ConstraintException exc) {
                return "redirect:/error/";
            }
        }

        model.addAttribute("selectedMenu", "stock/add");
        model.addAttribute("type", Notebook.TYPE);

        return "management/stock/create_product";
    }

    @RequestMapping(value = "/management/stock/edit/{type}", method = RequestMethod.GET)
    public String editProduct(@PathVariable("type") String type,
                              @RequestParam(required = false) Integer id,
                              ModelMap model) {
        boolean success = false;

        Product product;
        if (id != null) {
            product = this.productService.getProductById(id);

            if (product == null) {
                product = this.productService.createProduct(Mobile.TYPE);

            } else {
                success = true;
            }

        } else {
            product = this.productService.createProduct(type);
        }

        model.addAttribute("selectedMenu", "stock/edit");
        model.addAttribute("product", product.produceDto());
        model.addAttribute("type", product.getType());
        model.addAttribute("auto_show", success);

        return "management/stock/edit_product";
    }

    @ResponseBody
    @RequestMapping(value = "/management/stock/search/", method = RequestMethod.GET)
    public PaginationWrapper<ProductDto> searchProductsByName(String name, String type, Integer page) {

        final int COUNT = 5;

        PaginationWrapper<ProductDto> pagWrapper = this.productService.listProductsDtoByType(name, type, page, COUNT);
        return pagWrapper;
    }

    @ResponseBody
    @RequestMapping(value = "/management/stock/", method = RequestMethod.GET)
    public Object getProduct(int id) {

        Product product = this.productService.getProductById(id);
        return product.produceDto();
    }

    @RequestMapping(value = "/management/stock/update/" + Mobile.TYPE, method = RequestMethod.POST)
    public String updateMobile(@Valid @ModelAttribute("product") Mobile product, BindingResult result,
                               ModelMap model) {

        Collections.sort(product.getImages());

        if (!result.hasErrors()) {
            try {
                mobileService.updateMobile(product);

            } catch (MobileNameUniqueException exc) {
                result.rejectValue("name", "Product.name.unique");

            } catch (ConstraintException exc) {
                return "redirect:/error/";
            }
        }

        model.addAttribute("selectedMenu", "stock/edit");
        model.addAttribute("type", product.getType() );
        model.addAttribute("auto_show", true );
        model.addAttribute("success", !result.hasErrors() );

        return "management/stock/edit_product";
    }

    @RequestMapping(value = "/management/stock/update/" + Notebook.TYPE, method = RequestMethod.POST)
    public String updateNotebook(@ModelAttribute("product") Notebook product, BindingResult result,
                                 ModelMap model) {

        Collections.sort(product.getImages());

        if (!result.hasErrors()) {
            try {
                notebookService.updateNotebook(product);

            } catch (NotebookNameUniqueException exc) {
                result.rejectValue("name", "Product.name.unique");

            } catch (ConstraintException exc) {
                return "redirect:/error/";
            }
        }

        model.addAttribute("selectedMenu", "stock/edit");
        model.addAttribute("type", product.getType() );
        model.addAttribute("auto_show", true );
        model.addAttribute("success", !result.hasErrors() );

        return "management/stock/edit_product";
    }

    @ResponseBody
    @RequestMapping(value = "/management/stock/remove/", method = RequestMethod.POST)
    public boolean removeProduct(int id) {
        this.productService.removeProduct(id);
        return true;
    }

}
