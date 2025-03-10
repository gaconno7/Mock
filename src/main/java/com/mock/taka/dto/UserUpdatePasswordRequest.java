package com.mock.taka.dto;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@FieldDefaults(level = AccessLevel.PRIVATE)
@Data
@Builder
public class UserUpdatePasswordRequest {
    String oldPassword;
    String newPassword;
    String reNewPassword;
}
