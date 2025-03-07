package com.mock.taka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// @SpringBootApplication

//đang chặn security
@SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class TakaApplication {

	public static void main(String[] args) {
		SpringApplication.run(TakaApplication.class, args);
	}

}
