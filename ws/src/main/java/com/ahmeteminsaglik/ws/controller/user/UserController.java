package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.model.LoginCredentials;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.CustomUTCTime;
import com.ahmeteminsaglik.ws.utility.JwtUtil;
import com.ahmeteminsaglik.ws.utility.result.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);
    @Autowired
    private UserService service;
    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserDetailsService userDetailsService;

    @GetMapping()
    public ResponseEntity<DataResult<List<User>>> findAllUserList() {
        log.info("GET > findAllUserList ");
        DataResult<List<User>> dataResult = new SuccessDataResult<>(service.findAll(), "All users retrieved Successfully.");
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }


    @GetMapping("/time/minutes/{min}")
    public ResponseEntity<DataResult<List<User>>> findByLastCreatedMinusMinutes(@PathVariable int min) {
        log.info("GET > findByLastCreatedMinusMinutes ");
        log.info("(Param) min : " + min);
        LocalDateTime localDateTime = CustomUTCTime.getUTCTime().minusMinutes(min);
        List<User> users = service.findAllByCreatedAtAfter(localDateTime);
        String msg = "Retrieved all users that created last in  (" + min + ") minutes (Size:" + users.size() + ")";
        DataResult<List<User>> dataResult = new SuccessDataResult<>(users, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);

    }

    @GetMapping("/{id}")
    public DataResult<User> findById(@PathVariable long id) {
        log.info("GET > findById ");
        log.info("(Param) id : " + id);
        User user = service.findById(id);
        String msg = "User retrieved Successfully.";
        log.info(msg);
        return new SuccessDataResult<>(user, msg);
    }

    @PostMapping("/login")
    public ResponseEntity<DataResult<User>> login(@RequestBody LoginCredentials loginCreds) {
        return ResponseEntity.ok(new ErrorDataResult<>(null,"Login islemi kisminda kalindi -( Spring Security & JWT - Ekleniyor )"));
/*
        System.out.println("logine geldi");
        log.info("POST > login ");

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginCreds.getUsername(), loginCreds.getPassword())
        );

        UserDetails userDetails = userDetailsService.loadUserByUsername(loginCreds.getUsername());
        String token = jwtUtil.generateToken(userDetails.getUsername());
        JwtAuthResponse response = new JwtAuthResponse();
        response.setAccessToken(token);
        response.setUser();

//        LoginValidationService loginService = new LoginCredentialsValidation(service);
//        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());

        if (result.getData() == null) {
            log.info("Login is failed : Data is not found.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(result);
        } else {
            log.info("Login process is completed.");
            return ResponseEntity.status(HttpStatus.OK).body(result);
        }
*/
    }

    @DeleteMapping()
    public ResponseEntity<Result> deleteUser(@RequestBody LoginCredentials loginCreds) {
        log.info("DELETE > delete ");
        User user = login(loginCreds).getBody().getData();
        Result result;
        if (user != null) {
            service.delete(user);
            result = new SuccessResult("Account is deleted Successfully.");
            log.info(result.getMessage());
            return ResponseEntity.status(HttpStatus.OK).body(result);
        } else {
            result = new ErrorResult("Account is not found.");
            log.info(result.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(result);
        }
    }
}

