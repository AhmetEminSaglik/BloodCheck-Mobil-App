package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.signup.SignupUser;
import com.ahmeteminsaglik.ws.model.JwtAuthResponse;
import com.ahmeteminsaglik.ws.model.dto.ModelMapper;
import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.users.Admin;
import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.JwtUtil;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admins")
@CrossOrigin
public class AdminController {
    private static final Logger log = LoggerFactory.getLogger(AdminController.class);
    @Autowired
    private UserService userService;
    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping()
    public ResponseEntity<DataResult<User>> saveAdmin(@RequestBody Admin admin) {
        log.info("POST > saveAdmin ");
//        log.info("(Param) admin: " + admin);
        admin.setRoleId(EnumAuthority.ROLE_ADMIN.getId());
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(admin);
        log.info("Admin signup successfully.");
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    /*
    *    @GetMapping("/{id}")
    public ResponseEntity<DataResult<Doctor>> findById(@PathVariable long id) {
        Doctor personnel = (Doctor) userService.findById(id);
        DataResult<Doctor> dataResult = new SuccessDataResult<>(personnel, "Doctor retrieved Successfully.");
        return ResponseEntity.ok().body(dataResult);
    }
    * */
    @GetMapping("/{id}")
    public ResponseEntity<DataResult<Admin>> findById(@PathVariable long id) {
        log.info("GET > findById ");
        log.info("(Param) id: " + id);
        Admin admin = (Admin) userService.findById(id);
        DataResult<Admin> dataResult = new SuccessDataResult<>(admin, "Admin retrieved Successfully.");
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @PutMapping()
    public ResponseEntity<DataResult<JwtAuthResponse>> updateAdmin(@RequestBody Admin newUser) {
        log.info("PUT > updateAdmin ");
        String msg = "Admin is updated";

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        Doctor existedUser = (Doctor) userService.findById(newUser.getId());

        if(newUser.getUsername()!=null&&!newUser.getUsername().isEmpty()){
            existedUser.setUsername(newUser.getUsername());
        }
        if(newUser.getName()!=null&&!newUser.getName().isEmpty()){
            existedUser.setName(newUser.getName());
        }
        if(newUser.getLastname()!=null&&!newUser.getLastname().isEmpty()){
            existedUser.setLastname(newUser.getLastname());
        }
        if (newUser.getPassword() != null && !newUser.getPassword().isEmpty()) {
            existedUser.setPassword("{bcrypt}" + passwordEncoder.encode(newUser.getPassword()));
        }

        newUser = (Admin) userService.save(existedUser);

        JwtAuthResponse response = new JwtAuthResponse();
        response.setAccessToken(jwtUtil.generateToken(newUser.getUsername()));
        DataResult<JwtAuthResponse> dataResult = new SuccessDataResult<>(response, msg);
        response.setUserDto(ModelMapper.convertToUserDto(newUser));
        response.getUserDto().setToken(response.getAccessToken());

        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

}
