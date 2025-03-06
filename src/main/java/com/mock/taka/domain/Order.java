package com.mock.taka.domain;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    String id;

    @ManyToOne
    @JoinColumn(name = "user")
    User user;

    @OneToMany(mappedBy = "order")
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

    @ManyToOne
    @JoinColumn(name = "transport_id")
    Transport transport;
}
