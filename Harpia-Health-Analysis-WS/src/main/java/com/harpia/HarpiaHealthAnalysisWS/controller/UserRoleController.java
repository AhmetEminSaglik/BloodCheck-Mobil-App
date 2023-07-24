package com.harpia.HarpiaHealthAnalysisWS.controller;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.model.UserRole;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/users/role")
@CrossOrigin
public class UserRoleController {
    private static final Logger log = LoggerFactory.getLogger(UserRole.class);

    @Autowired
    private UserRoleService service;

    @PostMapping
    public SuccessDataResult<Iterable<UserRole>> setupStandartUserRole() {
        log.info("buraya geldi");
        Iterable<UserRole> data = service.saveAll(getStandartUserRole());
        return new SuccessDataResult<>(data);
    }

    private List<UserRole> getStandartUserRole() {
        List<UserRole> list = new ArrayList<>();
        list.add(new UserRole(1, "Admin"));
        list.add(new UserRole(2, "Healthcare_Personnel"));
        list.add(new UserRole(3, "Patient"));
        return list;
    }

}
