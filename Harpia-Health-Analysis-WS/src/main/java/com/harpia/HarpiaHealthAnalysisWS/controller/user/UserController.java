package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.disease.DiseaseService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login.LoginValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.LoginCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.model.LoginCredentials;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Diabetic;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Disease;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "http://localhost:8080")
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService service;
    //    @Autowired
//    private UserRoleService roleService;
    @Autowired
    private DiseaseService diseaseService;

    @GetMapping()
    public DataResult<List<User>> findAllUserList() {
        return new SuccessDataResult<>(service.findAll(), "All users retrived successfully");
    }

    @GetMapping("/{id}")
    public DataResult<User> findById(@PathVariable long id) {
        User user = service.findById(id);
        return new SuccessDataResult<>(user, "User retrived Succesfully");
    }

    public User saveUser(User user) {
        user=service.save(user);
        return user;
    }

    @PostMapping
//    public DataResult<List<User>> findByRoleId(@PathVariable int id) {
    public DataResult<List<User>> saveFakePatient_HCP_Disesase() {
        Random random = new Random();

        List<User> userList = new ArrayList<>();
        for (int i = 1; i <= 3; i++) {
            User hcp = new Doctor();
            hcp.setName("hcp" + i);
            hcp.setLastname("hcp" + i);
            hcp.setUsername("hcp" + i);
            hcp.setPassword("hcp");
//            service.save(hcp);
            System.out.println("SAVELENECEK HCP  :" + hcp);
            hcp = service.save(hcp);

            userList.add(hcp);
        }

        for (int i = 3; i <= 13; i++) {
            Patient p = new Patient();

            Doctor hcp = (Doctor) service.findById(random.nextInt(3) + 3);
            p.setDoctorId(hcp.getId());
            p.setName("pat" + i);
            p.setLastname("pat" + i);
            p.setUsername("pat" + i);
            p.setPassword("pat");
            System.out.println("PATIENT KAYDEDILECEK " + p);
            service.save(p);

//            p = (Patient) service.save(p);
//            userList.add(p);
        }

        for (int i = 4; i <= 5; i++) {
            Patient patient = (Patient) service.findById(i);
            List<Disease> diseaseList = new ArrayList<>();
            int diseaseNumber = random.nextInt(5) + 1;
            for (int j = 1; j <= diseaseNumber; j++) {
                Diabetic diabetic = new Diabetic();
                diabetic.setPatientId(patient.getId());
                diabetic.setBloodPressure(random.nextInt(100));
                diabetic.setBloodSugar(random.nextInt(100));
                diabetic.setCholesterol(random.nextInt(100));
                diabetic.setPatientId(patient.getId());
                diseaseList.add(diabetic);
            }
            userList.add(patient);
        }
        for (int i = 0; i < 50; i++) {
            Diabetic dis = new Diabetic();
            Patient pat = (Patient) service.findById(random.nextInt(10) + 4);
            dis.setPatientId(pat.getId());
            dis.setCholesterol(random.nextInt(500));
            dis.setBloodSugar(random.nextInt(500));
            dis.setBloodPressure(random.nextInt(500));
            diseaseService.save(dis);
        }
        return new SuccessDataResult<>(userList, "FAKE Userlar kaydedildi");
    }
    /*@GetMapping("/roleid/{id}")
    public DataResult<List<User>> findByRoleId(@PathVariable int id) {
        List<User> userList = service.findAllByRoleId(id);

      *//*  System.out.println("----------------------------------");
        UserRole role = roleService.findById(id);
        String msg;
        if (role == null) {
            return new SuccessDataResult<>("Unknown User type is requested");
        }
        if (userList.isEmpty()) {
            msg = "Found no one in " + role.getRole() + " user type";
        } else {
            msg = role.getRole() + " list is retrived";
        }*//*
        return new SuccessDataResult<>(userList, msg);
    }*/

    @PostMapping("/login")
    public DataResult<User> login(@RequestBody LoginCredentials loginCreds) {
        LoginValidationService loginService = new LoginCredentialsValidation(service);
        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());
        System.out.println(result.getData().getId().getClass().getSimpleName());
        return result;
    }

    /*@PostMapping("/signup")
    public DataResult<User> signup(@RequestBody LoginCredentials loginCreds) {
        SignupValidationService signupService = new SignupCredentialsValidation(service);
        Result result = signupService.validateSingupCredentials(loginCreds.getUsername());
        if(!result.isSuccess()){
            throw new ApiRequestException(HttpStatus.CONFLICT, "Please change username");
        }
        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());
        return result;
    }*/
}

