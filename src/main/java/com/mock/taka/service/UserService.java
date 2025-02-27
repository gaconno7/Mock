package com.mock.taka.service;

import org.springframework.stereotype.Service;

import com.mock.taka.repository.UserRepository;

@Service
public class UserService {
    private UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public long getCountUser() {
        return this.userRepository.count();
    }
}
