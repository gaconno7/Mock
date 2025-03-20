package com.mock.taka.config;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import java.io.IOException;

@Slf4j
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {
        String errorMessage = "";
        if (exception.getMessage().contains("lock")) {
            errorMessage = "Tài khoản đã bị vô hiệu hoá";
        } else if (exception.getMessage().contains("not verified")) {
            errorMessage = "Vui lòng xác thực email để truy cập";
        } else {
            errorMessage = "Tên đăng nhập hoặc mật khẩu không đúng";
        }

        request.getSession().setAttribute("errorMessage", errorMessage);
        response.sendRedirect("/login?error=true");
    }
}