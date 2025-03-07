package com.mock.taka.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mock.taka.domain.Store;

public interface StoreRepository extends JpaRepository<Store, String> {
    
}
