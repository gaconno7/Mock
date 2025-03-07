package com.mock.taka.service;

import com.mock.taka.domain.Evaluation;

import java.util.List;

public interface EvaluationService {
    List<Evaluation> findAllByProductId(String id);
    Evaluation save(Evaluation evaluation);
}
