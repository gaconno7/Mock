package com.mock.taka.service.client.impl;

import com.mock.taka.domain.ReturnOrder;
import com.mock.taka.repository.OrderRepository;
import com.mock.taka.repository.ReturnOrderRepository;
import com.mock.taka.service.client.ReturnOrderService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class ReturnOrderServiceImpl implements ReturnOrderService {
    CloudinaryService cloudinaryService;
    ReturnOrderRepository returnOrderRepository;
    OrderRepository orderRepository;
    @Override
    public ReturnOrder save(String title, String content, MultipartFile[] file, String orderId) throws IOException {
        List<String> images = cloudinaryService.uploadFiles(file, "return-order");
        var order = orderRepository.findById(orderId).orElse(null);
        ReturnOrder returnOrder = ReturnOrder.builder()
                                    .title(title)
                                    .firstImage(!images.isEmpty() ? images.getFirst() : null)
                                    .secondImage(images.size() >= 2 ? images.get(1) : null)
                                    .threeImage(images.size() >= 3 ? images.get(2) : null)
                                    .order(order)
                                    .content(content).build();
        return returnOrderRepository.save(returnOrder);
    }

    @Override
    public ReturnOrder findByOrderId(String orderId) {
        return returnOrderRepository.findByOrderId(orderId).orElse(null);
    }

}
