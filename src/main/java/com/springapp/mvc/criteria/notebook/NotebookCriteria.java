package com.springapp.mvc.criteria.notebook;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.QueryParameter;
import com.springapp.mvc.criteria.QueryParameterList;

import java.math.BigDecimal;
import java.util.*;

public class NotebookCriteria {

    private BigDecimal priceStart;

    private BigDecimal priceEnd;

    private Boolean inStock;

    private Integer yearStart;

    private Integer yearEnd;

    private List<String> producerList;

    private List<String> kindList;

    private Float screenDiagStart;

    private Float screenDiagEnd;

    private List<String> screenMatrixList;

    private Float procFreqStart;

    private Float procFreqEnd;

    private Integer procCoreStart;

    private Integer procCoreEnd;

    private Float ramStart;

    private Float ramEnd;

    private Integer hdiskCapacityStart;

    private Integer hdiskCapacityEnd;

    private Integer batteryStart;

    private Integer batteryEnd;

    private Set<String> querySet;

    private Set<QueryParameter> parameters;

    private Set<QueryParameterList> parameterLists;

    private void buildHQL() {

        querySet = new HashSet<>();
        parameters = new HashSet<>();
        parameterLists = new HashSet<>();


        if (priceStart != null) {
            querySet.add("price >= :priceStart");
            parameters.add( new QueryParameter("priceStart", priceStart) );
        }

        if (priceEnd != null) {
            querySet.add("price <= :priceEnd");
            parameters.add( new QueryParameter("priceEnd", priceEnd) );
        }

        if (inStock != null) {
            querySet.add("inStock = :inStock");
            parameters.add( new QueryParameter("inStock", inStock) );
        }

        if (yearStart != null) {
            querySet.add("year >= :yearStart");
            parameters.add( new QueryParameter("yearStart", yearStart) );
        }

        if (yearEnd != null) {
            querySet.add("year <= :yearEnd");
            parameters.add( new QueryParameter("yearEnd", yearEnd) );
        }


        if (producerList != null) {
            querySet.add("producer in (:producerList)");
            parameterLists.add( new QueryParameterList("producerList", producerList) );
        }

        if (kindList != null) {
            querySet.add("kind in (:kindList)");
            parameterLists.add( new QueryParameterList("kindList", kindList) );
        }

        if (screenDiagStart != null) {
            querySet.add("screen_diag >= :screenDiagStart");
            parameters.add( new QueryParameter("screenDiagStart", screenDiagStart) );
        }

        if (screenDiagEnd != null) {
            querySet.add("screen_diag <= :screenDiagEnd");
            parameters.add( new QueryParameter("screenDiagEnd", screenDiagEnd) );
        }

        if (screenMatrixList != null) {
            querySet.add("screenMatrix in (:screenMatrixList)");
            parameterLists.add( new QueryParameterList("screenMatrixList", screenMatrixList) );
        }

        if (procFreqStart != null) {
            querySet.add("proc_freq >= :procFreqStart");
            parameters.add( new QueryParameter("procFreqStart", procFreqStart) );
        }

        if (procFreqEnd != null) {
            querySet.add("proc_freq <= :procFreqEnd");
            parameters.add( new QueryParameter("procFreqEnd", procFreqEnd) );
        }

        if (procCoreStart != null) {
            querySet.add("proc_cores >= :procCoreStart");
            parameters.add( new QueryParameter("procCoreStart", procCoreStart) );
        }

        if (procCoreEnd != null) {
            querySet.add("proc_cores <= :procCoreEnd");
            parameters.add( new QueryParameter("procCoreEnd", procCoreEnd) );
        }

        if (ramStart != null) {
            querySet.add("ram >= :ramStart");
            parameters.add( new QueryParameter("ramStart", ramStart) );
        }

        if (ramEnd != null) {
            querySet.add("ram <= :ramEnd");
            parameters.add( new QueryParameter("ramEnd", ramEnd) );
        }

        if (hdiskCapacityStart != null) {
            querySet.add("hdiskCapacity >= :hdiskCapacityStart");
            parameters.add( new QueryParameter("hdiskCapacityStart", hdiskCapacityStart) );
        }

        if (hdiskCapacityEnd != null) {
            querySet.add("hdiskCapacity <= :hdiskCapacityEnd");
            parameters.add( new QueryParameter("hdiskCapacityEnd", hdiskCapacityEnd) );
        }

        if (batteryStart != null) {
            querySet.add("battery >= :batteryStart");
            parameters.add( new QueryParameter("batteryStart", batteryStart) );
        }

        if (batteryEnd != null) {
            querySet.add("battery <= :batteryEnd");
            parameters.add( new QueryParameter("batteryEnd", batteryEnd) );
        }


    }

