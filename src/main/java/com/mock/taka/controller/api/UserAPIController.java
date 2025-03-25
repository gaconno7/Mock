package com.mock.taka.controller.api;


import com.mock.taka.dto.UserUpdatePasswordRequest;
import com.mock.taka.service.client.UserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class UserAPIController {

    UserService userService;
    @PutMapping("/information/{id}")
    public ResponseEntity<?> updateInformation(
            @PathVariable(name = "id") long id,
            @RequestParam("fullname") String fullname,
            @RequestParam("phone") String phone,
            @RequestParam(value = "file", required = false
            ) MultipartFile file) throws IOException {
        return ResponseEntity.ok(userService.updateInformation(id, file, fullname, phone));
    }
    @PutMapping("/password/{id}")
    public ResponseEntity<Map<String, String>> updatePassword(
            @PathVariable(name = "id") long id,
            @RequestBody UserUpdatePasswordRequest request
    ) {
        Map<String, String> res = new HashMap<>();
        res.put("message", userService.updatePassword(id,request));

        return ResponseEntity.ok(res);
    }

}
