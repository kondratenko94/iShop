package com.springapp.mvc.model;

import com.springapp.mvc.dto.MobileDto;
import org.hibernate.annotations.Where;
import org.springframework.util.StringUtils;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(name = "mobiles", catalog = "ishop")
public class Mobile extends Product {

    @Column(name = "brand")
    @Size(max = 60, message = "{Validator.long}")
    private String brand;

    @Column(name = "platform")
    @Size(max = 60, message = "{Validator.long}")
    private String platform;

    @Column(name = "os_Version")
    @Size(max = 60, message = "{Validator.long}")
    private String osVersion;

    @Column(name = "screen_tech")
    @Size(max = 60, message = "{Validator.long}")
    private String screenTech;

    @Column(name = "screen_diag")
    @Size(max = 60, message = "{Validator.long}")
    private String screenDiag;

    @Column(name = "screen_resol")
    @Size(max = 60, message = "{Validator.long}")
    private String screenResol;

    @Column(name = "proc_name")
    @Size(max = 60, message = "{Validator.long}")
    private String procName;

    @Column(name = "proc_freq")
    private Integer procFreq;

    @Column(name = "proc_cores")
    private Integer procCores;

    @Column(name = "accelerator")
    @Size(max = 60, message = "{Validator.long}")
    private String accelerator;

    @Column(name = "ram")
    private Integer ram;

    @Column(name = "memory")
    private Integer memory;

    @Column(name = "support_sd")
    private Boolean supportSd;

    @Column(name = "camera")
    private Float camera;

    @Column(name = "front_camera")
    private Float frontCamera;

    @Column(name = "video")
    private Boolean video;

    @Column(name = "flash")
    private Boolean flash;

    @Column(name = "auto_focus")
    private Boolean autoFocus;

    @Column(name = "battery")
    private Integer battery;

    @Column(name = "year")
    private Integer year;

    @Column(name = "width")
    private Float width;

    @Column(name = "weight")
    private Float weight;

    @Column(name = "thickness")
    private Float thickness;

    @Column(name = "height")
    private Float height;

    @Transient
    private Boolean favourite;

    @Transient
    public static final String TYPE = "mobile";

    @Override
    public String getType() {
        return TYPE;
    }

    @Override
    public String getCaption() {
        return "Мобильный телефон";
    }

    @Override
    public Object produceDto() {
        return new MobileDto(this);
    }

    private void addComma(StringBuilder description) {
        if (description.length() > 0) {
            description.append(", ");
        }
    }

    @Override
    public String getShortDescription() {
        StringBuilder description = new StringBuilder();

        if ( platform != null && !StringUtils.isEmpty(platform) ) {
            description.append(platform);
        }
        if ( screenDiag != null && !StringUtils.isEmpty(screenDiag) ) {
            addComma(description);
            description.append("экран ").append(screenDiag).append("\"");
        }
        if ( screenTech != null && !StringUtils.isEmpty(screenTech) ) {
            addComma(description);
            description.append(screenTech);
        }
        if ( screenResol != null && !StringUtils.isEmpty(screenResol) ) {
            addComma(description);
            description.append(screenResol);
        }
        if ( procName != null && !StringUtils.isEmpty(procName) ) {
            addComma(description);
            description.append("процессор ").append(procName);
        }
        if ( procFreq != null ) {
            addComma(description);
            description.append(procFreq).append(" МГц");
        }
        if ( procCores != null ) {
            addComma(description);
            description.append("количество ядер : ").append(procCores);
        }
        if ( ram != null ) {
            addComma(description);
            description.append("ОЗУ ").append(ram / 1000).append(" ГБ");
        }
        if ( memory != null ) {
            addComma(description);
            description.append("память ").append(memory / 1000).append(" ГБ");
        }
        if ( supportSd != null && supportSd ) {
            addComma(description);
            description.append("карты памяти");
        }
        if ( camera != null ) {
            addComma(description);
            description.append("камера ").append(camera).append(" МП");
        }
        if ( battery != null ) {
            addComma(description);
            description.append("аккумулятор ").append(battery).append(" мАч");
        }

        if ( description.length() > 0 ) {
            description.append(".");
        }

        return description.toString();
    }

    public void consumeMobile(Mobile mobile) {
        setName( mobile.getName() );
        setPrice( mobile.getPrice() );
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
        setInStock( mobile.getInStock() );
    }

    public String getAccelerator() {
        return accelerator;
    }

    public void setAccelerator(String accelerator) {
        this.accelerator = accelerator;
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

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
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

    public Boolean getFlash() {
        return flash;
    }

    public void setFlash(Boolean flash) {
        this.flash = flash;
    }

    public Float getHeight() {
        return height;
    }

    public void setHeight(Float height) {
        this.height = height;
    }

    public Integer getMemory() {
        return memory;
    }

    public void setMemory(Integer memory) {
        this.memory = memory;
    }

    public String getOsVersion() {
        return osVersion;
    }

    public void setOsVersion(String osVersion) {
        this.osVersion = osVersion;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public Integer getProcCores() {
        return procCores;
    }

    public void setProcCores(Integer procCores) {
        this.procCores = procCores;
    }

    public Integer getProcFreq() {
        return procFreq;
    }

    public void setProcFreq(Integer procFreq) {
        this.procFreq = procFreq;
    }

    public String getProcName() {
        return procName;
    }

    public void setProcName(String procName) {
        this.procName = procName;
    }

    public Integer getRam() {

        return ram;
    }

    public void setRam(Integer ram) {
        this.ram = ram;
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

    public String getScreenTech() {
        return screenTech;
    }

    public void setScreenTech(String screenTech) {
        this.screenTech = screenTech;
    }

    public Boolean getSupportSd() {
        return supportSd;
    }

    public void setSupportSd(Boolean supportSd) {
        this.supportSd = supportSd;
    }

    public Float getThickness() {
        return thickness;
    }

    public void setThickness(Float thickness) {
        this.thickness = thickness;
    }

    public Boolean getVideo() {
        return video;
    }

    public void setVideo(Boolean video) {
        this.video = video;
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

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public Boolean getFavourite() {
        return favourite;
    }

    public void setFavourite(Boolean favourite) {
        this.favourite = favourite;
    }
}
