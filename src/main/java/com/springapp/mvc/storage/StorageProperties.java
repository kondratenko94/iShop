package com.springapp.mvc.storage;

import org.springframework.context.annotation.Configuration;

@Configuration
public class StorageProperties {

    //need to have rw permissions
    private String location = "/srv/ishop/images";

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
