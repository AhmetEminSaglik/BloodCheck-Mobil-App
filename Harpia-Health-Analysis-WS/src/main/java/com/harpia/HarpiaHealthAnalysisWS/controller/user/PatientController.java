package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.Patient;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/patients")
@CrossOrigin
public class PatientController {
    protected static final Logger log = LoggerFactory.getLogger(PatientController.class);

    @Autowired
    private UserService service;

    @PostMapping("")
    public DataResult<Patient> savePatient(@RequestBody Patient patient) {
        Patient p = (Patient) service.save(patient);
        log.info("Patient is saved : ", p);
        return new SuccessDataResult<>(p, "Patient is saved");
    }
}
