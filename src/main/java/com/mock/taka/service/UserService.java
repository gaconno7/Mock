package com.mock.taka.service;

import com.mock.taka.domain.User;
import org.springframework.stereotype.Service;

import com.mock.taka.repository.UserRepository;

public interface UserService {

    long getCountUser();
    boolean existsByEmail(String email);
    User save(User user);

    User findByEmail(String email);
}
