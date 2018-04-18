package com.springapp.mvc.parser.mobile;

import com.springapp.mvc.dto.MobileDto;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public abstract class MobileBuilder {

    protected MobileDto mobileDto;

    protected HashMap<String, String> elements;

    protected List<String> imageLinks;

    public MobileDto getMobileDto() {
        return mobileDto;
    }

    public void createNewMobileDto() { mobileDto = new MobileDto(); }

    public abstract void parseUrl(String url);
    public abstract void buildName();
    public abstract void buildYear();
    public abstract void buildBrand();
    public abstract void buildWeight();
    public abstract void buildWidth();
    public abstract void buildThickness();
    public abstract void buildHeight();
    public abstract void buildScreenTech();
    public abstract void buildScreenDiag();
    public abstract void buildScreenResol();
    public abstract void buildPlatform();
    public abstract void buildOsVersion();
    public abstract void buildProcFreq();
    public abstract void buildProcCores();
    public abstract void buildProcName();
    public abstract void buildAccelerator();
    public abstract void buildRam();
    public abstract void buildMemory();
    public abstract void buildSupportSd();
    public abstract void buildCamera();
    public abstract void buildFrontCamera();
    public abstract void buildVideo();
    public abstract void buildFlash();
    public abstract void buildAutoFocus();
    public abstract void buildBattery();
    public abstract void buildImages();


    protected Integer extractInt(String expression) {
        expression = expression.replaceAll(" ", "");
        Matcher matcher = Pattern.compile("([0-9]+)").matcher(expression);
        if (matcher.find()) {
            return Integer.parseInt(matcher.group(1));
        } else return null;
    }

    protected Float extractFloat(String expression) {
        expression = expression.replaceAll(" ", "");
        Matcher matcher = Pattern.compile("([0-9.]+)").matcher(expression);
        if (matcher.find()) {
            return Float.parseFloat(matcher.group(1));
        } else return null;
    }

    protected String extractFirstWord(String expression) {
        return expression.contains(" ") ? expression.substring(0, expression.indexOf(" ")) : expression;
    }

    protected boolean extractBool(String expression) {

        return expression.contains("Есть");
    }

}