package com.mock.taka.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mock.taka.domain.Store;
import com.mock.taka.repository.StoreRepository;

import lombok.NoArgsConstructor;

@Service
public class StoreService {
    private final StoreRepository storeRepository;

    public StoreService(StoreRepository storeRepository) {
        this.storeRepository = storeRepository;
    }
    
    public Optional<Store> findStoreById(long id) {
        return this.storeRepository.findById(id);
    }
}
