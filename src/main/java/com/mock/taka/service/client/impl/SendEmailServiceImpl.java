package com.mock.taka.service.client.impl;

import com.mock.taka.dto.EmailDetail;
import com.mock.taka.repository.UserRepository;
import com.mock.taka.service.client.SendEmailService;
import jakarta.mail.internet.MimeMessage;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class SendEmailServiceImpl implements SendEmailService {
    JavaMailSender javaMailSender;
    UserRepository userRepository;

    @Value("${spring.mail.username}")
    @NonFinal
    String sender;

    @Value("${server.port}")
    @NonFinal
    String port;

    @Override
    public String sendEmailResetPassword(String email) {
        try {
            var user = userRepository.findByEmailAndStatus(email, true);
            String otp = UUID.randomUUID().toString();
            assert user != null;
            user.setOtp(otp);
            userRepository.save(user);
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

            helper.setFrom(sender);
            helper.setTo(email);
            helper.setSubject("Thay đổi mật khẩu");

            String htmlContent = String.format("<html>" +
                    "<body>" +
                    "<p>Vui lòng truy cập vào đường dẫn bên dưới để thay đổi mật khẩu:</p>" +
                    "<br>" +
                    "<a href='http://localhost:" + port + "/reset-password/%s'>Đổi mật khẩu</a>" +
                    "</body>" +
                    "</html>", otp);

            helper.setText(htmlContent, true);

            javaMailSender.send(mimeMessage);
            return "Gửi thành công";
        }

        catch (Exception e) {
            log.info(e.getMessage());
            return "Lỗi";
        }
    }

    @Override
    public String sendEmailWithSubjectAndContent(String email, String subject, String content) {
        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

            helper.setFrom(sender);
            helper.setTo(email);
            helper.setSubject(subject);

            String htmlContent = String.format(content);

            helper.setText(htmlContent, true);

            javaMailSender.send(mimeMessage);
            return "Gửi thành công";
        }

        catch (Exception e) {
            log.info(e.getMessage());
            return "Lỗi";
        }
    }

    @Override
    public String sendSimpleMail(EmailDetail details)
    {
        try {

            SimpleMailMessage mailMessage
                    = new SimpleMailMessage();

            mailMessage.setFrom(sender);
            mailMessage.setTo(details.getRecipient());
            mailMessage.setText(details.getMsgBody());
            mailMessage.setSubject(details.getSubject());

            javaMailSender.send(mailMessage);
            return "Gửi thành công";
        }

        catch (Exception e) {
            log.info(e.getMessage());
            return "Lỗi";
        }
    }

}
