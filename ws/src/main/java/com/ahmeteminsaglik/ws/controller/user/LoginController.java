package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.model.JwtAuthResponse;
import com.ahmeteminsaglik.ws.model.LoginCredentials;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.JwtUtil;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.ErrorDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("")
@CrossOrigin
public class LoginController {
    private static final Logger log = LoggerFactory.getLogger(LoginController.class);
    @Autowired
    private UserService service;
    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserService userService;
    @Autowired
    private UserDetailsService userDetailsService;

    /*@GetMapping("/login")
    public ResponseEntity<DataResult<String>> login() {
        log.info("GET > findAllUserList ");
        DataResult<List<User>> dataResult = new SuccessDataResult<>("You should send Username and password here.");
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }*/

    @PostMapping("/login")
    public ResponseEntity<DataResult<JwtAuthResponse>> login(@RequestBody LoginCredentials loginCreds) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginCreds.getUsername(), loginCreds.getPassword()));
        UserDetails userDetails = userDetailsService.loadUserByUsername(loginCreds.getUsername());
        JwtAuthResponse response = new JwtAuthResponse();
        response.setAccessToken(jwtUtil.generateToken(userDetails.getUsername()));

        return ResponseEntity.ok(new ErrorDataResult<>(response, "Login islemi kisminda kalindi -( Spring Security & JWT - Ekleniyor )"));
//        User user = userService.findByUsername(userDetails.getUsername());
//        UserDto userDto = ModelMapper.convertToUserDto(user);
//        return ResponseEntity.ok(new ErrorDataResult<>(user, "Login islemi kisminda kalindi -( Spring Security & JWT - Ekleniyor )"));
    }

    @PostMapping("/token")
    public ResponseEntity<DataResult<User>> login(@RequestBody String token) {
        return ResponseEntity.ok(new ErrorDataResult<>(null, "Login islemi kisminda kalindi -( Spring Security & JWT - Ekleniyor )"));
    }

}

