/*
package com.harpia.HarpiaHealthAnalysisWS.controller.firebase;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/auth")
public class AppController {
    private static final Logger log = LoggerFactory.getLogger(AppController.class);

    private FirebaseAuth firebaseAuth;

    @Autowired
    public AppController(FirebaseAuth firebaseAuth) {
        this.firebaseAuth = firebaseAuth;
    }

    @GetMapping("/token")
    public Map<String, String> getToken() {
        String customToken = "Empty Custom Token";
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String authorities = authentication.getAuthorities()
                    .stream().map(GrantedAuthority::getAuthority)
                    .collect(Collectors.joining(","));
            customToken = firebaseAuth.createCustomToken("harpia", Collections.singletonMap("authorities", authorities));
        } catch (Exception e) {
            log.error("----------------------- ERROR OCCRUED : " + e.getMessage());
            throw new RuntimeException(e);
        }
        return Collections.singletonMap("token", customToken);
    }
}
*/