    private String buildWhere() {

        StringBuilder query = new StringBuilder();

        if (querySet != null && querySet.size() > 0) {

            query.append("where ");

            Iterator iterator = querySet.iterator();
            while (iterator.hasNext()) {
                String q = (String) iterator.next();
                query.append( q );

                if (iterator.hasNext()) query.append(" and ");
            }

        }

        return query.toString();
    }

    public QueryFilter createNotebookFilter() {
        buildHQL();
        String whereQuery = buildWhere();
        return new QueryFilter(whereQuery, parameters, parameterLists);
    }

    public static List<CriteriaOption> createCriteriaOptions() {
        List<CriteriaOption> options = new ArrayList<CriteriaOption>();

        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Цена", "priceStart", "priceEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RADIO, "В наличии", "inStock", null, null) );
        options.add( new CriteriaOption(CriteriaOption.Category.LIST, "Производитель", "producerList", null, "producer") );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Год", "yearStart", "yearEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.LIST, "Тип", "kindList", null, "kind") );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Диагональ экрана", "screenDiagStart", "screenDiagEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.LIST, "Тип матрицы экрана", "screenMatrixList", null, "screenMatrix") );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Частота процессора", "procFreqStart", "procFreqEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Количество ядер процессора", "procCoreStart", "procCoreEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Оперативная память", "ramStart", "ramEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Память", "hdiskCapacityStart", "hdiskCapacityEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Аккумулятор", "batteryStart", "batteryEnd", null) );

        return options;
    }

    public boolean isItemChecked(String listName, String value) {

        switch (listName) {
            case "producerList" : return producerList != null && producerList.contains(value);
            case "kindList" : return kindList != null && kindList.contains(value);
            case "screenMatrixList" : return screenMatrixList != null && screenMatrixList.contains(value);
        }

        return false;
    }

    public Boolean isRadioSelected(String radioName) {

        switch (radioName) {
            case "inStock" : return inStock;
        }

        return null;
    }

    public boolean isPanelCollapsed(String panelName) {

        if (panelName.equals("Цена")) {
            return (priceStart != null || priceEnd != null);
        }
        else if (panelName.equals("В наличии")) {
            return (inStock != null);
        }
        else if (panelName.equals("Производитель")) {
            return (producerList != null);
        }
        else if (panelName.equals("Год")) {
            return (yearStart != null || yearEnd != null);
        }
        else if (panelName.equals("Тип")) {
            return (kindList != null);
        }
        else if (panelName.equals("Диагональ экрана")) {
            return (screenDiagStart != null || screenDiagEnd != null);
        }
        else if (panelName.equals("Тип матрицы экрана")) {
            return (screenMatrixList != null);
        }
        else if (panelName.equals("Частота процессора")) {
            return (procFreqStart != null || procFreqEnd != null);
        }
        else if (panelName.equals("Количество ядер процессора")) {
            return (procCoreStart != null || procCoreEnd != null);
        }
        else if (panelName.equals("Оперативная память")) {
            return (ramStart != null || ramEnd != null);
        }
        else if (panelName.equals("Память")) {
            return (hdiskCapacityStart != null || hdiskCapacityEnd != null);
        }
        else if (panelName.equals("Аккумулятор")) {
            return (batteryStart != null || batteryEnd != null);
        }

        return false;
    }

    public BigDecimal getPriceStart() {
        return priceStart;
    }

    public void setPriceStart(BigDecimal priceStart) {
        this.priceStart = priceStart;
    }

    public BigDecimal getPriceEnd() {
        return priceEnd;
    }

    public void setPriceEnd(BigDecimal priceEnd) {
        this.priceEnd = priceEnd;
    }

    public Boolean getInStock() {
        return inStock;
    }

    public void setInStock(Boolean inStock) {
        this.inStock = inStock;
    }

    public Integer getYearStart() {
        return yearStart;
    }

    public void setYearStart(Integer yearStart) {
        this.yearStart = yearStart;
    }

    public Integer getYearEnd() {
        return yearEnd;
    }

    public void setYearEnd(Integer yearEnd) {
        this.yearEnd = yearEnd;
    }

    public List<String> getProducerList() {
        return producerList;
    }

    public void setProducerList(List<String> producerList) {
        this.producerList = producerList;
    }

    public List<String> getKindList() {
        return kindList;
    }

    public void setKindList(List<String> kindList) {
        this.kindList = kindList;
    }

    public Float getScreenDiagStart() {
        return screenDiagStart;
    }

    public void setScreenDiagStart(Float screenDiagStart) {
        this.screenDiagStart = screenDiagStart;
    }

    public Float getScreenDiagEnd() {
        return screenDiagEnd;
    }

    public void setScreenDiagEnd(Float screenDiagEnd) {
        this.screenDiagEnd = screenDiagEnd;
    }

    public List<String> getScreenMatrixList() {
        return screenMatrixList;
    }

    public void setScreenMatrixList(List<String> screenMatrixList) {
        this.screenMatrixList = screenMatrixList;
    }

    public Integer getProcCoreStart() {
        return procCoreStart;
    }

    public void setProcCoreStart(Integer procCoreStart) {
        this.procCoreStart = procCoreStart;
    }

    public Integer getProcCoreEnd() {
        return procCoreEnd;
    }

    public void setProcCoreEnd(Integer procCoreEnd) {
        this.procCoreEnd = procCoreEnd;
    }

    public Float getProcFreqStart() {
        return procFreqStart;
    }

    public void setProcFreqStart(Float procFreqStart) {
        this.procFreqStart = procFreqStart;
    }

    public Float getProcFreqEnd() {
        return procFreqEnd;
    }

    public void setProcFreqEnd(Float procFreqEnd) {
        this.procFreqEnd = procFreqEnd;
    }

    public Float getRamStart() {
        return ramStart;
    }

    public void setRamStart(Float ramStart) {
        this.ramStart = ramStart;
    }

    public Float getRamEnd() {
        return ramEnd;
    }

    public void setRamEnd(Float ramEnd) {
        this.ramEnd = ramEnd;
    }

    public Integer getHdiskCapacityStart() {
        return hdiskCapacityStart;
    }

    public void setHdiskCapacityStart(Integer hdiskCapacityStart) {
        this.hdiskCapacityStart = hdiskCapacityStart;
    }

    public Integer getHdiskCapacityEnd() {
        return hdiskCapacityEnd;
    }

    public void setHdiskCapacityEnd(Integer hdiskCapacityEnd) {
        this.hdiskCapacityEnd = hdiskCapacityEnd;
    }

    public Integer getBatteryStart() {
        return batteryStart;
    }

    public void setBatteryStart(Integer batteryStart) {
        this.batteryStart = batteryStart;
    }

    public Integer getBatteryEnd() {
        return batteryEnd;
    }

    public void setBatteryEnd(Integer batteryEnd) {
        this.batteryEnd = batteryEnd;
    }
}