/*
package com.harpia.HarpiaHealthAnalysisWS.controller.user.role;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.model.users.UserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/users/roles")
@CrossOrigin
public class UserRoleController {
    private static final Logger log = LoggerFactory.getLogger(UserRole.class);

    //    @Autowired
    private final UserRoleService service;

    @Autowired
    public UserRoleController(UserRoleService service) {
        this.service = service;
    }

    @PostMapping
    public SuccessDataResult<List<UserRole>> setupStandartUserRole() {
        List<UserRole> data = service.saveAll(getStandartUserRoleList());
        String msg="3 roles are added";
        return new SuccessDataResult<>(data,msg);
    }

    private List<UserRole> getStandartUserRoleList() {
        List<UserRole> list = new ArrayList<>();
        list.add(new UserRole(1, EnumUserRole.ADMIN.getName()));
        list.add(new UserRole(2, EnumUserRole.HEALTHCARE_PERSONAL.getName()));
        list.add(new UserRole(3, EnumUserRole.PATIENT.getName()));
        return list;
    }

    public UserRole findUserRoleById(int id) {
        return service.findById(id);
    }
}
*/
