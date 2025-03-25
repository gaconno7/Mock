package com.mock.taka.service.client.impl;
import com.mock.taka.domain.User;
import com.mock.taka.dto.UserUpdatePasswordRequest;
import com.mock.taka.repository.RoleRepository;
import com.mock.taka.repository.UserRepository;
import com.mock.taka.service.client.SendEmailService;
import com.mock.taka.service.client.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Objects;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserServiceImpl implements UserService {

    UserRepository userRepository;
    PasswordEncoder passwordEncoder;
    CloudinaryService cloudinaryService;
    RoleRepository roleRepository;
    SendEmailService sendEmailService;

    @Override
    public void verifiedEmailWithOTP(String otp) {
        var user = userRepository.findByOtpAndStatus(otp, true);
        if(!Objects.isNull(user)) {
            user.setVerified(true);
            userRepository.save(user);
        }
    }

    @Override
    public User save(User user) {
        var role = roleRepository.findByName("ROLE_USER");
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setStatus(true);
        user.setRole(role);
        user.setAvatar("https://icon-library.com/images/avatar-icon-png/avatar-icon-png-2.jpg");
        if(!user.isVerified()) {
            String otp = UUID.randomUUID().toString();
            sendEmailWithOTP(user.getEmail(), otp);
            user.setOtp(otp);
        }
        return userRepository.save(user);
    }

    @Override
    public User findById(long id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public User findByEmail(String email) {
        return userRepository.findByEmailAndStatus(email, true);
    }

    @Override
    public String updateInformation(long id, MultipartFile file, String fullname, String phone) throws IOException {
        var user = userRepository.findById(id).orElse(null);
        String image = "";
        if(!file.isEmpty()){
            image = cloudinaryService.uploadFile(file, "users");
        } else {
            assert user != null;
            image = user.getAvatar();
        }
        assert user != null;
        user.setPhone(phone);
        user.setFullname(fullname);
        user.setAvatar(image);
        userRepository.save(user);
        return "Cập nhật thành công";
    }

    @Override
    public User updateAddress(String province, String district, String ward, String street, long userId) {
        var user = userRepository.findById(userId).orElse(null);
        assert user != null;
        user.setAddress(street + ", " + ward + ", " + district + ", " + province);
        return userRepository.save(user);
    }

    @Override
    public String updatePassword(long id, UserUpdatePasswordRequest request) {
        return userRepository.findById(id).map(user -> {
            if (!request.getNewPassword().equals(request.getReNewPassword())) {
                return "Mật khẩu nhập lại và mật khẩu mới không trùng khớp";
            }
            if (!passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
                return "Mật khẩu cũ không đúng";
            }
            if (passwordEncoder.matches(request.getNewPassword(), user.getPassword())) {
                return "Mật khẩu nhập mới và mật khẩu cũ không được trùng nhau";
            }

            user.setPassword(passwordEncoder.encode(request.getNewPassword()));
            userRepository.save(user);
            return "Cập nhật thành công";
        }).orElse("Người dùng không tồn tại");
    }

    @Override
    public boolean existsByOtp(String otp) {
        return userRepository.existsByOtpAndStatus(otp, true);
    }

    @Override
    public String resetPassword(String otp,String password, String rePassword) {
        if(password.equals(rePassword)) {
            var user = userRepository.findByOtpAndStatus(otp, true);
            assert user != null;
            user.setPassword(passwordEncoder.encode(password));
            userRepository.save(user);
            return "Cập nhật thành công";
        }
        return "Mật khẩu nhập lại không trùng khớp!";
    }

    @Override
    public void processOAuthPostLogin(String email, String name, String image, HttpServletRequest request) {
        if(!userRepository.existsByEmailAndStatus(email, true)) {
            var role = roleRepository.findByName("ROLE_USER");
            userRepository.save(User.builder()
                    .email(email).role(role).status(true)
                    .fullname(name).avatar(image)
                    .password(passwordEncoder.encode(email))
                    .isVerified(true)
                    .build());
        }
        var user = userRepository.findByEmailAndStatus(email, true);
        HttpSession httpSession = request.getSession();
        httpSession.removeAttribute("user");
        httpSession.setAttribute("user", user);

    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmailAndStatus(email, true);
    }

    @Override
    public void sendEmailWithOTP(String email, String otp) {
        String content = String.format("<html>" +
                                                "<body>" +
                                                "<p>Vui lòng truy cập vào đường dẫn bên dưới để xác thực tài khoản:</p>" +
                                                "<br>" +
                                                "<a href='http://localhost:8088/verified-email/%s'>Xác thực</a>" +
                                                "</body>" +
                                                "</html>", otp);

        String subject = "Taka - Xác thực email đăng nhập";

        sendEmailService.sendEmailWithSubjectAndContent(email, subject, content);
    }
}
