package com.mock.taka.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name = "roles")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
public class Role  implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;
    String name;
    String description;

    @OneToMany(mappedBy = "role")
    private List<User> users;

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
}
