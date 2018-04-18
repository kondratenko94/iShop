package com.springapp.mvc.model;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "groups", catalog = "ishop")
public class Group implements Comparable<Group>{

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "group_name")
    private String name;

    @Column(name = "caption")
    private String caption;

    @Column(name = "rank")
    private Integer rank;

    @OneToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "group_authorities",
            joinColumns = {@JoinColumn(name = "group_id", referencedColumnName = "id")},
            inverseJoinColumns = {@JoinColumn(name = "authority")})
    private List<Role> roles;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    @Override
    public int compareTo(Group group) {
        if (group == null || group.getRank() == null) return 1;
        if (rank == null) return -1;

        return group.getRank() - rank;
    }
}
