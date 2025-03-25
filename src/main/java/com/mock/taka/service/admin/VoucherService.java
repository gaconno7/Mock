package com.mock.taka.service.admin;

import com.mock.taka.domain.Voucher;

import java.util.List;

public interface VoucherService {
    List<Voucher> findAllByIdAndStatus(String id, boolean status);
    List<Voucher> findAllByStatus(boolean status);
    Voucher findByIdStatus(String id, boolean status);
    Voucher save (Voucher voucher, String id);
    Voucher update (String id, Voucher voucher);
    void deleteById (String id);

}
