package com.ahmeteminsaglik.ws.dataaccess.timer;

import com.ahmeteminsaglik.ws.model.timer.PatientTimer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientTimerRepository extends JpaRepository<PatientTimer, Long> {
    PatientTimer findByPatientId(long patientId);
}
