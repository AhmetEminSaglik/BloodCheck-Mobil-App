package com.ahmeteminsaglik.ws.config;

import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@EnableWebSecurity
@Configuration
public class SecurityConfig {

    //    @Autowired
    private final JwtFilter jwtFilter;

    @Autowired
    public SecurityConfig(JwtFilter jwtFilter) {
        this.jwtFilter = jwtFilter;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) throws Exception {
        return configuration.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        final String patient = EnumAuthority.ROLE_PATIENT.getName();
        final String doctor = EnumAuthority.ROLE_DOCTOR.getName();
        final String admin = EnumAuthority.ROLE_ADMIN.getName();

        http.authorizeHttpRequests(configurer ->
                        configurer
                                .requestMatchers("/login").permitAll()
                                .requestMatchers(HttpMethod.GET, "/bloodresults/patient/**").hasAnyRole(patient)
//                                .requestMatchers(HttpMethod.GET, "/users").hasAnyRole(employee)
//                                .requestMatchers(HttpMethod.GET, "/users/**").hasAnyRole(employee)
//                                .requestMatchers(HttpMethod.POST, "/users").hasAnyRole(manager)
//                                .requestMatchers(HttpMethod.PUT, "/users/**").hasAnyRole(manager)
//                                .requestMatchers(HttpMethod.DELETE, "/users").hasAnyRole(admin)

                )
                // JWT filter'ı ekliyoruz
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);
        // use HTTP basic authentication
//        http.httpBasic(Customizer.withDefaults());

        // disable Cross Site Request Forgery (CSRF)
        http.csrf(csrf -> csrf.disable());
        return http.build();
    }
}
