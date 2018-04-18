package com.springapp.mvc.criteria;

import java.lang.reflect.Field;

public class FieldTypeDeterminer {

    public String getFieldType(Object o, String fieldName) {

        try {
            Field field = o.getClass().getDeclaredField(fieldName);
            String type = field.getType().getSimpleName();

            switch (type) {
                case "BigDecimal" : return "val_dbl";
                case "Integer" : return "val_int";
                default: return "";
            }

        } catch (NoSuchFieldException e) {
            return "";
        }
    }


    /*public String getFieldType(Object o, String fieldName) {

        try {
            Field field = o.getClass().getDeclaredField(fieldName);
            String name = field.getType().getSimpleName();

            return constructTypeByName(name);

        } catch (NoSuchFieldException e) {

            if (o.getClass().getSuperclass() != null) {

                try {
                    Field field = o.getClass().getSuperclass().getDeclaredField(fieldName);
                    String name = field.getType().getSimpleName();

                    return constructTypeByName(name);

                } catch (NoSuchFieldException e1) {
                    return "";
                }
            }

            return "";
        }
    }


    private String constructTypeByName(String type) {
        switch (type) {
            case "BigDecimal" : return "val_dbl";
            case "Integer" : return "val_int";
            default: return "";
        }
    }*/

}