package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.Admin;
import com.harpia.HarpiaHealthAnalysisWS.model.HealthcarePersonnel;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/healthcare_personnels")
@CrossOrigin
public class HealthcarePersonnelController {
    protected static final Logger log = LoggerFactory.getLogger(HealthcarePersonnelController.class);

    @Autowired
    private UserService service;

    @PostMapping("")
    public DataResult<HealthcarePersonnel> saveHealthcarePersonnel(@RequestBody HealthcarePersonnel inputPersonel) {
        HealthcarePersonnel personel = (HealthcarePersonnel) service.save(inputPersonel);
        log.info("Healthcare Personnel is saved : ", personel);
        return new SuccessDataResult<>(personel, "Healthcare Personnel is saved");
    }

    @GetMapping("/{id}")
    public DataResult<HealthcarePersonnel> findById(@PathVariable long id) {
        HealthcarePersonnel personnel = (HealthcarePersonnel) service.findById(id);
        return new SuccessDataResult<>(personnel, "Healthcare Personnel retrived Succesfully");
    }
}
