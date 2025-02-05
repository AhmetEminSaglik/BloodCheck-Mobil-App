package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.model.JwtAuthResponse;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.CustomUTCTime;
import com.ahmeteminsaglik.ws.utility.JwtUtil;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);
    private final UserService userService;
    private final JwtUtil jwtUtil;
    private final AuthenticationManager authenticationManager;
    private final UserDetailsService userDetailsService;

    @Autowired
    public UserController(UserService userService, JwtUtil jwtUtil, AuthenticationManager authenticationManager, UserDetailsService userDetailsService) {
        this.userService = userService;
        this.jwtUtil = jwtUtil;
        this.authenticationManager = authenticationManager;
        this.userDetailsService = userDetailsService;
    }

    @GetMapping()
    public ResponseEntity<DataResult<List<User>>> findAllUserList() {
        log.info("GET > findAllUserList ");
        DataResult<List<User>> dataResult = new SuccessDataResult<>(userService.findAll(), "All users retrieved Successfully.");
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }


    @GetMapping("/time/minutes/{min}")
    public ResponseEntity<DataResult<List<User>>> findByLastCreatedMinusMinutes(@PathVariable int min) {
        log.info("GET > findByLastCreatedMinusMinutes ");
        log.info("(Param) min : " + min);
        LocalDateTime localDateTime = CustomUTCTime.getUTCTime().minusMinutes(min);
        List<User> users = userService.findAllByCreatedAtAfter(localDateTime);
        String msg = "Retrieved all users that created last in  (" + min + ") minutes (Size:" + users.size() + ")";
        DataResult<List<User>> dataResult = new SuccessDataResult<>(users, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);

    }

    @GetMapping("/{id}")
//    @PreAuthorize("(hasRole('PATIENT') and #id == authentication.principal.id) or hasRole('ADMIN')")
    public DataResult<User> findById(@PathVariable long id) {
        log.info("GET > findById ");
        log.info("(Param) id : " + id);
        User user = userService.findById(id);
        String msg = "User retrieved Successfully.";
        log.info(msg);
        return new SuccessDataResult<>(user, msg);
    }

    @PutMapping()
    public <T extends User> ResponseEntity<DataResult<JwtAuthResponse>> updateUser(@RequestBody T newUser) {
        log.info("PUT > updatePatient ");

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        T existedUser = (T) userService.findById(newUser.getId());
        existedUser.setUsername(newUser.getUsername());
        existedUser.setName(newUser.getName());
        existedUser.setLastname(newUser.getLastname());
        if (newUser.getPassword() != null && !newUser.getPassword().isEmpty()) {
            log.info("Password : " + newUser.getPassword());
            existedUser.setPassword("{bcrypt}" + passwordEncoder.encode(newUser.getPassword()));
        }
        newUser = (T) userService.save(existedUser);
        String msg = "Patient is updated";

        JwtAuthResponse response = new JwtAuthResponse();
        response.setAccessToken(jwtUtil.generateToken(newUser.getUsername()));
        DataResult<JwtAuthResponse> dataResult = new SuccessDataResult<>(response, msg);

        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }
}