package com.mock.taka.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "users")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
public class User  implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @NotNull
    String email;

    @JsonIgnore
    @NotNull
    String password;

    @NotNull
    String fullname;

    String address;

    @JsonIgnore
    String phone;

    String avatar;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "role_id")
    Role role;

    @JsonIgnore
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

    @JsonIgnore
    @Column(name = "status")
    boolean status;

    @JsonIgnore
    @Column(name = "otp")
    String otp;

    @JsonIgnore
    @Column(name = "is_verified")
    boolean isVerified;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    List<CartItem> cartItems;

    @JsonIgnore
    @JsonManagedReference(value = "user_wishlist")
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    List<WishlistItem> wishlistItems;
}
