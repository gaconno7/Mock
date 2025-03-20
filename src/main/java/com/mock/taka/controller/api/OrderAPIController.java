package com.mock.taka.controller.api;


import com.mock.taka.service.client.OrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderAPIController {

    OrderService orderService;
    @PutMapping("/cancel/{id}")
    public ResponseEntity<Map<String, Object>> cancelOrder(@PathVariable(name = "id") String id) {
        boolean isCancelled = orderService.saveStatus(id, "da-huy") != null;

        Map<String, Object> response = new HashMap<>();
        response.put("message", isCancelled ? "Huỷ thành công" : "Lỗi huỷ!");
        response.put("status", isCancelled ? 200 : 400);

        return ResponseEntity.status(isCancelled ? HttpStatus.OK : HttpStatus.BAD_REQUEST).body(response);
    }

}
