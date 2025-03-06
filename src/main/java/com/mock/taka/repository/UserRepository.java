package com.mock.taka.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    List<User> findByRoleId(Long id);

}
