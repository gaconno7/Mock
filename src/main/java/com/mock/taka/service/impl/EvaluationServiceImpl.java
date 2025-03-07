package com.mock.taka.service.impl;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.repository.EvaluationRepository;
import com.mock.taka.service.EvaluationService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class EvaluationServiceImpl implements EvaluationService {

    EvaluationRepository evaluationRepository;
    @Override
    public List<Evaluation> findAllByProductId(String id) {
        return evaluationRepository.findAllByProductId(id);
    }

    @Override
    public Evaluation save(Evaluation evaluation) {
        return evaluationRepository.save(evaluation);
    }
}
