package com.mock.taka.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mock.taka.domain.Store;
import com.mock.taka.repository.StoreRepository;
@Service
public class StoreService {
    private final StoreRepository storeRepository;

    public StoreService(StoreRepository storeRepository) {
        this.storeRepository = storeRepository;
    }
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

    // Thêm phương thức lấy cửa hàng chưa bị xóa
    public List<Store> fetchStore() {
        return storeRepository.findByDeletedFalse();
    }
}
