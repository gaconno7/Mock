package com.mock.taka.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
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
@Table(name = "orders")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class Order implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    String id;


    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "user")
    User user;

    @JsonIgnore
    @OneToMany(mappedBy = "order", fetch = FetchType.EAGER)
    List<OrderDetail> orderDetails;

    @Column(name = "address")
    String address;

    @Column(name = "status")
    String status;

    @Column(name = "order_date")
    @CreatedDate
    Date orderDate;

    @Column(name = "update_date")
    @LastModifiedDate
    Date updateDate;


    @Column(name = "total_price")
    double totalPrice;

    @Column(name = "payment_method")
    String paymentMethod;

    @Column(name = "payment_ref")
    String paymentRef;


    @JsonIgnore
    @OneToOne(mappedBy = "order")
    ReturnOrder returnOrder;

}
