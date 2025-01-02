/*
package com.ahmeteminsaglik.ws.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
//                .allowedOrigins("http://localhost:3000")  // Frontend URL'si
                .allowedOrigins("http://172.17.0.1:3000")  // Frontend URL'si
                .allowedOrigins("http://host.docker.internal:3000")  // Frontend URL'si
                .allowedMethods("GET", "POST", "PUT", "DELETE")
                .allowedHeaders("*");
    }
}*/
