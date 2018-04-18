package com.springapp.mvc.criteria.mobile;

import com.springapp.mvc.criteria.CriteriaOption;
import com.springapp.mvc.criteria.QueryFilter;
import com.springapp.mvc.criteria.QueryParameter;
import com.springapp.mvc.criteria.QueryParameterList;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.*;

public class MobileCriteria {

    private BigDecimal priceStart;

    private BigDecimal priceEnd;

    private Boolean inStock;

    private Integer yearStart;

    private Integer yearEnd;

    private List<String> brandList;

    private List<String> platformList;

    private List<String> screenTechList;

    private Integer screenDiagStart;

    private Integer screenDiagEnd;

    private Integer procFreqStart;

    private Integer procFreqEnd;

    private Integer procCoreStart;

    private Integer procCoreEnd;

    private Integer ramStart;

    private Integer ramEnd;

    private Integer memoryStart;

    private Integer memoryEnd;

    private Boolean supportSd;

    private Float cameraStart;

    private Float cameraEnd;

    private Float frontCameraStart;

    private Float frontCameraEnd;

    private Boolean video;

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

        if (brandList != null) {
            querySet.add("brand in (:brandList)");
            parameterLists.add( new QueryParameterList("brandList", brandList) );
        }

        if (platformList != null) {
            querySet.add("platform in (:platformList)");
            parameterLists.add( new QueryParameterList("platformList", platformList) );
        }

        if (screenTechList != null) {
            querySet.add("screen_tech in (:screenTech)");
            parameterLists.add( new QueryParameterList("screenTech", screenTechList) );
        }

        if (screenDiagStart != null) {
            querySet.add("screen_diag >= :screenDiagStart");
            parameters.add( new QueryParameter("screenDiagStart", screenDiagStart) );
        }

