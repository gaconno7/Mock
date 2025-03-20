package com.mock.taka.controller.admin;

import com.mock.taka.domain.Role; 
import com.mock.taka.domain.Store;
import com.mock.taka.domain.User;
import com.mock.taka.service.admin.AdminStoreService;
import com.mock.taka.service.admin.AdminUserService;
import com.mock.taka.service.client.impl.CloudinaryService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminUserController {

    PasswordEncoder passwordEncoder;
    AdminUserService userService;
    CloudinaryService cloudinaryService;
    AdminStoreService storeService;

    @GetMapping("/admin/user")
    public String getUserPage(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        Long count = userService.getCountUser();

        List<User> listAdmins = userService.getUserByRole("ROLE_ADMIN");
        int countListAdmins = (listAdmins != null) ? listAdmins.size() : 0;
        model.addAttribute("countListAdmins", countListAdmins);
        model.addAttribute("listAdmins", listAdmins);

        List<User> listSuppliers = userService.getUserByRole("ROLE_SUPPLIER");
        int countListSuppliers = (listAdmins != null) ? listSuppliers.size() : 0;
        model.addAttribute("countlistSuppliers", countListSuppliers);

        List<User> listUsers = userService.getUserByRole("ROLE_USER");
        int countListUsers = (listAdmins != null) ? listUsers.size() : 0;
        model.addAttribute("countListUsers", countListUsers);

        return "admin/user/show";
    }

    @GetMapping("/admin/user/list/{id}")
    public String getListPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        List<User> users = userService.getUserByRole(id);
        // String storeId = storeService.getStoreByIdUser(users.get(0));

        model.addAttribute("users", users);

        return "admin/user/list";
    }

    @GetMapping("/admin/user/{id}")
    public String getDetailUserPage(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User user = userService.getUserById(id);
        model.addAttribute("detailUser", user);
        return "admin/user/detail";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUserPage(Model model, @ModelAttribute("deleteUser") User user) {
        Long idUser = user.getId();
        User delUser = userService.getUserById(idUser);
        if (delUser.getStore() != null) {
            Store userStore = delUser.getStore();
            userStore.setDeleted(true);
            storeService.createStore(userStore);
        }
        delUser.setStatus(false);
        userService.handleSaveUser(delUser);
        // userService.deleteById(user.getId());
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/perdelete/{id}")
    public String getPermanentDeleteUserPage(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User user = userService.getUserById(id);
        model.addAttribute("deleteUser", user);
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/perdelete")
    public String postPermanentDeleteUserPage(Model model, @ModelAttribute("deleteUser") User user) {
        userService.deleteById(user.getId());
        return "redirect:/admin/user/trash";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model, @ModelAttribute("newUser") User user, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        return "admin/user/create";
    }

    // Thêm phương thức mới để tạo người dùng với role được chọn sẵn
    @GetMapping("/admin/user/create/{roleId}")
    public String getCreateUserByRole(@PathVariable String roleId, Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "user");

        // Lấy role theo tên
        Role selectedRole = userService.getRoleByName(roleId);
        if (selectedRole != null) {
            User newUser = new User();
            newUser.setRole(selectedRole);
            model.addAttribute("newUser", newUser);
            return "admin/user/create";
        } else {
            return "redirect:/admin/user";
        }
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
        user.setVerified(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(userService.getRoleByName(user.getRole().getName()));
        userService.handleSaveUser(user);

        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User currentUser = userService.getUserById(id);
        model.addAttribute("currentUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUserPage(Model model, @ModelAttribute("currentUser") @Valid User user,
                                     BindingResult newUserBindingResult) {
        // validate
        if (newUserBindingResult.hasErrors()) {
            System.out.println(">>>>>>>>>>>>DDANg bug");
            return "admin/user/update";
        }
        User currentUser = userService.getUserById(user.getId());
        if (currentUser != null) {
            currentUser.setEmail(user.getEmail());
            currentUser.setAddress(user.getAddress());
            currentUser.setFullname(user.getFullname());
            currentUser.setPhone(user.getPhone());
            currentUser.setRole(userService.getRoleByName(user.getRole().getName()));
            userService.handleSaveUser(currentUser);
        }

        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/trash")
    public String getTrashPage(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        List<User> deletedUsers = userService.getUserDeleted();
        model.addAttribute("deletedUsers", deletedUsers);
        return "admin/user/trash";
    }

    @GetMapping("/admin/user/restore/{id}")
    public String getRestoreUser(Model model, @PathVariable Long id, HttpServletRequest active) {
        active.setAttribute("activePage", "user");
        User user = userService.getUserById(id);
        model.addAttribute("restoreUser", user);
        return "admin/user/restore";
    }

    @PostMapping("/admin/user/restore")
    public String postRestoreUser(Model model, @ModelAttribute("restoreUser") User user) {
        User restoreUser = userService.getUserById(user.getId());
        if (restoreUser.getStore() != null) {
            Store userStore = restoreUser.getStore();
            userStore.setDeleted(false);
            storeService.createStore(userStore);
        }
        restoreUser.setStatus(true);
        userService.handleSaveUser(restoreUser);
        return "redirect:/admin/user/trash";
    }

}
