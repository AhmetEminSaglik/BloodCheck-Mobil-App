package com.harpia.HarpiaHealthAnalysisWS.dataaccess.timer;

import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientTimerRepository extends JpaRepository<PatientTimer, Long> {
    PatientTimer findByPatientId(long patientId);
}
