package com.mock.taka.admin.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.mock.taka.domain.User;
import com.mock.taka.admin.repository.StoreRepository;
import com.mock.taka.admin.service.StoreService;
import com.mock.taka.admin.service.UserService;
import com.mock.taka.admin.service.impl.CloudinaryService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class UserController {

    private final UserService userService;
    private final CloudinaryService cloudinaryService;
    private final StoreService storeService;

    public UserController(UserService userService, CloudinaryService cloudinaryService, StoreService storeService) {
        this.userService = userService;
        this.cloudinaryService = cloudinaryService;
        this.storeService = storeService;
    }

    @GetMapping("/admin")
    public String getHomePage(HttpServletRequest active) {
        active.setAttribute("activePage", "admin");
        return "admin/dashboard/show";
    }

    @GetMapping("/admin/user")
    public String getUserPage(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        Long count = this.userService.getCountUser();

        List<User> listAdmins = this.userService.getUserByRole("ROLE_ADMIN");
        int countListAdmins = (listAdmins != null) ? listAdmins.size() : 0;
        model.addAttribute("countListAdmins", countListAdmins);
        model.addAttribute("listAdmins", listAdmins);

        List<User> listSuppliers = this.userService.getUserByRole("ROLE_SUPPLIER");
        int countListSuppliers = (listAdmins != null) ? listSuppliers.size() : 0;
        model.addAttribute("countlistSuppliers", countListSuppliers);

        List<User> listUsers = this.userService.getUserByRole("ROLE_USER");
        int countListUsers = (listAdmins != null) ? listUsers.size() : 0;
        model.addAttribute("countListUsers", countListUsers);

        return "admin/user/show";
    }

    @GetMapping("/admin/user/list/{id}")
    public String getListPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        List<User> users = this.userService.getUserByRole(id);
        // String storeId = this.storeService.getStoreByIdUser(users.get(0));

        model.addAttribute("users", users);

        return "admin/user/list";
    }
 

    @GetMapping("/admin/user/{id}")
    public String getDetailUserPage(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User user = this.userService.getUserById(id);
        model.addAttribute("detailUser", user);
        return "admin/user/detail";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUserPage(Model model, @ModelAttribute("deleteUser") User user) {
        Long idUser = user.getId();
        User delUser = this.userService.getUserById(idUser);
        delUser.setStatus(false);
        this.userService.handleSaveUser(delUser);
        // this.userService.deleteById(user.getId());
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/perdelete/{id}")
    public String getPermanentDeleteUserPage(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User user = this.userService.getUserById(id);
        model.addAttribute("deleteUser", user);
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/perdelete")
    public String postPermanentDeleteUserPage(Model model, @ModelAttribute("deleteUser") User user) {
        this.userService.deleteById(user.getId());
        return "redirect:/admin/user/trash";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model, @ModelAttribute("newUser") User user, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        return "admin/user/create";
    }

    @PostMapping("/admin/user/create")
    public String postCreateUserPage(Model model, @ModelAttribute("newUser") @Valid User user,
            BindingResult newUserBindingResult,
            @RequestParam("imageFile") MultipartFile file) throws IOException {

        // validate
        if (newUserBindingResult.hasErrors()) {
            return "/admin/user/create";
        }
        if (!file.isEmpty()) {
            user.setAvatar(cloudinaryService.uploadFile(file, "categories"));
        }

        user.setStatus(true);
        user.setRole(this.userService.getRoleByName(user.getRole().getName()));
        this.userService.handleSaveUser(user);

        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("currentUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUserPage(Model model, @ModelAttribute("currentUser") @Valid User user,
            BindingResult newUserBindingResult) {
        // validate
        if (newUserBindingResult.hasErrors()) {
            System.out.println(">>>>>>>>>>>>DDANg bug");
            return "/admin/user/update";
        }
        User currentUser = this.userService.getUserById(user.getId());
        if (currentUser != null) {
            currentUser.setEmail(user.getEmail());
            currentUser.setAddress(user.getAddress());
            currentUser.setFullname(user.getFullname());
            currentUser.setPhone(user.getPhone());
            currentUser.setRole(this.userService.getRoleByName(user.getRole().getName()));
            this.userService.handleSaveUser(currentUser);
        }

        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/trash")
    public String getTrashPage(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        List<User> deletedUsers = this.userService.getUserDeleted();
        model.addAttribute("deletedUsers", deletedUsers);
        return "admin/user/trash";
    }

    @GetMapping("/admin/user/restore/{id}")
    public String getRestoreUser(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User user = this.userService.getUserById(id);
        model.addAttribute("restoreUser", user);
        return "admin/user/restore";
    }

    @PostMapping("/admin/user/restore")
    public String postRestoreUser(Model model, @ModelAttribute("restoreUser") User user) {
        User restoreUser = this.userService.getUserById(user.getId());
        restoreUser.setStatus(true);
        this.userService.handleSaveUser(restoreUser);
        return "redirect:/admin/user/trash";
    }

}
