package com.mock.taka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

// @SpringBootApplication

//đang chặn security
@SpringBootApplication
public class TakaApplication {

	public static void main(String[] args) {
		SpringApplication.run(TakaApplication.class, args);
	}


}
