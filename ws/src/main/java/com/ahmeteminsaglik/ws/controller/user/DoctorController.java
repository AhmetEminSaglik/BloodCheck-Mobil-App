package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.DoctorService;
import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.signup.SignupUser;
import com.ahmeteminsaglik.ws.model.enums.EnumUserRole;
import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.Patient;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/doctors")
@CrossOrigin
public class DoctorController {
    private static final Logger log = LoggerFactory.getLogger(DoctorController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private DoctorService doctorService;
    @Autowired
    private PatientService patientService;

    @PostMapping()
    public ResponseEntity<DataResult<User>> saveDoctor(@RequestBody Doctor doctor) {
        log.info("POST > saveDoctor ");
        doctor.setRoleId(EnumUserRole.DOCTOR.getId());
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(doctor);
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
    public ResponseEntity<DataResult<Doctor>> updateDoctor(@RequestBody Doctor newDoctor) {
        log.info("PUT > updateDoctor ");
        newDoctor = (Doctor) userService.save(newDoctor);
        String msg = "Doctor is updated";
        DataResult<Doctor> dataResult = new SuccessDataResult<>(newDoctor, msg);
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

}
