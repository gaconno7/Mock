package com.mock.taka.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mock.taka.domain.Role;
import com.mock.taka.domain.User;
import com.mock.taka.repository.RoleRepository;
import com.mock.taka.repository.UserRepository;

@Service
public class UserService {
    private UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public long getCountUser() {
        return this.userRepository.count();
    }

    public List<User> getAllUser() {
        return this.userRepository.findAll();
    }

    public User getUserById(long id) {
        return this.userRepository.getReferenceById(id);
    }

    public void deleteById(long id) {
        this.userRepository.deleteById(id);
    }

    public void handleSaveUser(User user) {
        this.userRepository.save(user);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public List<User> getUserByRole(long id) {
        return this.userRepository.findByRoleId(id);
    }

}
