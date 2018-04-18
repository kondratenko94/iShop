package com.springapp.mvc.model;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "roles", catalog = "ishop")
public class Role {

    @Id
    @Column(name = "name")
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}