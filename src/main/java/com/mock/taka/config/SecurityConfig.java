package com.mock.taka.config;

import com.mock.taka.domain.User;
import com.mock.taka.service.client.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import java.io.IOException;
import java.util.Set;

@Configuration
@EnableWebSecurity
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@RequiredArgsConstructor
public class SecurityConfig {

    ApplicationContext applicationContext;

    public UserService getUserService() {
        return applicationContext.getBean(UserService.class);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10);
    }

    @Bean
    public UserDetailsService getDetailsService() {
        return new CustomUserDetailsService();
    }

    @Bean
    public DaoAuthenticationProvider getAuthenticationProvider() {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setUserDetailsService(getDetailsService());
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder());
        return daoAuthenticationProvider;
    }

    @Bean
    public CustomAuthenticationFailureHandler customAuthenticationFailureHandler() {
        return new CustomAuthenticationFailureHandler();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception
    {
        http.csrf(csrf->csrf.disable()).cors(cors->cors.disable())
                .authorizeHttpRequests(req-> {
                        req.requestMatchers("/admin/**").hasRole("ADMIN");
                        req.requestMatchers("/user/**").hasAnyAuthority("OIDC_USER", "SCOPE_openid", "ROLE_USER", "ROLE_ADMIN", "ROLE_SUPPLIER");
                        req.requestMatchers("/store/**").hasAnyAuthority("ROLE_SUPPLIER");
                        req.requestMatchers("/**", "/api/**").permitAll();
                        req.anyRequest().authenticated();})
                .formLogin(form->form.loginPage("/login")
                        .loginProcessingUrl("/login")
                        .failureHandler(customAuthenticationFailureHandler())
                                .successHandler(new AuthenticationSuccessHandler() {
                                    @Override
                                    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                                        Set<String> roles = AuthorityUtils.authorityListToSet(authentication.getAuthorities());
                                        CustomUser u = (CustomUser) authentication.getPrincipal();
                                        User user = getUserService().findByEmail(u.getUsername());
                                        user.setPassword("");
                                        HttpSession session = request.getSession(false);
                                        session.setAttribute("user", user);

                                        if (roles.contains("ADMIN")) {
                                            response.sendRedirect("/admin/");
                                        } else if (roles.contains("DELIVERY")) {
                                            response.sendRedirect("/delivery/");
                                        } else {
                                            response.sendRedirect("/home");
                                        }
                                    }
                                })
                )

                .oauth2Login(oauth2login -> oauth2login
                        .loginPage("/login")
                        .successHandler(new AuthenticationSuccessHandler() {
                            @Override
                            public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                                                Authentication authentication) throws IOException, ServletException {
                                OAuth2User oauth2User = (OAuth2User) authentication.getPrincipal();
                                CustomOAuth2User customOAuth2User = new CustomOAuth2User(oauth2User);
                                log.info(customOAuth2User.getAttribute("email"));
                                log.info(customOAuth2User.getAttribute("picture"));

                                getUserService().processOAuthPostLogin(customOAuth2User.getAttribute("email"),
                                        customOAuth2User.getAttribute("name"),
                                        customOAuth2User.getAttribute("picture"), request);
                                log.info("Authorities: {}", authentication.getAuthorities());

                                response.sendRedirect("/home");
                            }
                        }))

                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login")
                        .permitAll());

        return http.build();
    }

}