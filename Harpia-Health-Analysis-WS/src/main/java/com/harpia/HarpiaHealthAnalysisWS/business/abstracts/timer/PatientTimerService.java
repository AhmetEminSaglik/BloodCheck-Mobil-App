package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.timer;

import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;

import java.util.List;

public interface PatientTimerService {
    PatientTimer save(PatientTimer patientTimer);

    PatientTimer findByPatientId(long patientId);

    List<PatientTimer> findAll();

}
