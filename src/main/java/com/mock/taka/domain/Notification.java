package com.mock.taka.domain;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Entity
@Table(name = "notification")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor
@NoArgsConstructor
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    String id;

    @Column(name = "sender_id")
    String senderId;

    @Column(name = "recipient_id")
    String recipientId;

    @Column(name = "content")
    String content;

    @Column(name = "time")
    Date time;
}
