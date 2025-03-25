package com.mock.taka.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mock.taka.domain.Voucher;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, String> {
    public List<Voucher> findByStatus(boolean status);
    Optional<Voucher> findByIdAndStatus(String id, boolean status);
}
