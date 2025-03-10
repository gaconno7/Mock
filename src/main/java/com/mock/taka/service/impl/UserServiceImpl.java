package com.mock.taka.service.impl;

import com.mock.taka.domain.Role;
import com.mock.taka.domain.User;
import com.mock.taka.dto.UserUpdateInformationRequest;
import com.mock.taka.dto.UserUpdatePasswordRequest;
import com.mock.taka.repository.UserRepository;
import com.mock.taka.service.UserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserServiceImpl implements UserService {
    UserRepository userRepository;
    PasswordEncoder passwordEncoder;
    CloudinaryService cloudinaryService;

    @Override
    public long getCountUser() {
        return this.userRepository.count();
    }

    @Override
    public User save(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setStatus(true);
        user.setAvatar("https://icon-library.com/images/avatar-icon-png/avatar-icon-png-2.jpg");
        return userRepository.save(user);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public User updateInformation(long id, UserUpdateInformationRequest request) throws IOException {
        var user = userRepository.findById(id).orElse(null);
        String image = "";
        if(!request.getFile().isEmpty()){
            image = cloudinaryService.uploadFile(request.getFile(), "users");
        } else {
            assert user != null;
            image = user.getAvatar();
        }
        assert user != null;
        user.setPhone(request.getPhone());
        user.setFullname(request.getFullname());
        user.setAvatar(image);
        return null;
    }

    @Override
    public User updatePassword(long id, UserUpdatePasswordRequest request) {
        return null;
    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }
}
