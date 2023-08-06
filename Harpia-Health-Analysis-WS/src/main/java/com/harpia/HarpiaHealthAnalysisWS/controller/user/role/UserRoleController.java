package com.harpia.HarpiaHealthAnalysisWS.controller.user.role;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.model.users.role.UserRole;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users/roles")
@CrossOrigin
public class UserRoleController {
    private static final Logger log = LoggerFactory.getLogger(UserRole.class);
    private final UserRoleService service;

    @Autowired
    public UserRoleController(UserRoleService service) {
        this.service = service;
    }
}
