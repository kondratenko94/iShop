package com.springapp.mvc.parser.notebook;

import com.springapp.mvc.dto.NotebookDto;

import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public abstract class NotebookBuilder {

    protected NotebookDto notebookDto;

    protected HashMap<String, String> elements;

    protected List<String> imageLinks;

    public NotebookDto getNotebookDtoDto() {
        return notebookDto;
    }

    public void createNewNotebookDto() { notebookDto = new NotebookDto(); }

    public abstract void parseUrl(String url);
    public abstract void buildName();
    public abstract void buildYear();
    public abstract void buildProducer();
    public abstract void buildKind();
    public abstract void buildOsVersion();
    public abstract void buildScreenDiag();
    public abstract void buildScreenMaxResol();
    public abstract void buildScreenMatrix();
    public abstract void buildProcSeries();
    public abstract void buildProcName();
    public abstract void buildProcCores();
    public abstract void buildProcFreq();
    public abstract void buildProcFreqTurbo();
    public abstract void buildRam();
    public abstract void buildRamType();
    public abstract void buildGraphAdapterType();
    public abstract void buildGraphAdapter();
    public abstract void buildSecondGraphAdapter();
    public abstract void buildGraphMemory();
    public abstract void buildHdiskType();
    public abstract void buildHdiskCapacity();
    public abstract void buildBattery();
    public abstract void buildEnergyReserve();
    public abstract void buildCoverColor();
    public abstract void buildBodyMaterial();
    public abstract void buildCoverMaterial();
    public abstract void buildWeight();
    public abstract void buildWidth();
    public abstract void buildDepth();
    public abstract void buildHeight();
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