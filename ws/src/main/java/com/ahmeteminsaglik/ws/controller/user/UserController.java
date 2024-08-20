package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.login.LoginValidationService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.login.LoginCredentialsValidation;
import com.ahmeteminsaglik.ws.model.LoginCredentials;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.result.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin
public class UserController {
    private static CustomLog log = new CustomLog(UserController.class);
    @Autowired
    private UserService service;


    @GetMapping()
    public ResponseEntity<DataResult<List<User>>> findAllUserList() {
        DataResult<List<User>> dataResult = new SuccessDataResult<>(service.findAll(), "All users retrived successfully");
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

//    @Autowired
//    UserRepository repository;

    @GetMapping("/time/minutes/{min}")
    public ResponseEntity<DataResult<List<User>>> findByLastCreatedMinusMinutes(@PathVariable int min) {
        OffsetDateTime localDateTime = OffsetDateTime.now().minusMinutes(min);
        DataResult<List<User>> dataResult = new SuccessDataResult<>(service.findAllByCreatedAtAfter(localDateTime));
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);

    }

    @GetMapping("/{id}")
    public DataResult<User> findById(@PathVariable long id) {
        User user = service.findById(id);
        return new SuccessDataResult<>(user, "User retrived Succesfully");
    }

    @PostMapping("/login")
    public ResponseEntity<DataResult<User>> login(@RequestBody LoginCredentials loginCreds) {
        LoginValidationService loginService = new LoginCredentialsValidation(service);
//        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//        loginCreds.setPassword(passwordEncoder.encode(loginCreds.getPassword()));
//        Base64.getDecoder().decode(loginCreds.getPassword());
//        List<User> userList=service.findAll();
//        passwordEncoder.matches()
        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());
        if (result.getData() == null) {
            System.out.println("Login is failed : Data is not found");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(result);
        } else {
            System.out.println("Login process --> " + result.getData().getId());
        }
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @DeleteMapping()
    public ResponseEntity<Result> deleteUser(@RequestBody LoginCredentials loginCreds) {
        User user = login(loginCreds).getBody().getData();
        Result result;
        if (user != null) {
            service.delete(user);
            result = new SuccessResult("Account is deleted successfully");
            return ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            result = new ErrorResult("Account is not found");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(result);
        }
    }
}

