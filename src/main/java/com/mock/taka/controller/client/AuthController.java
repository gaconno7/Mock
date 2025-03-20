package com.mock.taka.controller.client;

import com.mock.taka.domain.User;
import com.mock.taka.dto.EmailDetail;
import com.mock.taka.service.client.SendEmailService;
import com.mock.taka.service.client.UserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AuthController {

    UserService userService;
    SendEmailService sendEmailService;

    @GetMapping("/login")
    public String showLoginPage() {
        return "auth/login";
    }


    @GetMapping("/register")
    public String showRegisterPage() {
        return "auth/register";
    }

    @GetMapping("/verified-email/{otp}")
    public String verifiedEmail(@PathVariable(name = "otp") String otp) {
        userService.verifiedEmailWithOTP(otp);
        return "redirect:/login";
    }

    @GetMapping("/reset-password/{otp}")
    public String showResetPassword(@PathVariable(name = "otp") String otp, RedirectAttributes attributes) {
        if(userService.existsByOtp(otp)) {
            return "auth/reset-password";
        } else {
            attributes.addFlashAttribute("message", "Mã cập nhật đã hết hạn. Vui lòng thử lại!");
            return "redirect:/confirm-email";
        }
    }

    @PostMapping("/reset-password")
    public String resetPassword(
            @RequestParam(name = "otp") String otp,
            @RequestParam(name = "password") String password,
            @RequestParam(name = "re-password") String rePassword,
            RedirectAttributes attributes) {
        var message = userService.resetPassword(otp, password, rePassword);
        attributes.addFlashAttribute("message", message);
        return "redirect:/reset-password/" + otp;
    }

    @GetMapping("/confirm-email")
    public String showConfirmEmail() {
        return "auth/confirm-email";
    }

    @PostMapping("/confirm-email")
    public String confirmEmail(@RequestParam(name = "email") String email, RedirectAttributes attributes) {
        String message = "";
        if(userService.existsByEmail(email)) {
            message = "Vui lòng kiểm tra email để xác nhận đổi mật khẩu!";
            sendEmailService.sendEmailResetPassword(email);
        } else {
            message = "Email không chính xác!";
        }
        attributes.addFlashAttribute("message", message);
        return "redirect:/confirm-email";
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
            userService.save(User.builder().email(email).fullname(fullName).password(password).isVerified(false).build());
            url = "redirect:/login";
        }
        return url;
    }
}
