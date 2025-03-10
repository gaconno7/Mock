package com.mock.taka.controller;

import com.mock.taka.domain.User;
import com.mock.taka.service.UserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthController {

    UserService userService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "auth/login";
    }


    @GetMapping("/register")
    public String showRegisterPage() {
        return "auth/register";
    }


    @PostMapping("/register")
    public String register(
            @RequestParam(name = "full-name") String fullName,
            @RequestParam(name = "email") String email,
            @RequestParam(name = "password") String password,
            @RequestParam(name = "re-password") String rePassword,
            RedirectAttributes redirectAttributes
    ) {
        String url = "";
        if(!password.equals(rePassword)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Mật khẩu và mật khẩu nhập lại không trùng khớp");
            url = "redirect:/register";
        } else if (userService.existsByEmail(email)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Email đã tồn tại");
            url = "redirect:/register";
        } else {
            userService.save(User.builder().email(email).fullname(fullName).password(password).build());
            url = "redirect:/login";
        }
        return url;
    }
}
