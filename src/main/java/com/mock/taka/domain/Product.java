package com.mock.taka.domain;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name = "products")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
public class Product implements Serializable {

    @Id
    @GeneratedValue(strategy= GenerationType.UUID)
    @Column(name="product_id")
    String id;

    @Column(name = "product_name")
    String name;

    @Column(name = "price")
    double price;

    @Column(name = "discount-price")
    double discountPrice;
    
    @Column(name = "quantity")
    int quantity;

    @Column(name = "image")
    String image;

    @Column(name = "description")
    String description;
    
    @CreatedDate
    @Column(name = "created_date")
    Date createdDate;

    @LastModifiedDate
    @Column(name = "modified_date")
    Date modifiedDate;

    @Column(name = "deleted_date")
    Date deletedDate;


    @Column(name = "is_deleted")
    private boolean deleted = false;

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
        // Cập nhật deletedDate khi soft delete
        if (deleted) {
            this.deletedDate = new Date();
        }
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
    Category category;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "store_id")
    Store store;

    @OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
    List<ProductVariant> productVariants;

    @OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
    List<ProductImage> productImages;

    @OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
    List<OrderDetail> orderDetails;

    @OneToMany(mappedBy = "product", fetch = FetchType.EAGER)
    List<Evaluation> evaluations;

    @Override
    public String toString() {
        return "Product{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", image='" + image + '\'' +
                ", description='" + description + '\'' +
                ", deleted=" + deleted +
                ", category=" + category +
                ", productVariants=" + productVariants +
                ", productImage=" + productImages +
                ", orderDetails=" + orderDetails +
                ", evaluations=" + evaluations +
                '}';
    }
}
