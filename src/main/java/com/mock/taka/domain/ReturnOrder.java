package com.mock.taka.domain;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "return-orders")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@EntityListeners(AuditingEntityListener.class)
public class ReturnOrder implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    String id;
    String title;
    String content;
    String firstImage;
    String secondImage;
    String threeImage;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    Order order;
}
