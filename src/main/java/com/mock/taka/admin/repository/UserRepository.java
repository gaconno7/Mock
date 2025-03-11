package com.mock.taka.admin.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findByRoleNameAndStatusTrue(String name);

    List<User> findByStatus(boolean status);

    boolean existsByEmail(String email);
}
