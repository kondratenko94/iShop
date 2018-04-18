package com.springapp.mvc.criteria;

import java.util.List;

public class CriteriaOption {

    public enum Category {
        LIST, RADIO, RANGE
    }

    private Category type;

    private String pathStart;

    private String pathEnd;

    private String title;

    private String name;

    private List<String> checkBoxList;

    public CriteriaOption(Category type, String title, String pathStart, String pathEnd, String name) {

        this.type = type;

        if (type == Category.RANGE) {
            this.title = title;
            this.pathStart = pathStart;
            this.pathEnd = pathEnd;
        }
        else if (type == Category.RADIO) {
            this.title = title;
            this.pathStart = pathStart;
        }
        else if (type == Category.LIST) {
            this.type = type;
            this.title = title;
            this.pathStart = pathStart;
            this.name = name;
        }
    }

    public Category getType() {
        return type;
    }

    public void setType(Category type) {
        this.type = type;
    }

    public String getPathStart() {
        return pathStart;
    }

    public void setPathStart(String pathStart) {
        this.pathStart = pathStart;
    }

    public String getPathEnd() {
        return pathEnd;
    }

    public void setPathEnd(String pathEnd) {
        this.pathEnd = pathEnd;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getCheckBoxList() {
        return checkBoxList;
    }

    public void setCheckBoxList(List<String> checkBoxList) {
        this.checkBoxList = checkBoxList;
    }
}
