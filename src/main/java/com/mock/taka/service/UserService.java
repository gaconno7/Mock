package com.mock.taka.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mock.taka.domain.User;
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

    public Optional<User> getUser(long id) {
        return this.userRepository.findById(id);
    }
}
