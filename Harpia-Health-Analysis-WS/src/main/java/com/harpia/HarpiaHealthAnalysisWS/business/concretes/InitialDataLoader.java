package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Admin;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class InitialDataLoader implements CommandLineRunner {
    @Autowired
    private UserService userService;
    private static final Logger log = LoggerFactory.getLogger(InitialDataLoader.class);

    public void saveInitilizateData() {
        List<User> list = getAdminList();
        for (int i = 0; i < list.size(); i++) {
            String username = list.get(i).getUsername();
            String pass = list.get(i).getPassword();
            User user = userService.findByUsernameAndPassword(username, pass);
            if (user == null) {
                userService.save(list.get(i));
            }
            {
                log.info("Admin(" + (i + 1) + ") data is already registered.");
            }
        }
    }


    private List<User> getAdminList() {
        List<User> list = new ArrayList<>();
        User admin = new Admin();
        admin.setName("Bulut");
        admin.setLastname("AKAY");
        admin.setUsername("bulut");
        admin.setPassword("akay");
        list.add(admin);
        admin = new Admin();
        admin.setName("Ahmet Emin");
        admin.setLastname("SAGLIK");
        admin.setUsername("emin");
        admin.setPassword("saglik");
        list.add(admin);
        return list;
    }

    @Override
    public void run(String... args) throws Exception {
        saveInitilizateData();
    }
}
