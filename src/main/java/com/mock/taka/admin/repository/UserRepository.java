package com.mock.taka.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findByRoleNameAndStatusTrue(String name);

    List<User> findByStatus(boolean status);
    Optional<User> findUserById(long id);

    boolean existsByEmail(String email);
}
