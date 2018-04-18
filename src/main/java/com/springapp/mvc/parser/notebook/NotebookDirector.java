package com.springapp.mvc.parser.notebook;

import com.springapp.mvc.dto.NotebookDto;

public class NotebookDirector {

    private NotebookBuilder builder;

    public NotebookDirector(NotebookBuilder builder) {
        this.builder = builder;
    }
    public NotebookDto getNotebookDto() {
        return builder.getNotebookDtoDto();
    }

    public void constructNotebookDto(String url) {
        builder.createNewNotebookDto();
        builder.parseUrl(url);
        builder.buildName();
        builder.buildYear();
        builder.buildProducer();
        builder.buildKind();
        builder.buildOsVersion();
        builder.buildScreenDiag();
        builder.buildScreenMaxResol();
        builder.buildScreenMatrix();
        builder.buildProcSeries();
        builder.buildProcName();
        builder.buildProcCores();
        builder.buildProcFreq();
        builder.buildProcFreqTurbo();
        builder.buildRam();
        builder.buildRamType();
        builder.buildGraphAdapterType();
        builder.buildGraphAdapter();
        builder.buildSecondGraphAdapter();
        builder.buildGraphMemory();
        builder.buildHdiskType();
        builder.buildHdiskCapacity();
        builder.buildBattery();
        builder.buildEnergyReserve();
        builder.buildCoverColor();
        builder.buildBodyMaterial();
        builder.buildCoverMaterial();
        builder.buildWeight();
        builder.buildWidth();
        builder.buildDepth();
        builder.buildHeight();
        builder.buildImages();
    }

}