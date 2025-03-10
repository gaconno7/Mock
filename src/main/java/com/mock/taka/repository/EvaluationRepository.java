package com.mock.taka.repository;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.User;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Repository
public interface EvaluationRepository extends JpaRepository<Evaluation, String> {
    List<Evaluation> findAllByProductId(String id);
    int countByRateAndProductId(double rate, String productId);
}
