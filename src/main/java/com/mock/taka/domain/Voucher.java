package com.mock.taka.domain;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "vouchers")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
public class Voucher implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    String id;

    @Column(name = "voucher_name")
    String name;

    @Column(name = "discount")
    double discount;

    @Column(name = "description")
    String description;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "expiration_date")
    Date expirationDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @Column(name = "effectvice_date")
    Date effectiveDate;

    @ManyToOne
    @JoinColumn(name = "voucher_type_id")
    VoucherType voucherType;

    @Column(name = "actor")
    String actor;

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
