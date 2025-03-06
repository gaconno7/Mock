package com.mock.taka.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.mock.taka.service.UserService;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/")
    public String getHomePage() {
        return "admin/dashboard/show";
    }

    @GetMapping("/admin")
    public String getCreateUserPage() {
        System.out.println(">>>>>>>>>>>>>>>>" + userService.getCountUser());
        return "admin/dashboard/show";
    }

    @GetMapping("/signin")
    public String getSigninPage() {
        return "client/signin";
    }
    

}
