package com.springapp.mvc.parser.mobile;
import com.springapp.mvc.model.Image;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ShopByMobileBuilder extends MobileBuilder {

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
            mobileDto.setName( value.replace("Мобильный телефон ", "") );
        }
    }

    @Override
    public void buildYear() {
        String value = elements.get("Дата выхода на рынок");
        if (value != null) {
            mobileDto.setYear( extractInt(value) );
        }
    }

    @Override
    public void buildBrand() {
        String value = elements.get("Название товара");
        if (value != null) {
            String name = value.replace("Мобильный телефон ", "");
            if (name.contains(" ")) {
                mobileDto.setBrand( name.substring(0, name.indexOf(" ")) );
            }
        }
    }

    @Override
    public void buildWeight() {
        String value = elements.get("Вес, г");
        if (value != null) {
            mobileDto.setWeight( extractFloat(value) );
        }

    }

    @Override
    public void buildWidth() {
        String value = elements.get("Ширина, см");
        if (value != null) {
            mobileDto.setWidth( extractFloat(value) );
        }
    }

    @Override
    public void buildThickness() {
        String value = elements.get("Толщина, см");
        if (value != null) {
            mobileDto.setThickness( extractFloat(value) );
        }
    }

    @Override
    public void buildHeight() {
        String value = elements.get("Высота, см");
        if (value != null) {
            mobileDto.setHeight( extractFloat(value) );
        }
    }

    @Override
    public void buildScreenTech() {
        String value = elements.get("Технология экрана");
        if (value != null) {
            mobileDto.setScreenTech(value);
        }
    }

    @Override
    public void buildScreenDiag() {
        String value = elements.get("Диагональ экрана, \"");
        if (value != null) {
            mobileDto.setScreenDiag(value);
        }
    }

    @Override
    public void buildScreenResol() {
        String value = elements.get("Разрешение экрана, точек");
        if (value != null) {
            mobileDto.setScreenResol( extractFirstWord(value) );
        }
    }

    @Override
    public void buildPlatform() {
        String value = elements.get("Платформа");
        if (value != null) {
            mobileDto.setPlatform(value);
        }
    }

    @Override
    public void buildOsVersion() {
        String value = elements.get("Версия ОС");
        if (value != null) {
            mobileDto.setOsVersion(value);
        }
    }

    @Override
    public void buildProcFreq() {
        String value = elements.get("Частота процессора, МГц");
        if (value != null) {
            mobileDto.setProcFreq( extractInt(value) );
        }
    }

    @Override
    public void buildProcCores() {
        String value = elements.get("Количество ядер процессора");
        if (value != null) {
            mobileDto.setProcCores( extractInt(value) );
        }
    }

    @Override
    public void buildProcName() {
        String value = elements.get("Процессор");
        if (value != null) {
            mobileDto.setProcName(value);
        }
    }

    @Override
    public void buildAccelerator() {
        String value = elements.get("Графический процессор");
        if (value != null) {
            mobileDto.setAccelerator(value);
        }
    }

    @Override
    public void buildRam() {
        String value = elements.get("Объем оперативной памяти");
        if (value != null) {
            value = value.replace("Гб", "000");
            mobileDto.setRam( extractInt(value) );
        }
    }

    @Override
    public void buildMemory() {
        String value = elements.get("Объем внутренней памяти");
        if (value != null) {
            value = value.replace("Гб", "000");
            mobileDto.setMemory( extractInt(value) );
        }
    }

    @Override
    public void buildSupportSd() {
        String value = elements.get("Поддержка карт памяти");
        if (value != null) {
            mobileDto.setSupportSd( extractBool(value) );
        }
    }

    @Override
    public void buildCamera() {
        String value = elements.get("Разрешение основной камеры, Мп");
        if (value != null) {
            mobileDto.setCamera( extractFloat(value) );
        }
    }

    @Override
    public void buildFrontCamera() {
        String value = elements.get("Разрешение фронтальной камеры, Мп");
        if (value != null) {
            mobileDto.setFrontCamera( extractFloat(value) );
        }
    }

    @Override
    public void buildVideo() {
        String value = elements.get("Запись видео");
        if (value != null) {
            mobileDto.setVideo( extractBool(value) );
        }
    }

    @Override
    public void buildFlash() {
        String value = elements.get("Вспышка");
        if (value != null) {
            mobileDto.setFlash( extractBool(value) );
        }
    }

    @Override
    public void buildAutoFocus() {
        String value = elements.get("Автофокус");
        if (value != null) {
            mobileDto.setAutoFocus( extractBool(value) );
        }
    }

    @Override
    public void buildBattery() {
        String value = elements.get("Емкость аккумулятора, мАч");
        if (value != null) {
            mobileDto.setBattery( extractInt(value) );
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

        mobileDto.setImages(images);
    }
}