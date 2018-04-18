package com.springapp.mvc.parser.notebook;

import com.springapp.mvc.model.Image;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ShopByNotebookBuilder extends NotebookBuilder {

    @Override
    public void parseUrl(String url) {
        Document doc;
        try {

            doc = Jsoup.connect(url).get();
            elements = new HashMap<>(64);

            Element table = doc.select("table[class=ModelCharacteristic__TableDesc]").first();
            Element previousTd = null;
            int i = 1;
            for (Element td : table.select("td.PageForTable__TitleCharacter.PageForTable__InfoCharacter, td.PageForTable__ValueCharacter.PageForTable__InfoCharacter")) {

                if (i % 2 == 0) {
                    elements.put(previousTd.text(), td.text());
                }

                previousTd = td;
                i++;
            }

            Element caption = doc.select("h1[class=Page__TitleActivePage hidden-xs]").first();
            if (caption != null) {
                elements.put("Название товара", caption.text());
            }

            Elements imageElements = doc.select("img[class=ModelGallery__BigImage]");
            imageLinks = new ArrayList<>();

            int count = 0;
            for (Element img : imageElements) {
                if (count++ >= Image.CAPACITY) break;
                imageLinks.add(img.attr("abs:src"));
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void buildName() {
        String value = elements.get("Название товара");
        if (value != null) {
            if (value.contains(" ")) {
                notebookDto.setName(value.substring(value.indexOf(" "), value.length()).trim());
            } else {
                notebookDto.setName(value);
            }
        }
    }

    @Override
    public void buildYear() {
        String value = elements.get("Дата выхода на рынок");
        if (value != null) {
            notebookDto.setYear( extractInt(value) );
        }
    }

    @Override
    public void buildProducer() {
        String value = elements.get("Название товара");
        if (value != null) {
            if (value.contains(" ")) {
                String name = value.substring( value.indexOf(" "), value.length() ).trim();
                if (name.contains(" ")) {
                    notebookDto.setProducer( name.substring( 0, name.indexOf(" ") ).trim() );
                } else {
                    notebookDto.setProducer(name);
                }
            } else {
                notebookDto.setProducer(value);
            }
        }
    }

    @Override
    public void buildKind() {
        String value = elements.get("Тип");
        if (value != null) {
            notebookDto.setKind(value);
        }
    }

    @Override
    public void buildOsVersion() {
        String value = elements.get("Операционная система");
        if (value != null) {
            notebookDto.setOsVersion(value);
        }
    }

    @Override
    public void buildScreenDiag() {
        String value = elements.get("Диагональ экрана, \"");
        if (value != null) {
            notebookDto.setScreenDiag(value);
        }
    }

    @Override
    public void buildScreenMaxResol() {
        String value = elements.get("Макс. разрешение экрана, точек");
        if (value != null) {
            notebookDto.setScreenMaxResol(value);
        }
    }

    @Override
    public void buildScreenMatrix() {
        String value = elements.get("Тип матрицы экрана");
        if (value != null) {
            notebookDto.setScreenMatrix(value);
        }
    }

    @Override
    public void buildProcSeries() {
        String value = elements.get("Серия процессора");
        if (value != null) {
            notebookDto.setProcSeries(value);
        }
    }

    @Override
    public void buildProcName() {
        String value = elements.get("Процессор");
        if (value != null) {
            notebookDto.setProcName(value);
        }
    }

    @Override
    public void buildProcCores() {
        String value = elements.get("Количество ядер процессора");
        if (value != null) {
            notebookDto.setProcCores( extractInt(value) );
        }
    }

    @Override
    public void buildProcFreq() {
        String value = elements.get("Частота процессора, ГГц");
        if (value != null) {
            notebookDto.setProcFreq( extractFloat(value) );
        }
    }

    @Override
    public void buildProcFreqTurbo() {
        String value = elements.get("Turbo-частота процессора, ГГц");
        if (value != null) {
            notebookDto.setProcFreqTurbo( extractFloat(value) );
        }
    }

    @Override
    public void buildRam() {
        String value = elements.get("Объем оперативной памяти, Гб");
        if (value != null) {
            notebookDto.setRam( extractFloat(value) );
        }
    }

    @Override
    public void buildRamType() {
        String value = elements.get("Тип оперативной памяти");
        if (value != null) {
            notebookDto.setRamType(value);
        }
    }

    @Override
    public void buildGraphAdapterType() {
        String value = elements.get("Тип графического адаптера");
        if (value != null) {
            notebookDto.setGraphAdapterType(value);
        }
    }

    @Override
    public void buildGraphAdapter() {
        String value = elements.get("Графический адаптер");
        if (value != null) {
            if (value.contains("(")) {
                notebookDto.setGraphAdapter( value.substring(0, value.indexOf("(")).replaceAll("\u00A0", "").trim() );
            } else {
                notebookDto.setGraphAdapter(value);
            }
        }
    }

    @Override
    public void buildSecondGraphAdapter() {
        String value = elements.get("Графический адаптер");
        if (value != null) {
            Matcher matcher = Pattern.compile("\\([+ ]*([A-zA-Z0-9 ]*)\\)").matcher(value);
            if (matcher.find()) {
                notebookDto.setSecondGraphAdapter( matcher.group(1) );
            }
        }
    }

    @Override
    public void buildGraphMemory() {
        String value = elements.get("Объем памяти графического адаптера, Гб");
        if (value != null) {
            notebookDto.setGraphMemory( extractFloat(value) );
        }
    }

    @Override
    public void buildHdiskType() {
        String value = elements.get("Тип жесткого диска");
        if (value != null) {
            notebookDto.setHdiskType(value);
        }
    }

    @Override
    public void buildHdiskCapacity() {
        String value = elements.get("Объем жесткого диска, Гб");
        if (value != null) {
            notebookDto.setHdiskCapacity( extractInt(value) );
        }
    }

    @Override
    public void buildBattery() {
        String value = elements.get("Емкость аккумулятора, мАч");
        if (value != null) {
            notebookDto.setBattery( extractInt(value) );
        }
    }

    @Override
    public void buildEnergyReserve() {
        String value = elements.get("Запас энергии аккумулятора, Вт·ч");
        if (value != null) {
            notebookDto.setEnergyReserve( extractFloat(value) );
        }
    }

    @Override
    public void buildCoverColor() {
        String value = elements.get("Цвет крышки");
        if (value != null) {
            notebookDto.setCoverColor(value);
        }
    }

    @Override
    public void buildBodyMaterial() {
        String value = elements.get("Материал корпуса");
        if (value != null) {
            notebookDto.setBodyMaterial(value);
        }
    }

    @Override
    public void buildCoverMaterial() {
        String value = elements.get("Материал крышки");
        if (value != null) {
            notebookDto.setCoverMaterial(value);
        }
    }

    @Override
    public void buildWeight() {
        String value = elements.get("Вес, кг");
        if (value != null) {
            notebookDto.setWeight( extractFloat(value) );
        }
    }

    @Override
    public void buildWidth() {
        String value = elements.get("Ширина, см");
        if (value != null) {
            notebookDto.setWidth( extractFloat(value) );
        }
    }

    @Override
    public void buildDepth() {
        String value = elements.get("Глубина, см");
        if (value != null) {
            notebookDto.setDepth( extractFloat(value) );
        }
    }

    @Override
    public void buildHeight() {
        String value = elements.get("Высота, см");
        if (value != null) {
            notebookDto.setHeight( extractFloat(value) );
        }
    }

    @Override
    public void buildImages() {

        List<Image> images = new ArrayList<>();

        int i = 0;
        for (String link : imageLinks) {
            Image image = new Image();
            image.setLink(link);
            image.setPosition( i++ );

            images.add(image);
        }

        notebookDto.setImages(images);
    }
}