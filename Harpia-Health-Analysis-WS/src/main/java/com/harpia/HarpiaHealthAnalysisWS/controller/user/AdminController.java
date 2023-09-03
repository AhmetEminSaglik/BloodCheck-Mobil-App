package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.controller.user.role.UserRoleController;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Admin;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admins")
@CrossOrigin
public class AdminController {
    private static CustomLog log = new CustomLog(AdminController.class);
    @Autowired
    private UserService userService;

    @PostMapping("/save")
    public ResponseEntity<DataResult<User>> saveAdmin(@RequestBody Admin inputAdmin) {
        inputAdmin.setRoleId(EnumUserRole.ADMIN.getId());
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(inputAdmin);
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping("/{id}")
    public DataResult<Admin> findById(@PathVariable long id) {
        Admin admin = (Admin) userService.findById(id);
        return new SuccessDataResult<>(admin, "Admin retrived Succesfully");
    }

    @PutMapping()
    public ResponseEntity<DataResult<Doctor>> updateAdmin(@RequestBody Admin newAdmin) {
        newAdmin = (Admin) userService.save(newAdmin);
        String msg = "Doctor is updated";
        DataResult<Doctor> result = new SuccessDataResult(newAdmin, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

}
