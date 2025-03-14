package com.mock.taka.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class LocationService {

    private static final String BASE_URL = "https://vn-public-apis.fpo.vn";

    private final RestTemplate restTemplate;

    public LocationService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // Lấy danh sách tỉnh/thành phố
    public Map<String, Object> getProvinces() {
        String url = BASE_URL + "/provinces/getAll?limit=-1";
        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        return response.getBody();
    }

    // Lấy danh sách quận/huyện theo mã tỉnh/thành phố
    public Map<String, Object> getDistricts(String provinceCode) {
        String url = BASE_URL + "/districts/getByProvince?provinceCode=" + provinceCode;
        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        return response.getBody();
    }

    // Lấy danh sách phường/xã theo mã quận/huyện
    public Map<String, Object> getWards(String districtCode) {
        String url = BASE_URL + "/wards/getByDistrict?districtCode=" + districtCode;
        ResponseEntity<Map> response = restTemplate.getForEntity(url, Map.class);
        return response.getBody();
    }
}
