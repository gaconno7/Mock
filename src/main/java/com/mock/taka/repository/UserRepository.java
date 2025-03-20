package com.mock.taka.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmailAndStatus(String email, boolean status);
    boolean existsByEmailAndStatus(String email, boolean status);
    boolean existsByOtpAndStatus(String otp, boolean status);
    User findByIdAndStatus(long id, boolean status);
    User findByOtpAndStatus(String otp, boolean status);
    Optional<User> findByEmail(String email);

    List<User> findByRoleNameAndStatusTrue(String name);

    List<User> findByStatus(boolean status);

    Optional<User> findUserById(long id);

    boolean existsByEmail(String email);

    Long countByRoleNameAndStatusTrue(String name);

    Long countUserByStatusIsTrue();
}
