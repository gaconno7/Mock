package com.mock.taka.service;

import com.mock.taka.domain.User;
import com.mock.taka.dto.UserUpdateInformationRequest;
import com.mock.taka.dto.UserUpdatePasswordRequest;
import org.springframework.stereotype.Service;

import com.mock.taka.repository.UserRepository;

import java.io.IOException;

public interface UserService {

    long getCountUser();
    boolean existsByEmail(String email);
    User save(User user);
    User findByEmail(String email);
    User updateInformation(long id, UserUpdateInformationRequest request) throws IOException;
    User updatePassword(long id, UserUpdatePasswordRequest request);
}
