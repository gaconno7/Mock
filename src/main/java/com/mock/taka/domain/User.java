package com.mock.taka.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @NotNull
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    String email;

    @NotNull
    @Size(message = "Password phải có tối thiểu 5 kí tự", min = 5)
    String password;

    @NotNull
    @Size(message = "Họ tên phải có tối thiểu 2 kí tự", min = 2)
    String fullname;

    String address;

    @Size(message = "Số điện thoại không hợp lệ", min = 10)
    @Pattern(regexp = "\\d+", message = "Số điện thoại chỉ được chứa chữ số")
    String phone;

    String avatar;

    @ManyToOne
    @JoinColumn(name = "role_id")
    Role role;

    @OneToOne(mappedBy = "user")
    Store store;

    @CreatedDate
    @Column(name = "created_date")
    Date createdDate;

    @LastModifiedDate
    @Column(name = "modified_date")
    Date modifiedDate;

    @Column(name = "deleted_date")
    Date deletedDate;

    @Column(name = "status")
    private boolean status = true;

    public void setStatus(boolean status) {
        this.status = status;
        if (status == false) {
            this.deletedDate = new Date();
        }
    }
}
