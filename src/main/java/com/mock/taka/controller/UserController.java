package com.mock.taka.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import com.mock.taka.domain.User;
import com.mock.taka.service.UserService;

@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/admin")
    public String getHomePage() {
        return "admin/dashboard/show";
    }

    @GetMapping("/admin/user")
    public String getUserPage(Model model) {
        Long count = this.userService.getCountUser();

        List<User> listAdmins = this.userService.getUserByRole(1);
        int countListAdmins = (listAdmins != null) ? listAdmins.size() : 0;
        model.addAttribute("countListAdmins", countListAdmins);
        model.addAttribute("listAdmins", listAdmins);

        List<User> listSuppliers = this.userService.getUserByRole(3);
        int countListSuppliers = (listAdmins != null) ? listSuppliers.size() : 0;
        model.addAttribute("countlistSuppliers", countListSuppliers);

        List<User> listUsers = this.userService.getUserByRole(2);
        int countListUsers = (listAdmins != null) ? listUsers.size() : 0;
        model.addAttribute("countListUsers", countListUsers);

        return "admin/user/show";
    }

    @GetMapping("/admin/user/list/{id}")
    public String getListPage(Model model, @PathVariable long id) {
        List<User> users = this.userService.getUserByRole(id);
        model.addAttribute("users", users);
        return "admin/user/list";
    }

    @GetMapping("/admin/user/{id}")
    public String getDetailUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("detailUser", user);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("deleteUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUserPage(Model model, @ModelAttribute("deleteUser") User user) {
        this.userService.deleteById(user.getId());
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model, @ModelAttribute("newUser") User user) {
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String postCreateUserPage(Model model, @ModelAttribute("newUser") User user) {

        user.setRole(this.userService.getRoleByName(user.getRole().getName()));
        this.userService.handleSaveUser(user);

        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("currentUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUserPage(Model model, @ModelAttribute("currentUser") User user) {
        User currentUser = this.userService.getUserById(user.getId());
        if (currentUser != null) {
            currentUser.setAddress(user.getAddress());
            currentUser.setFullname(user.getFullname());
            currentUser.setPhone(user.getPhone());
            currentUser.setRole(this.userService.getRoleByName(user.getRole().getName()));
            this.userService.handleSaveUser(currentUser);
        }

        return "redirect:/admin/user";
    }

}
