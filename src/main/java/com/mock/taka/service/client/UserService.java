package com.mock.taka.service.client;

import com.mock.taka.domain.User;
import com.mock.taka.dto.UserUpdatePasswordRequest;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface UserService {
    boolean existsByEmail(String email);
    User save(User user);
    User findByEmail(String email);
    User findById(long id);
    String updateInformation(long id, MultipartFile file, String fullname, String phone) throws IOException;
    User updateAddress(String province, String district,String ward, String street, long userId);
    String updatePassword(long id, UserUpdatePasswordRequest request);
    boolean existsByOtp(String otp);
    void processOAuthPostLogin(String username, String name, String image, HttpServletRequest request);
    String resetPassword(String otp, String password, String rePassword);
    void sendEmailWithOTP(String email, String otp);
    void verifiedEmailWithOTP(String otp);
}
