package com.springapp.mvc.model;

import com.springapp.mvc.dto.NotebookDto;
import org.hibernate.annotations.Where;
import org.springframework.util.StringUtils;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(name = "notebooks", catalog = "ishop")
public class Notebook extends Product{

    @Column(name = "year")
    private Integer year;

    @Column(name = "producer")
    @Size(max = 60, message = "{Validator.long}")
    private String producer;

    @Column(name = "os_version")
    @Size(max = 60, message = "{Validator.long}")
    private String osVersion;

    @Column(name = "kind")
    @Size(max = 60, message = "{Validator.long}")
    private String kind;

    @Column(name = "screen_diag")
    @Size(max = 60, message = "{Validator.long}")
    private String screenDiag;

    @Column(name = "screen_max_resol")
    @Size(max = 60, message = "{Validator.long}")
    private String screenMaxResol;

    @Column(name = "screen_matrix")
    @Size(max = 60, message = "{Validator.long}")
    private String screenMatrix;

    @Column(name = "proc_series")
    @Size(max = 60, message = "{Validator.long}")
    private String procSeries;

    @Column(name = "proc_name")
    @Size(max = 60, message = "{Validator.long}")
    private String procName;

    @Column(name = "proc_cores")
    private Integer procCores;

    @Column(name = "proc_freq")
    private Float procFreq;

    @Column(name = "proc_freq_turbo")
    private Float procFreqTurbo;

    @Column(name = "ram")
    private Float ram;

    @Column(name = "ram_type")
    @Size(max = 60, message = "{Validator.long}")
    private String ramType;

    @Column(name = "graph_adapter_type")
    @Size(max = 60, message = "{Validator.long}")
    private String graphAdapterType;

    @Column(name = "graph_adapter")
    @Size(max = 60, message = "{Validator.long}")
    private String graphAdapter;

    @Column(name = "second_graph_adapter")
    @Size(max = 60, message = "{Validator.long}")
    private String secondGraphAdapter;

    @Column(name = "graph_memory")
    private Float graphMemory;

    @Column(name = "hdisk_type")
    @Size(max = 60, message = "{Validator.long}")
    private String hdiskType;

    @Column(name = "hdisk_capacity")
    private Integer hdiskCapacity;

    @Column(name = "battery")
    private Integer battery;

    @Column(name = "energy_reserve")
    private Float energyReserve;

    @Column(name = "cover_color")
    @Size(max = 60, message = "{Validator.long}")
    private String coverColor;

    @Column(name = "body_material")
    @Size(max = 60, message = "{Validator.long}")
    private String bodyMaterial;

    @Column(name = "cover_material")
    @Size(max = 60, message = "{Validator.long}")
    private String coverMaterial;

    @Column(name = "weight")
    private Float weight;

    @Column(name = "width")
    private Float width;

    @Column(name = "depth")
    private Float depth;

    @Column(name = "height")
    private Float height;

    @Transient
    private Boolean favourite;

    @Transient
    public static final String TYPE = "notebook";

    @Override
    public String getType() {
        return TYPE;
    }

    @Override
    public Object produceDto() {
        return new NotebookDto(this);
    }

    private void addComma(StringBuilder description) {
        if (description.length() > 0) {
            description.append(", ");
        }
    }

    @Override
    public String getShortDescription() {
        StringBuilder description = new StringBuilder();

        if ( kind != null  && !StringUtils.isEmpty(kind) ) {
            description.append(kind);
        }
        if ( screenDiag != null && !StringUtils.isEmpty(screenDiag) ) {
            addComma(description);
            description.append("экран ").append(screenDiag).append("\"");
        }
        if ( screenMaxResol != null && !StringUtils.isEmpty(screenMaxResol) ) {
            addComma(description);
            description.append(screenMaxResol);
        }
        if ( procName != null && !StringUtils.isEmpty(procName) ) {
            addComma(description);
            description.append(procName);
        }
        if ( procFreq != null ) {
            addComma(description);
            description.append(procFreq).append(" ГГц");
        }
        if ( procCores != null ) {
            addComma(description);
            description.append(procCores).append(" ядерный");
        }
        if ( graphAdapter != null && !StringUtils.isEmpty(graphAdapter) ) {
            addComma(description);
            description.append(graphAdapter);
        }
        if ( ram != null ) {
            addComma(description);
            description.append("ОЗУ ").append(ram).append(" ГБ");
        }
        if ( hdiskCapacity != null ) {
            addComma(description);
            description.append("память ").append(hdiskCapacity).append(" ГБ");
        }
        if ( weight != null ) {
            addComma(description);
            description.append("вес ").append(weight).append(" кг");
        }
        if ( description.length() > 0 ) {
            description.append(".");
        }

        return description.toString();
    }

    @Override
    public String getCaption() {
        return "Ноутбук";
    }

    public void consumeNotebook(Notebook notebook) {
        setName( notebook.getName() );
        setPrice( notebook.getPrice() );
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
        setInStock( notebook.getInStock() );
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getOsVersion() {
        return osVersion;
    }

    public void setOsVersion(String osVersion) {
        this.osVersion = osVersion;
    }

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
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

    public Boolean getFavourite() {
        return favourite;
    }

    public void setFavourite(Boolean favourite) {
        this.favourite = favourite;
    }

    @Override
    public String toString() {
        return "Notebook{" +
                ", year=" + year +
                ", osVersion='" + osVersion + '\'' +
                ", screenDiag='" + screenDiag + '\'' +
                ", screenMaxResol='" + screenMaxResol + '\'' +
                ", screenMatrix='" + screenMatrix + '\'' +
                ", procSeries='" + procSeries + '\'' +
                ", procName='" + procName + '\'' +
                ", procCores=" + procCores +
                ", procFreq=" + procFreq +
                ", procFreqTurbo=" + procFreqTurbo +
                ", ram=" + ram +
                ", ramType='" + ramType + '\'' +
                ", graphAdapterType='" + graphAdapterType + '\'' +
                ", graphAdapter='" + graphAdapter + '\'' +
                ", graphMemory=" + graphMemory +
                ", hdiskType='" + hdiskType + '\'' +
                ", hdiskCapacity=" + hdiskCapacity +
                ", battery=" + battery +
                ", energyReserve=" + energyReserve +
                ", coverColor='" + coverColor + '\'' +
                ", bodyMaterial='" + bodyMaterial + '\'' +
                ", coverMaterial='" + coverMaterial + '\'' +
                ", weight=" + weight +
                ", width=" + width +
                ", depth=" + depth +
                ", favourite=" + favourite +
                '}';
    }
}
