package com.harpia.HarpiaHealthAnalysisWS.controller;

import com.harpia.HarpiaHealthAnalysisWS.model.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

public class PatientController extends UserController {

    @GetMapping("/patient")
    public DataResult<Patient> savePatient(@RequestBody Patient patient) {
        Patient p = (Patient) service.save(patient);
        return new SuccessDataResult<>(p, "Patient is saved");


    }
}
