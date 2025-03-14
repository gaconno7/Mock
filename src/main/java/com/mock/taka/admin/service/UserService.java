package com.mock.taka.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import com.mock.taka.controller.CategoryController;
import com.mock.taka.domain.Role;
import com.mock.taka.domain.User;
import com.mock.taka.repository.RoleRepository;
import com.mock.taka.repository.UserRepository;

@Service
public class UserService {

    private final CategoryController categoryController;
    private UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, CategoryController categoryController) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.categoryController = categoryController;
    }

    public long getCountUser() {
        return this.userRepository.count();
    }

    public List<User> getAllUser() {
        return this.userRepository.findAll();
    }

    public User getUserById(Long id) {
        return this.userRepository.getReferenceById(id);
    }
    public Optional<User> findUserById(long id){
        return this.userRepository.findUserById(id);
    }

    public void deleteById(Long id) {
        this.userRepository.deleteById(id);
    }

    public void handleSaveUser(User user) {
        this.userRepository.save(user);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public List<User> getUserByRole(String name) {
        return this.userRepository.findByRoleNameAndStatusTrue(name);
    }

    public List<User> getUserDeleted(){
        return this.userRepository.findByStatus(false);
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }
    public void updateUserRole(User user, String roleName) {
        Role role = roleRepository.findByName(roleName);
        if (role != null) {
            user.setRole(role);
            userRepository.save(user);
        }
    }

}
