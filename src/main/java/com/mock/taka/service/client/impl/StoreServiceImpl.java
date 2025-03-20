package com.mock.taka.service.client.impl;

import java.util.List;
import java.util.Optional;

import com.mock.taka.repository.StoreRepository;
import com.mock.taka.service.client.StoreService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.Store;
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class StoreServiceImpl implements StoreService {
    StoreRepository storeRepository;

    @Override
    public Store createStore(Store str) {
        return this.storeRepository.save(str);
    }
    @Override
    public Optional<Store> fetchStoreById(String id) {
        return this.storeRepository.findById(id);
    }
    @Override
    public void deleteStore(String id) {
        Optional<Store> storeOptional = storeRepository.findById(id);
        storeOptional.ifPresent(store -> {
            store.setDeleted(true);
            storeRepository.save(store);
        });
    }
    @Override
    public List<Store> fetchStore() {
        return storeRepository.findByDeletedFalse();
    }
    @Override
    public List<Store> fetchDeletedStores() {
        return storeRepository.findByDeletedTrue();
    }
}