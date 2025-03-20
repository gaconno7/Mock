package com.mock.taka.service.client;

import com.mock.taka.domain.ReturnOrder;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface ReturnOrderService {
    ReturnOrder save(String title, String content, MultipartFile[] file, String orderId) throws IOException;
    ReturnOrder findByOrderId( String orderId);
}
