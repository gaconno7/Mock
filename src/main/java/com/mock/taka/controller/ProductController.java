package com.mock.taka.controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.mock.taka.service.CategoryService;
import com.mock.taka.service.UserService;
import com.mock.taka.service.impl.CloudinaryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
@RequestMapping("/product")
public class ProductController {

//    CloudinaryService cloudinaryGifService;
    CategoryService categoryService;
    Cloudinary cloudinaryConfig;

    @GetMapping("/{id}")
    public String getDetail(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryService.findAll());
        return "/client/index";
    }
    @PostMapping("/gifs")
    public ResponseEntity< String > uploadGif(@RequestParam("gifFile")
                                                                   MultipartFile gifFile ) throws IOException {
        // User currentUser =
// userService.findUserByEmail(authentication.getName()); // Authorization
        String url = uploadFile(gifFile);


        // LinkedHashMap<String, Object> jsonResponse = cloudinaryGifService.modifyJsonResponse("create", URL);
        return new ResponseEntity<>(url, HttpStatus.CREATED);
    }


//    @PostMapping
//    public ResponseEntity<Map> uploadImage(@RequestParam("image")MultipartFile file){
//        Map data = this.cloudinaryGifService.upload(file);
//        return new ResponseEntity<>(data, HttpStatus.OK);
//    }

    public String uploadFile(MultipartFile gif) {
        try {
            File uploadedFile = convertMultiPartToFile(gif);
            Map uploadResult = cloudinaryConfig.uploader().upload(uploadedFile, ObjectUtils.emptyMap());
            boolean isDeleted = uploadedFile.delete();

            if (isDeleted){
                System.out.println("File successfully deleted");
            }else
                System.out.println("File doesn't exist");
            return  uploadResult.get("url").toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private File convertMultiPartToFile(MultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        FileOutputStream fos = new FileOutputStream(convFile);
        fos.write(file.getBytes());
        fos.close();
        return convFile;
    }

}
