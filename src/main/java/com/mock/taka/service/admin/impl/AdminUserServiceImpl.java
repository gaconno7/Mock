package com.mock.taka.service.admin.impl;

import java.util.List;
import java.util.Optional;

import com.mock.taka.controller.admin.AdminCategoryController;
import com.mock.taka.repository.RoleRepository;
import com.mock.taka.repository.UserRepository;
import com.mock.taka.service.admin.AdminCategoryService;
import com.mock.taka.service.admin.AdminUserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import com.mock.taka.domain.Role;
import com.mock.taka.domain.User;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminUserServiceImpl implements AdminUserService {

    UserRepository userRepository;
    RoleRepository roleRepository;

    @Override
    public long getCountUser() {
        return userRepository.countUserByStatusIsTrue();
    }

    @Override
    public List<User> getAllUser() {
        return userRepository.findAll();
    }

    @Override
    public User getUserById(Long id) {
        return userRepository.getReferenceById(id);
    }

    @Override
    public Optional<User> findUserById(long id) {
        return userRepository.findUserById(id);
    }

    @Override
    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public void handleSaveUser(User user) {
        userRepository.save(user);
    }

    @Override
    public Role getRoleByName(String name) {
        return roleRepository.findByName(name);
    }

    @Override
    public List<User> getUserByRole(String name) {
        return userRepository.findByRoleNameAndStatusTrue(name);
    }

    @Override
    public List<User> getUserDeleted() {
        return userRepository.findByStatus(false);
    }

    @Override
    public boolean checkEmailExist(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public void updateUserRole(User user, String roleName) {
        Role role = roleRepository.findByName(roleName);
        if (role != null) {
            user.setRole(role);
            userRepository.save(user);
        }
    }

    @Override
    public Long countByRoleName(String name) {
        return userRepository.countByRoleNameAndStatusTrue(name);
    }

}
