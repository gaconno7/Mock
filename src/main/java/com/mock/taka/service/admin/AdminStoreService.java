package com.mock.taka.service.admin;

import com.mock.taka.domain.Store;

import java.util.List;
import java.util.Optional;

public interface AdminStoreService {
    Store createStore(Store str);
    Optional<Store> fetchStoreById(String id);
    void deleteStore(String id);
    List<Store> fetchStore();
    List<Store> fetchDeletedStores();
}
