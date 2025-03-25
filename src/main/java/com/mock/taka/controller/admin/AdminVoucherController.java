package com.mock.taka.controller.admin;

import com.mock.taka.domain.Category;
import com.mock.taka.domain.Product;
import com.mock.taka.domain.Voucher;
import com.mock.taka.service.admin.AdminProductService;
import com.mock.taka.service.admin.VoucherService;
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
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class AdminVoucherController {
    VoucherService voucherService;
    VoucherTypeService voucherTypeService;
    @GetMapping("/admin/voucher")
    public String getCategory(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "voucher");
        List<Voucher> vouchers = voucherService.findAllByStatus(true);
        model.addAttribute("vouchers", vouchers);
        return "admin/voucher/show";
    }

    @GetMapping("/admin/voucher/create")
    public String getCreateCategoryPage(Model model, HttpServletRequest active) {
        active.setAttribute("activePage", "voucher");
        model.addAttribute("newVoucher", new Voucher());
        model.addAttribute("voucherType", voucherTypeService.findAll());
        return "admin/voucher/create";
    }

    @PostMapping("/admin/voucher/create")
    public String handleCategoryStore(
            @ModelAttribute("newVoucher") Voucher voucher,
            @RequestParam("voucherTypeId") String voucherTypeId,
            BindingResult bindingResult,
            Model model) {
        if (bindingResult.hasErrors()) {
            return "admin/voucher/create";
        }

        // Lưu vào database
        voucherService.save(voucher, voucherTypeId);

        return "redirect:/admin/voucher";
    }

    @GetMapping("/admin/voucher/update/{id}")
    public String getUpdateCategoryPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "voucher");
        Voucher voucher = voucherService.findByIdStatus(id, true);
        model.addAttribute("newVoucher", voucher);
        return "admin/voucher/update";
    }

    @PostMapping("/admin/voucher/update")
    public String handleUpdateCategory(@ModelAttribute("newVoucher") @Valid Voucher voucher,
                                       @RequestParam("voucherTypeId") String voucherTypeId,
                                       BindingResult newCategoryBindingResult) {

        // validate
        if (newCategoryBindingResult.hasErrors()) {
            return "admin/voucher/update";
        }

        Voucher currentVoucher = voucherService.findByIdStatus(voucher.getId(), true);

        currentVoucher.setName(voucher.getName());
        currentVoucher.setDescription(voucher.getDescription());
        currentVoucher.setDiscount(voucher.getDiscount());
        currentVoucher.setEffectiveDate(voucher.getEffectiveDate());
        currentVoucher.setExpirationDate(voucher.getExpirationDate());


        voucherService.save(currentVoucher, voucherTypeId);


        return "redirect:/admin/voucher";
    }
    @GetMapping("/admin/voucher/delete/{id}")
    public String getDeleteCategoryPage(Model model, @PathVariable String id, HttpServletRequest active) {
        active.setAttribute("activePage", "category");
        voucherService.deleteById(id);
        return "redirect:/admin/voucher";
    }

}