package com.mock.taka.controller.api;


import com.mock.taka.service.client.OrderService;
import com.mock.taka.service.client.ReturnOrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class OrderAPIController {

    OrderService orderService;
    ReturnOrderService returnOrderService;

    @PutMapping("/cancel/{id}")
    public ResponseEntity<Map<String, Object>> cancelOrder(@PathVariable(name = "id") String id) {
        boolean isCancelled = orderService.saveStatus(id, "da-huy") != null;

        Map<String, Object> response = new HashMap<>();
        response.put("message", isCancelled ? "Huỷ thành công" : "Lỗi huỷ!");
        response.put("status", isCancelled ? 200 : 400);

        return ResponseEntity.status(isCancelled ? HttpStatus.OK : HttpStatus.BAD_REQUEST).body(response);
    }

    @PutMapping("/return-order/{id}")
    public ResponseEntity<Map<String, Object>> returnOrder(
            @PathVariable(name = "id") String orderId,
            @RequestParam(name = "title") String title,
            @RequestParam(name = "content") String content,
            @RequestParam(name = "files") MultipartFile[] file) throws IOException {

        boolean isCancelled = orderService.saveStatus(orderId, "tra-hang") != null;

        var returnOrder = returnOrderService.save(title, content, file, orderId);

        Map<String, Object> response = new HashMap<>();
        response.put("message", !Objects.isNull(returnOrder) ? "Trả hàng thành công" : "Lỗi trả hàng!");
        response.put("status", !Objects.isNull(returnOrder) ? 200 : 400);

        return ResponseEntity.status(isCancelled ? HttpStatus.OK : HttpStatus.BAD_REQUEST).body(response);
    }

}
