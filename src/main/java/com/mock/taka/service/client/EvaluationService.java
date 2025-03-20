package com.mock.taka.service.client;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface EvaluationService {
    List<Evaluation> findAllByProductId(String id);
    Evaluation save(MultipartFile file, String title, int rate, String review, String productId, User user) throws IOException;
    int countByRate(int rate, String productId);
    Page<Evaluation> findAllByProductIdAndPageable(int pageSize, int pageNum, String productId, int rate);
}
