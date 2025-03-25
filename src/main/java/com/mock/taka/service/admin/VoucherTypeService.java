package com.mock.taka.service.admin;

import com.mock.taka.domain.VoucherType;

import java.util.List;

public interface VoucherTypeService {
    List<VoucherType> findAll();
    VoucherType findById(String id);
    VoucherType save(String name);
    VoucherType update(String id, String name);
}
