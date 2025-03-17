package com.mock.taka.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mock.taka.domain.Voucher;
import com.mock.taka.repository.VoucherRepository;

@Service
public class VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;

    public Double validateAndApplyCoupon(String couponCode, Double totalPrice) {
        Voucher voucher = voucherRepository.findById(couponCode).orElseThrow(() -> new RuntimeException("Không tìm thấy voucher!"));

        // Giả sử coupon có giá trị giảm theo % hoặc số tiền cụ thể
        // if (voucher.isPercentage()) {
        //     return totalPrice * (coupon.getDiscountValue() / 100);
        // } else {
        //     return Math.min(coupon.getDiscountValue(), totalPrice);
        // }

        return voucher.getDiscount();
    }
}
