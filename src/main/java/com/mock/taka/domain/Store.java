package com.mock.taka.domain;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "stores")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
public class Store  implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "store_id")
    String id;

    @Column(name = "store_name")
    String name;

    @Column(name = "image")
    String image;

    @Column(name = "description", columnDefinition = "TEXT")
    String description;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    User user;

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

    @OneToMany(mappedBy = "store")
    List<Product> products;
}
