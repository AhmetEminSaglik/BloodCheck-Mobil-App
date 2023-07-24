package com.harpia.HarpiaHealthAnalysisWS.controller;

import com.harpia.HarpiaHealthAnalysisWS.model.HealthcarePersonnel;
import com.harpia.HarpiaHealthAnalysisWS.model.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.User;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@RestController
@RequestMapping("/api/1.0/users")
@CrossOrigin
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService service;


    @PostMapping()
    public List<User> textRequestBody(@RequestBody Patient user) {
        HealthcarePersonnel h1 = new HealthcarePersonnel();
        h1.setTotalPatientNumber(50);
        h1.setName("healt personeal");
        h1.setLastname("healt personeal".toUpperCase(Locale.ROOT));
        h1.setUsername("h1h1h1");
        h1.setPassword("h1h1h1");

        Patient p1 = new Patient();
        p1.setName("patient");
        p1.setLastname("patient".toUpperCase(Locale.ROOT));
        p1.setUsername("p1p1p1");
        p1.setPassword("p1p1p1");
        p1.setPatientNo("505-232-12-21");
        User uh1 = service.save(h1);
        User up1 = service.save(p1);

        log.info(uh1.toString());
        log.info(up1.toString());
        List<User> list = new ArrayList<>();
        list.add(h1);
        list.add(p1);
        return list;
    }
}

