package com.mock.taka.domain;
import java.sql.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name = "product_prices")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class ProductPrice {
    
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "price_id")
    String priceId;

    @Column(name = "value")
    double value;

    @Column(name = "discount")
    double discount;

    @Column(name = "description")
    String description;

    @Column(name = "effective_date")
    Date effectiveDate;
    
    @Column(name = "expiration_date")
    Date expirationDate;

    @CreatedDate
    @Column(name = "created_date")
    Date createdDate;

    @LastModifiedDate
    @Column(name = "modified_date")
    Date modifiedDate;

    @Column(name = "deleted_date")
    Date deletedDate;

    @Column(name = "status")
    String status;

    @OneToMany(mappedBy="price")
    List<Product> products;
}
