package com.mock.taka.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mock.taka.service.LocationService;

@RestController
@RequestMapping("/api/vn")
public class LocationController {

    private final LocationService locationService;

    public LocationController(LocationService locationService) {
        this.locationService = locationService;
    }

    // Lấy danh sách tỉnh/thành phố
    @GetMapping("/provinces")
    public Map<String, Object> getProvinces() {
        return locationService.getProvinces();
    }

    // Lấy danh sách quận/huyện theo tỉnh/thành phố
    @GetMapping("/districts")
    public Map<String, Object> getDistricts(@RequestParam String provinceCode) {
        return locationService.getDistricts(provinceCode);
    }

    // Lấy danh sách phường/xã theo quận/huyện
    @GetMapping("/wards")
    public Map<String, Object> getWards(@RequestParam String districtCode) {
        return locationService.getWards(districtCode);
    }
}