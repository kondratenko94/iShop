package com.springapp.mvc.dto;

import com.springapp.mvc.model.Image;
import com.springapp.mvc.model.Notebook;

import java.math.BigDecimal;
import java.util.List;

public class NotebookDto {

    private Integer id;

    private String name;

    private BigDecimal price;

    private Integer year;

    private String producer;

    private String osVersion;

    private String kind;

    private String screenDiag;

    private String screenMaxResol;

    private String screenMatrix;

    private String procSeries;

    private String procName;

    private Integer procCores;

    private Float procFreq;

    private Float procFreqTurbo;

    private Float ram;

    private String ramType;

    private String graphAdapterType;

    private String graphAdapter;

    private String secondGraphAdapter;

    private Float graphMemory;

    private String hdiskType;

    private Integer hdiskCapacity;

    private Integer battery;

    private Float energyReserve;

    private String coverColor;

    private String bodyMaterial;

    private String coverMaterial;

    private Float weight;

    private Float width;

    private Float depth;

    private Float height;

    private Boolean inStock;

    private List<Image> images;

    public NotebookDto() {};

    public NotebookDto(Notebook notebook) {
        if (notebook != null) {
            this.id = notebook.getId();
            this.name = notebook.getName();
            this.price = notebook.getPrice();
            this.year = notebook.getYear();
            this.producer = notebook.getProducer();
            this.osVersion = notebook.getOsVersion();
            this.kind = notebook.getKind();
            this.screenDiag = notebook.getScreenDiag();
            this.screenMaxResol = notebook.getScreenMaxResol();
            this.screenMatrix = notebook.getScreenMatrix();
            this.procSeries = notebook.getProcSeries();
            this.procName = notebook.getProcName();
            this.procCores = notebook.getProcCores();
            this.procFreq = notebook.getProcFreq();
            this.procFreqTurbo = notebook.getProcFreqTurbo();
            this.ram = notebook.getRam();
            this.ramType = notebook.getRamType();
            this.graphAdapterType = notebook.getGraphAdapterType();
            this.graphAdapter = notebook.getGraphAdapter();
            this.secondGraphAdapter = notebook.getSecondGraphAdapter();
            this.graphMemory = notebook.getGraphMemory();
            this.hdiskType = notebook.getHdiskType();
            this.hdiskCapacity = notebook.getHdiskCapacity();
            this.battery = notebook.getBattery();
            this.energyReserve = notebook.getEnergyReserve();
            this.coverColor = notebook.getCoverColor();
            this.bodyMaterial = notebook.getBodyMaterial();
            this.coverMaterial = notebook.getCoverMaterial();
            this.weight = notebook.getWeight();
            this.width = notebook.getWidth();
            this.depth = notebook.getDepth();
            this.height = notebook.getHeight();
            this.inStock = notebook.getInStock();

            this.images = notebook.getImages();
        }
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    public String getOsVersion() {
        return osVersion;
    }

    public void setOsVersion(String osVersion) {
        this.osVersion = osVersion;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getScreenDiag() {
        return screenDiag;
    }

    public void setScreenDiag(String screenDiag) {
        this.screenDiag = screenDiag;
    }

    public String getScreenMaxResol() {
        return screenMaxResol;
    }

    public void setScreenMaxResol(String screenMaxResol) {
        this.screenMaxResol = screenMaxResol;
    }

    public String getScreenMatrix() {
        return screenMatrix;
    }

    public void setScreenMatrix(String screenMatrix) {
        this.screenMatrix = screenMatrix;
    }

    public String getProcSeries() {
        return procSeries;
    }

    public void setProcSeries(String procSeries) {
        this.procSeries = procSeries;
    }

    public String getProcName() {
        return procName;
    }

    public void setProcName(String procName) {
        this.procName = procName;
    }

    public Integer getProcCores() {
        return procCores;
    }

    public void setProcCores(Integer procCores) {
        this.procCores = procCores;
    }

    public Float getProcFreq() {
        return procFreq;
    }

    public void setProcFreq(Float procFreq) {
        this.procFreq = procFreq;
    }

    public Float getProcFreqTurbo() {
        return procFreqTurbo;
    }

    public void setProcFreqTurbo(Float procFreqTurbo) {
        this.procFreqTurbo = procFreqTurbo;
    }

    public Float getRam() {
        return ram;
    }

    public void setRam(Float ram) {
        this.ram = ram;
    }

    public String getRamType() {
        return ramType;
    }

    public void setRamType(String ramType) {
        this.ramType = ramType;
    }

    public String getGraphAdapterType() {
        return graphAdapterType;
    }

    public void setGraphAdapterType(String graphAdapterType) {
        this.graphAdapterType = graphAdapterType;
    }

    public String getGraphAdapter() {
        return graphAdapter;
    }

    public void setGraphAdapter(String graphAdapter) {
        this.graphAdapter = graphAdapter;
    }

    public String getSecondGraphAdapter() {
        return secondGraphAdapter;
    }

    public void setSecondGraphAdapter(String secondGraphAdapter) {
        this.secondGraphAdapter = secondGraphAdapter;
    }

    public Float getGraphMemory() {
        return graphMemory;
    }

    public void setGraphMemory(Float graphMemory) {
        this.graphMemory = graphMemory;
    }

    public String getHdiskType() {
        return hdiskType;
    }

    public void setHdiskType(String hdiskType) {
        this.hdiskType = hdiskType;
    }

    public Integer getHdiskCapacity() {
        return hdiskCapacity;
    }

    public void setHdiskCapacity(Integer hdiskCapacity) {
        this.hdiskCapacity = hdiskCapacity;
    }

    public Integer getBattery() {
        return battery;
    }

    public void setBattery(Integer battery) {
        this.battery = battery;
    }

    public Float getEnergyReserve() {
        return energyReserve;
    }

    public void setEnergyReserve(Float energyReserve) {
        this.energyReserve = energyReserve;
    }

    public String getCoverColor() {
        return coverColor;
    }

    public void setCoverColor(String coverColor) {
        this.coverColor = coverColor;
    }

    public String getBodyMaterial() {
        return bodyMaterial;
    }

    public void setBodyMaterial(String bodyMaterial) {
        this.bodyMaterial = bodyMaterial;
    }

    public String getCoverMaterial() {
        return coverMaterial;
    }

    public void setCoverMaterial(String coverMaterial) {
        this.coverMaterial = coverMaterial;
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

    public Float getWidth() {
        return width;
    }

    public void setWidth(Float width) {
        this.width = width;
    }

    public Float getDepth() {
        return depth;
    }

    public void setDepth(Float depth) {
        this.depth = depth;
    }

    public Float getHeight() {
        return height;
    }

    public void setHeight(Float height) {
        this.height = height;
    }

    public Boolean getInStock() {
        return inStock;
    }

    public void setInStock(Boolean inStock) {
        this.inStock = inStock;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }
}