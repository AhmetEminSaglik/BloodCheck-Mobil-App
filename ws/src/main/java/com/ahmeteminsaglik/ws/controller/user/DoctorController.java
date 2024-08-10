package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.signup.SignupUser;
import com.ahmeteminsaglik.ws.model.enums.EnumUserRole;
import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.Patient;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.xml.crypto.Data;
import java.util.List;

@RestController
@RequestMapping("/doctors")
@CrossOrigin()
public class DoctorController {
    private static CustomLog log = new CustomLog(DoctorController.class);
    @Autowired
    private UserService userService;

    @Autowired
    private PatientService patientService;

    @PostMapping()
    public ResponseEntity<DataResult<User>> saveDoctor(@RequestBody Doctor inputPersonel) {
        inputPersonel.setRoleId(EnumUserRole.DOCTOR.getId());
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(inputPersonel);
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<User>>> findAllDoctorlist() {
        List<User> doctorList = userService.findAllByRoleId(EnumUserRole.DOCTOR.getId());
        String msg = "Doctor list is retrieved successfully";
        DataResult<List<User>> dataResult = new SuccessDataResult<>(doctorList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DataResult<Doctor>> findById(@PathVariable long id) {
        Doctor personnel = (Doctor) userService.findById(id);
        DataResult<Doctor> dataResult = new SuccessDataResult<>(personnel, "Doctor retrieved Successfully");
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/{id}/patients")
    public ResponseEntity<DataResult<List<Patient>>> findPatientListOfDoctorId(@PathVariable long id) {
        List<Patient> patientList = patientService.findAllPatientByDoctorId(id);
        String msg = "Patient List belongs to Doctor ID " + id + " is retrieved";
        DataResult<List<Patient>> result = new SuccessDataResult(patientList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);

    }

    @PutMapping()
    public ResponseEntity<DataResult<Doctor>> updateDoctor(@RequestBody Doctor newDoctor) {
        newDoctor = (Doctor) userService.save(newDoctor);
        String msg = "Doctor is updated";
        DataResult<Doctor> result = new SuccessDataResult(newDoctor, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

}
