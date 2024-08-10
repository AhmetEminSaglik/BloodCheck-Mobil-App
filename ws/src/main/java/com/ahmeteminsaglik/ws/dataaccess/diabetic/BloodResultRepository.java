package com.ahmeteminsaglik.ws.dataaccess.diabetic;

import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface BloodResultRepository extends JpaRepository<BloodResult, Long> {

    List<BloodResult> findAllPatientByOrderByIdDesc();

    List<BloodResult> findAllByPatientIdAndCreatedAtAfterOrderByIdDesc(int patientId, LocalDateTime time);

    List<BloodResult> findAllBloodResultByPatientIdOrderByIdDesc(int patientId);
}
