package com.ahmeteminsaglik.ws.controller.database;

import com.ahmeteminsaglik.ws.business.abstracts.auth.AuthorityService;
import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultService;
import com.ahmeteminsaglik.ws.business.abstracts.diabetic.DiabeticService;
import com.ahmeteminsaglik.ws.business.abstracts.timer.PatientTimerService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.abstracts.util.DeleteService;
import com.ahmeteminsaglik.ws.business.concretes.InitialDataLoader;
import com.ahmeteminsaglik.ws.utility.result.Result;
import com.ahmeteminsaglik.ws.utility.result.SuccessResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/db")
public class DatabaseController {
    private static final Logger log = LoggerFactory.getLogger(DatabaseController.class);

    private final InitialDataLoader initialDataLoader;
    private final UserService userService;
    private final BloodResultService bloodResultService;
    private final DiabeticService diabeticService;
    private final PatientTimerService patientTimerService;
    private final AuthorityService authorityService;

    @Autowired
    public DatabaseController(InitialDataLoader initialDataLoader, UserService userService, BloodResultService bloodResultService, DiabeticService diabeticService, PatientTimerService patientTimerService, AuthorityService authorityService) {
        this.initialDataLoader = initialDataLoader;
        this.userService = userService;
        this.bloodResultService = bloodResultService;
        this.diabeticService = diabeticService;
        this.patientTimerService = patientTimerService;
        this.authorityService = authorityService;
    }

    @GetMapping()
    public ResponseEntity<Result> resetAllData() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                deleteAllData();
                createData();
            }
        }).start();
        return ResponseEntity.status(HttpStatus.OK).body(new SuccessResult("Reset database process was started."));
    }

    private void deleteAllData() {
        printLogDataStart(userService, userService.findAll().size());
        printLogDataCompleted(userService, userService.findAll().size());

        printLogDataStart(bloodResultService, bloodResultService.findAll().size());
        printLogDataCompleted(bloodResultService, bloodResultService.findAll().size());

        printLogDataStart(diabeticService, diabeticService.findAll().size());
        printLogDataCompleted(diabeticService, diabeticService.findAll().size());

        printLogDataStart(patientTimerService, patientTimerService.findAll().size());
        printLogDataCompleted(patientTimerService, patientTimerService.findAll().size());

    }

    private void createData() {
        initialDataLoader.saveInitializedData();
    }

    private void printLogDataStart(DeleteService deleteService, int dataSize) {
        log.info(deleteService.getClass().getSimpleName().toUpperCase() + " deleteAll process is started. (Size: " + dataSize + ")");
        deleteService.deleteAll();
    }

    private void printLogDataCompleted(DeleteService deleteService, int dataSize) {
        log.info(deleteService.getClass().getSimpleName().toUpperCase() + " deleteAll process is completed. (Size: " + dataSize + ")");
    }
}
