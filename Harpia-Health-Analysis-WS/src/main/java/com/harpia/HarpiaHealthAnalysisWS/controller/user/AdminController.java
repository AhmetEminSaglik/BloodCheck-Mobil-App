package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.Admin;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admins")
@CrossOrigin
public class AdminController {
    protected static final Logger log = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private UserService service;

    @PostMapping()
    public DataResult<Admin> saveAdmin(@RequestBody Admin inputAdmin) {
        Admin admin = (Admin) service.save(inputAdmin);
        return new SuccessDataResult<>(admin, "All Admins retrived successfully");
    }


}
