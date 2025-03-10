package com.mock.taka.controller.api;


import com.mock.taka.dto.UserUpdateInformationRequest;
import com.mock.taka.dto.UserUpdatePasswordRequest;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserAPIController {

    @PutMapping("/information/{id}")
    public ResponseEntity<?> updateInformation(
            @PathVariable(name = "id") String id,
            @RequestBody UserUpdateInformationRequest request
            ) {

        return ResponseEntity.ok("");
    }

    @PutMapping("/password/{id}")
    public ResponseEntity<?> updatePassword(
            @PathVariable(name = "id") String id,
            @RequestBody UserUpdatePasswordRequest request
    ) {

        return ResponseEntity.ok("");
    }
}
