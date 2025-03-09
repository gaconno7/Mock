package com.mock.taka.service.impl;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.User;
import com.mock.taka.repository.EvaluationRepository;
import com.mock.taka.repository.ProductRepository;
import com.mock.taka.service.EvaluationService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Objects;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class EvaluationServiceImpl implements EvaluationService {

    EvaluationRepository evaluationRepository;
    ProductRepository productRepository;
    CloudinaryService cloudinaryService;
    @Override
    public List<Evaluation> findAllByProductId(String id) {
        return evaluationRepository.findAllByProductId(id);
    }

    @Override
    public Evaluation save(MultipartFile file, String title, int rate, String review, String productId, User user) throws IOException {
        String image = "";
        if(!file.isEmpty()){
            image = cloudinaryService.uploadFile(file, "evaluations");
        }
        Product product = productRepository.findById(productId).orElse(null);
        Evaluation  evaluation = Evaluation.builder().title(title).review(review).image(Objects.isNull(image) ? null : image).status(true).rate(rate)
                .user(user).product(product).build();
        return evaluationRepository.save(evaluation);
    }

    @Override
    public int countByRate(int rate, String productId) {
        return evaluationRepository.countByRateAndProductId(rate, productId);
    }
}
