package com.mock.taka.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.Message;

@Repository
public interface MessageRepository extends JpaRepository<Message, String> {
    
}
