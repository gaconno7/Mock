package com.mock.taka.controller.admin;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.VoucherType;
import com.mock.taka.service.admin.AdminProductService;
import com.mock.taka.service.admin.VoucherTypeService;
import com.mock.taka.service.client.CategoryService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminVoucherTypeController {
    VoucherTypeService voucherTypeService;

    @GetMapping("/admin/voucher-type")
    public String getCategory(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "voucher-type");
        List<VoucherType> vct = voucherTypeService.findAll();
        model.addAttribute("voucherTypes", vct);
        return "admin/voucher-type/show";
    }

    @GetMapping("/admin/voucher-type/create")
    public String getCreateCategoryPage(Model model, HttpServletRequest active) {
        model.addAttribute("newVoucher", new VoucherType());
        active.setAttribute("activePage", "voucher-type");
        return "admin/voucher-type/create";
    }

    @PostMapping("/admin/voucher-type/create")
    public String handleCategoryStore(
            @ModelAttribute("newVoucher") @Valid VoucherType voucherType,
            BindingResult newCategoryBindingResult) {
        if (newCategoryBindingResult.hasErrors()) {
            return "admin/voucher-type/create";
        }

        this.voucherTypeService.save(voucherType.getName());

        return "redirect:/admin/voucher-type";
    }
    @GetMapping("/admin/voucher-type/update/{id}")
    public String getUpdateCategoryPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "voucher-type");
        VoucherType voucherType = voucherTypeService.findById(id);
        model.addAttribute("newVoucher",voucherType);
        return "admin/voucher-type/update";
    }

    @PostMapping("/admin/voucher-type/update")
    public String handleUpdateCategory(@ModelAttribute("newVoucher") @Valid VoucherType v,
                                       BindingResult newCategoryBindingResult) {

        // validate
        if (newCategoryBindingResult.hasErrors()) {
            return "admin/voucher-type/update";
        }

        this.voucherTypeService.update(v.getId(), v.getName());


        return "redirect:/admin/voucher-type";
    }


}