/*
package com.harpia.HarpiaHealthAnalysisWS.config.firebase;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.FirebaseMessagingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;

import javax.annotation.PostConstruct;
import java.io.IOException;

@Configuration

public class FirebaseConfiguration {
    private static final Logger log = LoggerFactory.getLogger(FirebaseMessagingService.class);

    @Value("classpath:harpia-c2066-firebase-adminsdk-c5ybs-8f9ee30ca1.json")
    Resource resourceFile;

    @Bean
    public FirebaseAuth firebaseAuth() {
        return FirebaseAuth.getInstance();
    }

    @PostConstruct
    public void initializeFirebaseApp() {
        try {
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(resourceFile.getInputStream()))
                    .setServiceAccountId("firebase-adminsdk-c5ybs@harpia-c2066.iam.gserviceaccount.com")
                    .build();
            FirebaseApp.initializeApp(options);


        } catch (IOException e) {
            log.error("ERROR OCCURD : " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}
*/
