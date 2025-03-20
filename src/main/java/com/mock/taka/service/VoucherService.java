package com.mock.taka.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.Voucher;
import com.mock.taka.repository.VoucherRepository;

@Service
public class VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;

    public Double validateAndApplyVoucher(String voucherId, Double totalPrice) {
        Voucher voucher = voucherRepository.findById(voucherId).orElseThrow(() -> new RuntimeException("Không tìm thấy voucher!"));

        // Giả sử voucher có giá trị giảm theo % hoặc số tiền cụ thể
        // if (voucher.isPercentage()) {
        //     return totalPrice * (voucher.getDiscountValue() / 100);
        // } else {
        //     return Math.min(voucher.getDiscountValue(), totalPrice);
        // }

        return voucher.getDiscount();
    }

    public List<Voucher> getAllVouchers() {
        return voucherRepository.findAll();
    }
}
