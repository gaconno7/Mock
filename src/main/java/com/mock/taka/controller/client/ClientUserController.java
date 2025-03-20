package com.mock.taka.controller.client;

import com.mock.taka.domain.User;
import com.mock.taka.service.client.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Objects;

@Controller
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@RequestMapping("/user")
public class ClientUserController {

    UserService userService;

    @GetMapping("/profile")
    public String showProfileView(HttpSession session) {
        var user = (User) userService.findById(((User) session.getAttribute("user")).getId());
        session.removeAttribute("user");
        session.setAttribute("user", user);
        return "client/profile";
    }
    @GetMapping("/update-password")
    public String showPasswordUpdateView() {
        return "client/update-password";
    }

    @GetMapping("/update-address")
    public String showAddressUpdateView() {
        return "client/update-address";
    }

    @PostMapping("/update-address")
    public String updateAddress(@RequestParam(name = "province") String province,
                                @RequestParam(name = "district") String district,
                                @RequestParam(name = "ward") String ward,
                                @RequestParam(name = "street") String street,
                                HttpSession session,
                                RedirectAttributes attributes) {
        var user = userService.updateAddress(province, district, ward, street, ((User) session.getAttribute("user")).getId());
        if(!Objects.isNull(user)) {
            attributes.addFlashAttribute("messageSuccess", "Cập nhật thành công!");
        } else {
            attributes.addFlashAttribute("messageError", "Lỗi cập nhật!");
        }
        session.removeAttribute("user");
        session.setAttribute("user", user);
        return "redirect:/user/update-address";
    }

}
