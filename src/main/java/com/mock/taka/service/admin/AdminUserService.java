package com.mock.taka.service.admin;

import com.mock.taka.domain.Role;
import com.mock.taka.domain.User;

import java.util.List;
import java.util.Optional;

public interface AdminUserService {
    long getCountUser();
    List<User> getAllUser();
    User getUserById(Long id);
    Optional<User> findUserById(long id);
    void deleteById(Long id);
    void handleSaveUser(User user);
    Role getRoleByName(String name);
    List<User> getUserByRole(String name);
    List<User> getUserDeleted();
    boolean checkEmailExist(String email);
    void updateUserRole(User user, String roleName);
    Long countByRoleName(String name);
}
