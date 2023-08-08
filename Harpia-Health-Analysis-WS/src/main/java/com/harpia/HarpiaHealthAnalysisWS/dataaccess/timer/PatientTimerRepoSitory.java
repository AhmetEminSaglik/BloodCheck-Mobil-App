package com.harpia.HarpiaHealthAnalysisWS.dataaccess.timer;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.timer.PatientTimerService;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientTimerRepoSitory extends JpaRepository<PatientTimer, Long> {
    PatientTimer findByPatientId(long patientId);
}
