package com.mock.taka.controller.api;

import com.mock.taka.domain.Evaluation;
import com.mock.taka.domain.User;
import com.mock.taka.service.client.EvaluationService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;


@RestController
@RequestMapping("/api/evaluations")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class EvaluationAPIController {

    EvaluationService evaluationService;

    @PostMapping
    public ResponseEntity<?> saveEvaluation(
            @RequestParam(name = "files", required = false) MultipartFile file,
            @RequestParam(name = "review-title") String title,
            @RequestParam(name = "review-content") String content,
            @RequestParam(name = "rate", defaultValue = "5") int rate,
            @RequestParam(name = "product-id") String productId

    ) throws IOException {
        Evaluation evaluation = evaluationService.save(file, title, rate, content, productId, User.builder().id(1L).build());
        return ResponseEntity.ok("Success");
    }

    @GetMapping
    public ResponseEntity<Page<Evaluation>> getEvaluations(@RequestParam(name = "page",defaultValue = "1") int pageNum,
                                                           @RequestParam(name = "size",defaultValue = "8") int pageSize,
                                                           @RequestParam(name = "productId",defaultValue = "8") String productId
                                                           ) {
        Page<Evaluation> evaluationPage = evaluationService.findAllByProductIdAndPageable(pageSize, pageNum, productId);
        return ResponseEntity.ok(evaluationPage);
    }
}