        if (screenDiagEnd != null) {
            querySet.add("screen_diag <= :screenDiagEnd");
            parameters.add( new QueryParameter("screenDiagEnd", screenDiagEnd) );
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

        if (memoryStart != null) {
            querySet.add("memory >= :memoryStart");
            parameters.add( new QueryParameter("memoryStart", memoryStart) );
        }

        if (memoryEnd != null) {
            querySet.add("memory <= :memoryEnd");
            parameters.add( new QueryParameter("memoryEnd", memoryEnd) );
        }

        if (supportSd != null) {
            querySet.add("support_sd = :supportSd");
            parameters.add( new QueryParameter("supportSd", supportSd) );
        }

        if (cameraStart != null) {
            querySet.add("camera >= :cameraStart");
            parameters.add( new QueryParameter("cameraStart", cameraStart) );
        }

        if (cameraEnd != null) {
            querySet.add("camera <= :cameraEnd");
            parameters.add( new QueryParameter("cameraEnd", cameraEnd) );
        }

        if (frontCameraStart != null) {
            querySet.add("front_camera >= :frontCameraStart");
            parameters.add( new QueryParameter("frontCameraStart", frontCameraStart) );
        }

        if (frontCameraEnd != null) {
            querySet.add("front_camera <= :frontCameraEnd");
            parameters.add( new QueryParameter("frontCameraEnd", frontCameraEnd) );
        }

        if (video != null) {
            querySet.add("video = :video");
            parameters.add( new QueryParameter("video", video) );
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

    public QueryFilter createMobileFilter() {
        buildHQL();
        String whereQuery = buildWhere();
        return new QueryFilter(whereQuery, parameters, parameterLists);
    }

    public static List<CriteriaOption> createCriteriaOptions() {
        List<CriteriaOption> options = new ArrayList<CriteriaOption>();

        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Цена", "priceStart", "priceEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RADIO, "В наличии", "inStock", null, null) );
        options.add( new CriteriaOption(CriteriaOption.Category.LIST, "Бренд", "brandList", null, "brand") );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Год", "yearStart", "yearEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.LIST, "Платформа", "platformList", null, "platform") );
        options.add( new CriteriaOption(CriteriaOption.Category.LIST, "Технология экрана", "screenTechList", null, "screenTech") );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Диагональ экрана", "screenDiagStart", "screenDiagEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Частота процессора", "procFreqStart", "procFreqEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Количество ядер процессора", "procCoreStart", "procCoreEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Оперативная память", "ramStart", "ramEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Память", "memoryStart", "memoryEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RADIO, "Поддержка карт памяти", "supportSd", null, null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Камера", "cameraStart", "cameraEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Фронтальная камера", "frontCameraStart", "frontCameraEnd", null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RADIO, "Запись видео", "video", null, null) );
        options.add( new CriteriaOption(CriteriaOption.Category.RANGE, "Аккумулятор", "batteryStart", "batteryEnd", null) );

        return options;
    }

    public boolean isItemChecked(String listName, String value) {

        switch (listName) {
            case "brandList" : return brandList != null && brandList.contains(value);
            case "platformList" : return platformList != null && platformList.contains(value);
            case "screenTechList" : return screenTechList != null && screenTechList.contains(value);
        }

        return false;
    }

    public Boolean isRadioSelected(String radioName) {

        switch (radioName) {
            case "inStock" : return inStock;
            case "supportSd" : return supportSd;
            case "video" : return video;
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
        else if (panelName.equals("Бренд")) {
            return (brandList != null);
        }
        else if (panelName.equals("Год")) {
            return (yearStart != null || yearEnd != null);
        }
        else if (panelName.equals("Платформа")) {
            return (platformList != null);
        }
        else if (panelName.equals("Технология экрана")) {
            return (screenTechList != null);
        }
        else if (panelName.equals("Диагональ экрана")) {
            return (screenDiagStart != null || screenDiagEnd != null);
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
            return (memoryStart != null || memoryEnd != null);
        }
        else if (panelName.equals("Поддержка карт памяти")) {
            return (supportSd != null);
        }
        else if (panelName.equals("Камера")) {
            return (cameraStart != null || cameraEnd != null);
        }
        else if (panelName.equals("Фронтальная камера")) {
            return (frontCameraStart != null || frontCameraEnd != null);
        }
        else if (panelName.equals("Запись видео")) {
            return (video != null);
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

    public List<String> getBrandList() {
        return brandList;
    }

    public void setBrandList(List<String> brandList) {
        this.brandList = brandList;
    }

    public Boolean getSupportSd() {
        return supportSd;
    }

    public List<String> getScreenTechList() {
        return screenTechList;
    }

    public void setScreenTechList(List<String> screenTechList) {
        this.screenTechList = screenTechList;
    }

    public Integer getScreenDiagStart() {
        return screenDiagStart;
    }

    public void setScreenDiagStart(Integer screenDiagStart) {
        this.screenDiagStart = screenDiagStart;
    }

    public Integer getScreenDiagEnd() {
        return screenDiagEnd;
    }

    public void setScreenDiagEnd(Integer screenDiagEnd) {
        this.screenDiagEnd = screenDiagEnd;
    }

    public Integer getProcFreqStart() {
        return procFreqStart;
    }

    public void setProcFreqStart(Integer procFreqStart) {
        this.procFreqStart = procFreqStart;
    }

    public Integer getProcFreqEnd() {
        return procFreqEnd;
    }

    public void setProcFreqEnd(Integer procFreqEnd) {
        this.procFreqEnd = procFreqEnd;
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

    public Integer getRamStart() {
        return ramStart;
    }

    public void setRamStart(Integer ramStart) {
        this.ramStart = ramStart;
    }

    public Integer getRamEnd() {
        return ramEnd;
    }

    public void setRamEnd(Integer ramEnd) {
        this.ramEnd = ramEnd;
    }

    public Integer getMemoryStart() {
        return memoryStart;
    }

    public void setMemoryStart(Integer memoryStart) {
        this.memoryStart = memoryStart;
    }

    public Integer getMemoryEnd() {
        return memoryEnd;
    }

    public void setMemoryEnd(Integer memoryEnd) {
        this.memoryEnd = memoryEnd;
    }

    public Float getCameraStart() {
        return cameraStart;
    }

    public void setCameraStart(Float cameraStart) {
        this.cameraStart = cameraStart;
    }

    public Float getCameraEnd() {
        return cameraEnd;
    }

    public void setCameraEnd(Float cameraEnd) {
        this.cameraEnd = cameraEnd;
    }

    public Float getFrontCameraStart() {
        return frontCameraStart;
    }

    public void setFrontCameraStart(Float frontCameraStart) {
        this.frontCameraStart = frontCameraStart;
    }

    public Float getFrontCameraEnd() {
        return frontCameraEnd;
    }

    public void setFrontCameraEnd(Float frontCameraEnd) {
        this.frontCameraEnd = frontCameraEnd;
    }

    public Boolean getVideo() {
        return video;
    }

    public void setVideo(Boolean video) {
        this.video = video;
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

    public List<String> getPlatformList() {
        return platformList;
    }

    public void setPlatformList(List<String> platformList) {
        this.platformList = platformList;
    }

    public void setSupportSd(Boolean supportSd) {
        this.supportSd = supportSd;
    }



}