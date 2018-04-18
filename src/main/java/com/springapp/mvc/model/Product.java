package com.springapp.mvc.model;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(name = "products")
@Inheritance(strategy = InheritanceType.JOINED)
public class Product {

    @Id
    @Access(AccessType.PROPERTY)
    @Column(name = "product_id", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", unique = true)
    @NotEmpty(message = "{Product.name.empty}")
    @Size(max = 60, message = "{Validator.long}")
    private String name;

    @Column(name = "price", precision = 8, scale = 2)
    @Range(min = 1, max = 1000000, message = "{Product.price.range}")
    @NotNull(message = "{Product.price.empty}")
    private BigDecimal price;

    @Column(name = "in_stock")
    private Boolean inStock;

    @Column(name = "type")
    private String type;

    @Column(name = "preview")
    private String preview;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product", cascade = CascadeType.ALL)
    private List<Review> reviews;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "product", orphanRemoval = true, cascade = CascadeType.ALL)
    @OrderBy("position ASC")
    private List<Image> images;

    public String getCaption() { return "product"; };

    public Object produceDto() { return null; };

    public String getShortDescription() { return ""; };

    public String getTruncatedName() {

        if (name.length() > 31) {

            if (name.length() > 32) {
                if (name.charAt(32) == ' ') {
                    return name.substring(0, 32);
                }
            }

            StringBuilder truncatedName = new StringBuilder(name.substring(0, 31));
            int lastSpace = truncatedName.lastIndexOf(" ");

            return lastSpace != -1 ? truncatedName.substring(0, lastSpace) : truncatedName.toString();

        } else {
            return name;
        }
    }

    public List<Review> getReviewsList() {
        Collections.sort(reviews);
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }


    public List<Image> getNonEmptyImages() {
        List<Image> sortedImages = images.stream()
                .filter(p -> !p.getLink().isEmpty())
                .collect(Collectors.toList());
        Collections.sort(sortedImages);

        return sortedImages;
    }

    public String getMainScreen() {
        return preview != null ? preview : "";
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public List<Image> getImages() {
        return images;
    }

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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Boolean getInStock() {
        return inStock;
    }

    public void setInStock(Boolean inStock) {
        this.inStock = inStock;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPreview() {
        return preview;
    }

    public void setPreview(String preview) {
        this.preview = preview;
    }

    public void updatePreview() {
        String p = "";
        if (images != null) {
            p = images.stream()
                    .filter( x -> !x.getLink().equals("") )
                    .min(Comparator.<Image>naturalOrder())
                    .map(Image::getLink)
                    .orElse("");
        }
        this.preview = p;
    }
}