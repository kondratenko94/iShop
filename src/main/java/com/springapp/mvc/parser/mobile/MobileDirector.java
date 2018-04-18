package com.springapp.mvc.parser.mobile;

import com.springapp.mvc.dto.MobileDto;

public class MobileDirector {

    private MobileBuilder builder;

    public MobileDirector(MobileBuilder builder) {
        this.builder = builder;
    }
    public MobileDto getMobileDto() {
        return builder.getMobileDto();
    }

    public void constructMobileDto(String url) {
        builder.createNewMobileDto();
        builder.parseUrl(url);
        builder.buildName();
        builder.buildYear();
        builder.buildBrand();
        builder.buildWeight();
        builder.buildWidth();
        builder.buildThickness();
        builder.buildHeight();
        builder.buildScreenTech();
        builder.buildScreenDiag();
        builder.buildScreenResol();
        builder.buildPlatform();
        builder.buildOsVersion();
        builder.buildProcFreq();
        builder.buildProcCores();
        builder.buildProcName();
        builder.buildAccelerator();
        builder.buildRam();
        builder.buildMemory();
        builder.buildSupportSd();
        builder.buildCamera();
        builder.buildFrontCamera();
        builder.buildVideo();
        builder.buildFlash();
        builder.buildAutoFocus();
        builder.buildBattery();
        builder.buildImages();
    }
}