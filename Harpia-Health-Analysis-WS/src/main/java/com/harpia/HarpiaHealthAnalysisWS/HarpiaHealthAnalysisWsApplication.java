package com.harpia.HarpiaHealthAnalysisWS;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;

@SpringBootApplication
public class HarpiaHealthAnalysisWsApplication {
    private static final Logger log = LoggerFactory.getLogger(HarpiaHealthAnalysisWsApplication.class);

    @Bean
    FirebaseMessaging firebaseMessaging() {
        try {
            GoogleCredentials googleCredentials = GoogleCredentials
                    .fromStream(new ClassPathResource("harpia-c2066-firebase-adminsdk-c5ybs-8f9ee30ca1.json").getInputStream());
            log.info("----------- > googleCredentials 1 :" + googleCredentials);
            log.info("----------- > googleCredentials 2 :" + googleCredentials.getAuthenticationType());
            log.info("----------- > googleCredentials 3 :" + googleCredentials.getAccessToken());
//            log.info("----------- > googleCredentials 4 :" + googleCredentials.getRequestMetadata());

            FirebaseOptions firebaseOptions = FirebaseOptions.builder()
                    .setCredentials(googleCredentials).build();
            log.info("----------- > firebaseOptions 5 :" + firebaseOptions);
            log.info("----------- > firebaseOptions 6 :" + firebaseOptions.getDatabaseUrl());
            log.info("----------- > firebaseOptions 7 :" + firebaseOptions.getProjectId());
            log.info("----------- > firebaseOptions 8 :" + firebaseOptions.getReadTimeout());
            log.info("----------- > firebaseOptions 9 :" + firebaseOptions.getProjectId());
            log.info("----------- > firebaseOptions 10 :" + firebaseOptions.getConnectTimeout());
            log.info("----------- > firebaseOptions 11 :" + firebaseOptions.getStorageBucket());
            log.info("----------- > firebaseOptions 12 :" + firebaseOptions.getServiceAccountId());
            log.info("----------- > firebaseOptions 13 :" + firebaseOptions.getDatabaseAuthVariableOverride());
            log.info("----------- > firebaseOptions 14 :" + firebaseOptions.getJsonFactory());


            FirebaseApp app = FirebaseApp.initializeApp(firebaseOptions, "Harpia");
            log.info("----------- > app  :" + app);
            log.info("----------- > app  :" + app.getName());
            log.info("----------- > app  :" + app.getOptions());
            return FirebaseMessaging.getInstance(app);
        } catch (IOException e) {
            log.info("BEAN HATA ------- > >"+e.getMessage());
//            throw new RuntimeException(e);
        }
        return null;
    }

    public static void main(String[] args) {
        SpringApplication.run(HarpiaHealthAnalysisWsApplication.class, args);
    }
}
