package com.mock.taka.controller.api;


import com.mock.taka.domain.Order;
import com.mock.taka.domain.Product;
import com.mock.taka.service.client.OrderService;
import com.mock.taka.service.client.ReturnOrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

    @GetMapping("/all")
    public ResponseEntity<Page<Order>> getOrders(
            @RequestParam(name = "page",defaultValue = "1") int pageNum,
            @RequestParam(name = "size",defaultValue = "8") int pageSize,
            @RequestParam(required = false) String date,
            @RequestParam(required = false) String status,
            @RequestParam(required = false) String searchValue,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String storeId,
            @RequestParam(required = false) String userId
            ) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-dd-MM");
        Page<Order> orders = orderService
                .filterOrderWithStatus(pageSize, pageNum + 1, status,
                        date == null ? null : sdf.parse(date),
                        searchValue, searchType, storeId, userId);
        return ResponseEntity.ok(orders);
    }

    @PutMapping("/process/{id}")
    public ResponseEntity<Map<String, Object>> processOrder(
            @PathVariable(name = "id") String orderId) {

        var order = orderService.saveStatus(orderId, "van-chuyen");

        Map<String, Object> response = new HashMap<>();

        response.put("message", !Objects.isNull(order) ? "Trả hàng thành công" : "Lỗi trả hàng!");
        response.put("status", !Objects.isNull(order) ? 200 : 400);

        return ResponseEntity.ok().body(response);
    }
}
