package com.springapp.mvc.dto;

import com.springapp.mvc.model.Image;
import com.springapp.mvc.model.Mobile;

import java.math.BigDecimal;
import java.util.List;

public class MobileDto {

    private Integer id;

    private String name;

    private BigDecimal price;

    private String brand;

    private String platform;

    private String osVersion;

    private String screenTech;

    private String screenDiag;

    private String screenResol;

    private String procName;

    private Integer procFreq;

    private Integer procCores;

    private String accelerator;

    private Integer ram;

    private Integer memory;

    private Boolean supportSd;

    private Float camera;

    private Float frontCamera;

    private Boolean video;

    private Boolean flash;

    private Boolean autoFocus;

    private Integer battery;

    private Integer year;

    private Float width;

    private Float weight;

    private Float thickness;

    private Float height;

    private Boolean inStock;

    private List<Image> images;

    public MobileDto() {}

    public MobileDto(Mobile mobile) {

        if (mobile != null) {
            this.id = mobile.getId();
            this.name = mobile.getName();
            this.price = mobile.getPrice();
            this.brand = mobile.getBrand();
            this.platform = mobile.getPlatform();
            this.osVersion = mobile.getOsVersion();
            this.screenTech = mobile.getScreenTech();
            this.screenDiag = mobile.getScreenDiag();
            this.screenResol = mobile.getScreenResol();
            this.procName = mobile.getProcName();
            this.procFreq = mobile.getProcFreq();
            this.procCores = mobile.getProcCores();
            this.accelerator = mobile.getAccelerator();
            this.ram = mobile.getRam();
            this.memory = mobile.getMemory();
            this.supportSd = mobile.getSupportSd();
            this.camera = mobile.getCamera();
            this.frontCamera = mobile.getFrontCamera();
            this.video = mobile.getVideo();
            this.flash = mobile.getFlash();
            this.autoFocus = mobile.getAutoFocus();
            this.battery = mobile.getBattery();
            this.year = mobile.getYear();
            this.width = mobile.getWidth();
            this.weight = mobile.getWeight();
            this.thickness = mobile.getThickness();
            this.height = mobile.getHeight();
            this.inStock = mobile.getInStock();

            this.images = mobile.getImages();
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

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public String getOsVersion() {
        return osVersion;
    }

    public void setOsVersion(String osVersion) {
        this.osVersion = osVersion;
    }

    public String getScreenTech() {
        return screenTech;
    }

    public void setScreenTech(String screenTech) {
        this.screenTech = screenTech;
    }

    public String getScreenDiag() {
        return screenDiag;
    }

    public void setScreenDiag(String screenDiag) {
        this.screenDiag = screenDiag;
    }

    public String getScreenResol() {
        return screenResol;
    }

    public void setScreenResol(String screenResol) {
        this.screenResol = screenResol;
    }

    public String getProcName() {
        return procName;
    }

    public void setProcName(String procName) {
        this.procName = procName;
    }

    public Integer getProcFreq() {
        return procFreq;
    }

    public void setProcFreq(Integer procFreq) {
        this.procFreq = procFreq;
    }

    public Integer getProcCores() {
        return procCores;
    }

    public void setProcCores(Integer procCores) {
        this.procCores = procCores;
    }

    public String getAccelerator() {
        return accelerator;
    }

    public void setAccelerator(String accelerator) {
        this.accelerator = accelerator;
    }

    public Integer getRam() {
        return ram;
    }

    public void setRam(Integer ram) {
        this.ram = ram;
    }

    public Integer getMemory() {
        return memory;
    }

    public void setMemory(Integer memory) {
        this.memory = memory;
    }

    public Boolean getSupportSd() {
        return supportSd;
    }

    public void setSupportSd(Boolean supportSd) {
        this.supportSd = supportSd;
    }

    public Float getCamera() {
        return camera;
    }

    public void setCamera(Float camera) {
        this.camera = camera;
    }

    public Float getFrontCamera() {
        return frontCamera;
    }

    public void setFrontCamera(Float frontCamera) {
        this.frontCamera = frontCamera;
    }

    public Boolean getVideo() {
        return video;
    }

    public void setVideo(Boolean video) {
        this.video = video;
    }

    public Boolean getFlash() {
        return flash;
    }

    public void setFlash(Boolean flash) {
        this.flash = flash;
    }

    public Boolean getAutoFocus() {
        return autoFocus;
    }

    public void setAutoFocus(Boolean autoFocus) {
        this.autoFocus = autoFocus;
    }

    public Integer getBattery() {
        return battery;
    }

    public void setBattery(Integer battery) {
        this.battery = battery;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Float getWidth() {
        return width;
    }

    public void setWidth(Float width) {
        this.width = width;
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

    public Float getThickness() {
        return thickness;
    }

    public void setThickness(Float thickness) {
        this.thickness = thickness;
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