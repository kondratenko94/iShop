package com.springapp.mvc.criteria;

import java.util.List;

public class QueryParameterList {

    private String name;

    private List<String> valueList;

    public QueryParameterList(String name, List<String> valueList) {
        this.name = name;
        this.valueList = valueList;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getValueList() {
        return valueList;
    }

    public void setValueList(List<String> valueList) {
        this.valueList = valueList;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        QueryParameterList that = (QueryParameterList) o;

        if (name != null ? !name.equals(that.name) : that.name != null) return false;
        return !(valueList != null ? !valueList.equals(that.valueList) : that.valueList != null);

    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + (valueList != null ? valueList.hashCode() : 0);
        return result;
    }
}