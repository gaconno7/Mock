package com.mock.taka.service.client;

import com.mock.taka.dto.EmailDetail;

public interface SendEmailService {
    String sendSimpleMail(EmailDetail details);
    String sendEmailResetPassword(String email);
    String sendEmailWithSubjectAndContent(String email, String subject, String content);
}
