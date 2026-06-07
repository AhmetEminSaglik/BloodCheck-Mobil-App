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
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.LogoutConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@EnableWebSecurity
@Configuration
public class SecurityConfig {
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
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowedOrigins(List.of(
                "http://185.216.203.103:3000",
                "http://localhost:3000",
                "https://bloodcheck.aesaglik.com"
        ));
        config.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(List.of("*"));
        config.setAllowCredentials(false);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);
        return source;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        final String patient = EnumAuthority.ROLE_PATIENT.getName();
        final String doctor = EnumAuthority.ROLE_DOCTOR.getName();
        final String admin = EnumAuthority.ROLE_ADMIN.getName();

        http.cors(cors -> cors.configurationSource(corsConfigurationSource()));

        http.authorizeHttpRequests(configurer ->
                        configurer
                                .requestMatchers("/").permitAll()
                                .requestMatchers("/db").permitAll()
                                .requestMatchers("/login").permitAll()
                                .requestMatchers("/patients").hasRole(patient)
                                .requestMatchers("/patients/**").hasRole(patient)
                                .requestMatchers("/patients/*/doctors").hasRole(patient)
                                .requestMatchers("/users/time/minutes/*").hasRole(patient)
                                .requestMatchers("/bloodresults").hasRole(patient)
                                .requestMatchers("/bloodresults/**").hasRole(patient)
                                .requestMatchers("/timers").hasRole(patient)
                                .requestMatchers("/timers/**").hasRole(patient)
                                .requestMatchers("/firebase/**").hasRole(patient)
                                .requestMatchers("/doctors/*").hasRole(patient)
                                .requestMatchers("/doctors").hasRole(doctor)
                                .requestMatchers("/doctors/").hasRole(doctor)
                                .requestMatchers("/doctors/**").hasRole(doctor)
                                .requestMatchers("/admins").hasRole(admin)
                                .requestMatchers("/admins/**").hasRole(admin)
//                                .requestMatchers("/**").hasRole(admin)
                                .requestMatchers("/users/**").hasAnyRole(patient, admin)
                                .requestMatchers(HttpMethod.DELETE, "/users/**").hasAnyRole(patient, admin)
//                                .requestMatchers(HttpMethod.DELETE, "/users/**").permitAll()
                )
                .logout(LogoutConfigurer::permitAll)
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);

        http.csrf(AbstractHttpConfigurer::disable);

        return http.build();
    }
}