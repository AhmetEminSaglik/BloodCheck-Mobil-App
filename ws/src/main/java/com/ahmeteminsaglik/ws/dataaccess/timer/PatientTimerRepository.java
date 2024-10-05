package com.ahmeteminsaglik.ws.dataaccess.timer;

import com.ahmeteminsaglik.ws.model.timer.PatientTimer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface PatientTimerRepository extends JpaRepository<PatientTimer, Long> {
    PatientTimer findByPatientId(long patientId);

    @Modifying
    @Query(value = "ALTER TABLE patient_timers AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
