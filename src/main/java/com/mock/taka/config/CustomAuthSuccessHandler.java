package com.mock.taka.config;

import com.mock.taka.domain.User;
import com.mock.taka.repository.UserRepository;
import com.mock.taka.service.UserService;
import com.mock.taka.service.impl.UserServiceImpl;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Set;

@Component
public class CustomAuthSuccessHandler implements AuthenticationSuccessHandler {

    private final UserService userService;

    public CustomAuthSuccessHandler(@Lazy UserServiceImpl userService) {
        this.userService = userService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException  {

        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
        CustomUser u = (CustomUser) authentication.getPrincipal();
        User user = userService.findByEmail(u.getUsername());

        HttpSession session = request.getSession(false);
        session.setAttribute("user", user);

        if (roles.contains("ADMIN")) {
            response.sendRedirect("/admin/");
        } else {
            response.sendRedirect("/home");
        }

    }

}