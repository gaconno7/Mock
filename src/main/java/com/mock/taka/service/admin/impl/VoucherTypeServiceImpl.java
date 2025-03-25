package com.mock.taka.service.admin.impl;

import com.mock.taka.domain.VoucherType;
import com.mock.taka.repository.VoucherTypeRepository;
import com.mock.taka.service.admin.VoucherTypeService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class VoucherTypeServiceImpl implements VoucherTypeService {
    VoucherTypeRepository voucherTypeRepository;
    @Override
    public VoucherType save(String name) {
        return voucherTypeRepository.save(VoucherType.builder().name(name).status(true).build());
    }

    @Override
    public List<VoucherType> findAll() {
        return voucherTypeRepository.findAll();
    }

    @Override
    public VoucherType findById(String id) {
        return voucherTypeRepository.findById(id).orElse(null);
    }

    @Override
    public VoucherType update(String id, String name) {
        var voucherType = voucherTypeRepository.findById(id).orElse(null);
        assert voucherType != null;
        voucherType.setName(name);
        return voucherTypeRepository.save(voucherType);
    }
}
