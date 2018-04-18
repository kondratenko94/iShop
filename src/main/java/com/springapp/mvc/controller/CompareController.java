package com.springapp.mvc.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.springapp.mvc.model.Mobile;
import com.springapp.mvc.form.ComparedSet;
import com.springapp.mvc.model.Notebook;
import com.springapp.mvc.service.MobileService;
import com.springapp.mvc.service.NotebookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/compare/")
public class CompareController {

    @Autowired
    private MobileService mobileService;

    @Autowired
    private NotebookService notebookService;

    @RequestMapping(method = RequestMethod.GET)
    public String productList(ComparedSet products, ModelMap model) {

        model.addAttribute("compareProduct", new ComparedSet());

        String type = products.getType();
        if (type != null) {

            List<Integer> idList = new ArrayList<>();

            try {

                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(products.getIdList());
                ArrayNode arrayNode = (ArrayNode) rootNode;

                Iterator<JsonNode> iterator = arrayNode.elements();
                int limit = 0;
                while (iterator.hasNext() && limit++ < 10) {
                    JsonNode node = iterator.next();
                    if (node.isInt()) idList.add(node.asInt());
                }

            } catch (JsonProcessingException e) {
                System.out.println("Compare/JsonProcessingException " + e.getMessage());
            } catch (IOException e) {
                System.out.println("Compare/IOException " + e.getMessage());
            } catch (NullPointerException e) {
                System.out.println("Compare/NullPointerException " + e.getMessage());
            }

            if (idList.size() != 0) {

                if (type.equals(Mobile.TYPE)) {
                    List<Mobile> mobiles = mobileService.listMobilesByIds(idList);
                    model.addAttribute("products", mobiles);
                    model.addAttribute("type", type);
                    model.addAttribute("section", "Мобильные телефоны");

                } else if (type.equals(Notebook.TYPE)) {
                    List<Notebook> notebooks = notebookService.listNotebooksByIds(idList);
                    model.addAttribute("products", notebooks);
                    model.addAttribute("type", type);
                    model.addAttribute("section", "Ноутбуки");
                }
            }
        }

        return "shop/compare/compare";
    }

}