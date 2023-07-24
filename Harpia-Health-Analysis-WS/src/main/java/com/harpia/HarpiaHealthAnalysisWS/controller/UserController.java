package com.harpia.HarpiaHealthAnalysisWS.controller;

import com.harpia.HarpiaHealthAnalysisWS.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/1.0/users")
@CrossOrigin
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);


    @PostMapping()
    public void textRequestBody(@RequestBody User user) {
        log.info(user.toString());
    }
}

