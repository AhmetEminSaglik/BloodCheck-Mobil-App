package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.auth.AuthorityService;
import com.ahmeteminsaglik.ws.business.abstracts.user.DoctorService;
import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.signup.SignupUser;
import com.ahmeteminsaglik.ws.model.JwtAuthResponse;
import com.ahmeteminsaglik.ws.model.dto.ModelMapper;
import com.ahmeteminsaglik.ws.model.dto.UserDto;
import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.Patient;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.model.users.role.Authority;
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

import java.util.List;

@RestController
@RequestMapping("/doctors")
@CrossOrigin
public class DoctorController {
    private static final Logger log = LoggerFactory.getLogger(DoctorController.class);

    private final UserService userService;
    private final DoctorService doctorService;
    private final PatientService patientService;
    private final JwtUtil jwtUtil;
    private final AuthorityService roleService;
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Autowired
    public DoctorController(UserService userService, DoctorService doctorService, PatientService patientService, JwtUtil jwtUtil, AuthorityService roleService) {
        this.userService = userService;
        this.doctorService = doctorService;
        this.patientService = patientService;
        this.jwtUtil = jwtUtil;
        this.roleService = roleService;
    }

    @PostMapping()
    public ResponseEntity<DataResult<User>> saveDoctor(@RequestBody Doctor user) {
        log.info("POST > saveDoctor ");
        user.setRoleId(EnumAuthority.ROLE_DOCTOR.getId());
        SignupUser signupUser = new SignupUser(userService);

        Authority doctorAuth = roleService.findByAuthority(EnumAuthority.ROLE_DOCTOR);
        Authority patientAuth = roleService.findByAuthority(EnumAuthority.ROLE_PATIENT);
        user.addAuthority(doctorAuth);
        user.addAuthority(patientAuth);

        DataResult<User> dataResult = signupUser.signup(user);
        log.info("Doctor signup successfully.");
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<Doctor>>> findAllDoctorList() {
        log.info("GET > findAllDoctorlist ");
        List<Doctor> doctors = doctorService.findAll();
        String msg = "All doctors are retrieved Successfully. (Size: " + doctors.size() + ")";
        log.info("Retrieved patient list size: " + doctors.size());
        DataResult<List<Doctor>> dataResult = new SuccessDataResult<>(doctors, msg);
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DataResult<Doctor>> findById(@PathVariable long id) {
        log.info("GET > findById ");
        log.info("(Param) id: " + id);
        Doctor personnel = (Doctor) userService.findById(id);
        DataResult<Doctor> dataResult = new SuccessDataResult<>(personnel, "Doctor retrieved Successfully.");
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/{id}/patients")
    public ResponseEntity<DataResult<List<Patient>>> findPatientListOfDoctorId(@PathVariable long id) {
        log.info("GET > findPatientListOfDoctorId ");
        log.info("(Param) id: " + id);
        List<Patient> patientList = patientService.findAllPatientByDoctorId(id);
        String msg = "All patients that belongs to Doctor (ID:" + id + ") is retrieved.";
        DataResult<List<Patient>> dataResult = new SuccessDataResult<>(patientList, msg);
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);

    }

    @PutMapping()
    public ResponseEntity<DataResult<JwtAuthResponse>> updateDoctor(@RequestBody Doctor newUser) {
        log.info("PUT > updateDoctor ");
        Doctor existedUser = (Doctor) userService.findById(newUser.getId());
        String msg = "Doctor is updated";

        if (newUser.getUsername() != null && !newUser.getUsername().isEmpty()) {
            existedUser.setUsername(newUser.getUsername());
        }
        if (newUser.getName() != null && !newUser.getName().isEmpty()) {
            existedUser.setName(newUser.getName());
        }
        if (newUser.getLastname() != null && !newUser.getLastname().isEmpty()) {
            existedUser.setLastname(newUser.getLastname());
        }
        if (newUser.getPassword() != null && !newUser.getPassword().isEmpty()) {
            existedUser.setPassword("{bcrypt}" + passwordEncoder.encode(newUser.getPassword()));
        }

        newUser = (Doctor) userService.save(existedUser);

        UserDto userDto = ModelMapper.convertToUserDto(newUser);
        String token = jwtUtil.generateToken(newUser.getUsername());
        JwtAuthResponse response = new JwtAuthResponse(userDto,token);

        DataResult<JwtAuthResponse> dataResult = new SuccessDataResult<>(response, msg);
        response.setUserDto(ModelMapper.convertToDoctorDto(newUser));
//        response.getUserDto().setToken(response.getAccessToken());

        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }
}