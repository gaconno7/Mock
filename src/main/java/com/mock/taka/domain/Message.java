package com.mock.taka.domain;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "messages")
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Message implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "id")
    String id;

    @Column(name = "sender_id")
    String senderId;

    @Column(name = "recipient_id")
    String recipientId;

    @Column(name = "chanel")
    String chanel;

    @Column(name = "content")
    String content;

    @Column(name = "time")
    Date time;
}
