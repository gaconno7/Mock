package com.mock.taka.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import lombok.experimental.FieldDefaults;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name = "categories")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Category  implements Serializable {

    @Id
    @Column(name = "category_id")
    @GeneratedValue(strategy=GenerationType.UUID)
    String id;

    @Column(name = "category_name")
    String name;

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

    @Column(name = "status")
    boolean status;

    @Column(name = "image")
    String image;

    @OneToMany(mappedBy = "category", fetch = FetchType.EAGER)
    List<Product> products;
}
