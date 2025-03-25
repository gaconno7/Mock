package com.mock.taka.service.admin.impl;

import com.mock.taka.domain.Voucher;
import com.mock.taka.repository.VoucherRepository;
import com.mock.taka.repository.VoucherTypeRepository;
import com.mock.taka.service.admin.VoucherService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class VoucherServiceImpl implements VoucherService {
    VoucherRepository voucherRepository;
    VoucherTypeRepository voucherTypeRepository;

    @Override
    public List<Voucher> findAllByIdAndStatus(String id, boolean status) {
        return null;
    }

    @Override
    public Voucher findByIdStatus(String id, boolean status) {
        return voucherRepository.findByIdAndStatus(id, status).orElse(null);
    }

    @Override
    public List<Voucher> findAllByStatus(boolean status) {
        return voucherRepository.findByStatus(status);
    }

    @Override
    public Voucher save(Voucher voucher, String id) {
        var voucherType = voucherTypeRepository.findById(id).orElse(null);
        voucher.setStatus(true);
        voucher.setVoucherType(voucherType);
        return voucherRepository.save(voucher);
    }

    @Override
    public Voucher update(String id, Voucher voucher) {
        return null;
    }

    @Override
    public void deleteById(String id) {
        var voucher = voucherRepository.findById(id).orElse(null);
        assert voucher != null;
        voucher.setStatus(false);
        voucherRepository.save(voucher);
    }
}
