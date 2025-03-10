package com.mock.taka.dto;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;
import org.springframework.web.multipart.MultipartFile;

@FieldDefaults(level = AccessLevel.PRIVATE)
@Data
@Builder
public class UserUpdateInformationRequest {
    String fullname;
    String phone;
    MultipartFile file;
}
