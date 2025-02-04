package com.ahmeteminsaglik.ws.config;

import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
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

                                        .requestMatchers("/**").hasRole(admin)
//                                .requestMatchers(HttpMethod.DELETE, "/users").hasAnyRole(admin)

                )
                /*.formLogin(formLogin ->
                        formLogin
                                .loginPage().permitAll())
                */.logout(e -> e.permitAll())
        // JWT filter'ı ekliyoruz
                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);
        // use HTTP basic authentication
//        http.httpBasic(Customizer.withDefaults());

        // disable Cross Site Request Forgery (CSRF)
//        http.csrf(csrf -> csrf.disable());
        return http.build();
    }
}
