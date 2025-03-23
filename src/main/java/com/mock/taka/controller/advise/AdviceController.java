package com.mock.taka.controller.advise;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@Slf4j
@ControllerAdvice
public class AdviceController {
    @ExceptionHandler(Exception.class)
    public void handleAllExceptions(Exception ex) {
        log.error("Lỗi ứng dụng: {}", ex.getMessage());
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleNotFound() {
        return "error/error";
    }

}
