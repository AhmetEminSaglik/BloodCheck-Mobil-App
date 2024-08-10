package com.ahmeteminsaglik.ws;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Arrays;

@SpringBootApplication
public class BloodCheckWsApplication {
    public static void main(String[] args) {
        SpringApplication.run(BloodCheckWsApplication.class, args);
        initFirebase();
    }

    private static String path = "src/main/resources/service-key.json";

    private static void initFirebase() {
        try {
            FileInputStream serviceAccount =
                    new FileInputStream(path);

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            FirebaseApp.initializeApp(options);

//            FirebaseApp defaultApp = FirebaseApp.initializeApp(options);
//            defaultApp.getOptions().
//            System.out.println(defaultApp.getName());
//            System.out.println("new token : " + getAccessToken());
//            var temp =FirebaseApp.getInstance();
//            String customToken= FirebaseAuth.getInstance().createCustomToken("ABC");
//            String customToken = FirebaseAuth.getInstance().createCustomToken("ASD");
//            System.out.println("customToken : " + customToken);


//            Message message =Message.builder().putData("necati-key","cozum-oldu").putData("abc","efg").build();
            //topic-condition bakilacak
            Message message = Message.builder()
//                    .setNotification(Notification.builder().setTitle("Title eklendi").setBody("Body eklendi")
                    .setNotification(Notification.builder().setTitle("DOCTOR eklendi").setBody("ASDASDBody eklendi")
                            .build())
                    .putData("reasonCode","asd")
//                    .setToken("fX5b0ksASF-Hc8xbvOBjDP:APA91bFt-ya2VRAHeNcnJlQ_MZD1FHSK9a3UQpeZZe5crzg6UL1TMkVJM3fGO1wGa5_iw_jUUhhqspDtaOnm2M6BXBAAncqcp_8dEHsHTuDJgE2YTOaGjVaNQimARDXGd9V1FIYC0-FZ")
                    .setTopic("Istanbul")
                    .build();
            FirebaseMessaging.getInstance().send(message);
//
//
//            System.out.println("Firebase init basariliyle calisti");
        } catch (Exception e) {
            System.out.println("Hata meydana geldi" + e.getMessage());
        }
    }

    private static final String MESSAGING_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";
    private static final String[] SCOPES = {MESSAGING_SCOPE};

    private static String getAccessToken() throws IOException {
        GoogleCredentials googleCredentials = GoogleCredentials.fromStream(new FileInputStream(path)).createScoped(Arrays.asList(SCOPES));
        googleCredentials.refresh();
        return googleCredentials.getAccessToken().getTokenValue();
    }
}
