package com.mock.taka.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
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
    @NotNull
    @NotEmpty(message = "Tên loại sản phẩm không được để trống")
    String name;

    @Column(name = "description")
    @NotNull
    @NotEmpty(message = "Miêu tả không được để trống")
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
    boolean status = true;
    public void setStatus(boolean status) {
        this.status = status;
        // Cập nhật deletedDate khi soft delete
        if (status == false) {
            this.deletedDate = new Date();
        }
    }

    @Column(name = "image")
    String image;

    @OneToMany(mappedBy = "category", fetch = FetchType.EAGER)
    List<Product> products;

}
