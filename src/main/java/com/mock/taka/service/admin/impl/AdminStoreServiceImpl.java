package com.mock.taka.service.admin.impl;

import java.util.List;
import java.util.Optional;

import com.mock.taka.repository.StoreRepository;
import com.mock.taka.service.admin.AdminStoreService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.Store;
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminStoreServiceImpl implements AdminStoreService {
    StoreRepository storeRepository;

    public Store createStore(Store str) {
        return this.storeRepository.save(str);
    }


    public Optional<Store> fetchStoreById(String id) {
        return this.storeRepository.findById(id);
    }

    public void deleteStore(String id) {
        Optional<Store> storeOptional = storeRepository.findById(id);
        storeOptional.ifPresent(store -> {
            store.setDeleted(true);
            storeRepository.save(store);
        });
    }

    public List<Store> fetchStore() {
        return storeRepository.findByDeletedFalse();
    }
    
    public List<Store> fetchDeletedStores() {
        return storeRepository.findByDeletedTrue();
    }

    @Override
    public Store findByUserId(long userId) {
        return storeRepository.findByUserId(userId);
    }
}