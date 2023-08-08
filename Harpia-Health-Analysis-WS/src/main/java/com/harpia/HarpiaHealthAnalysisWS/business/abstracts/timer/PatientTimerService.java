package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.timer;

import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;

public interface PatientTimerService {
    PatientTimer save(PatientTimer patientTimer);
    PatientTimer update(PatientTimer patientTimer);
    PatientTimer findByPatientId(long patientId);

}
