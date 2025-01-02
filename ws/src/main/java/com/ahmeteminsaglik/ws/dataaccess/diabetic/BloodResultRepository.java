package com.ahmeteminsaglik.ws.dataaccess.diabetic;

import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.List;

public interface BloodResultRepository extends JpaRepository<BloodResult, Long> {

    List<BloodResult> findAllPatientByOrderByIdDesc();


//    List<BloodResult> findAllByPatientIdAndCreatedAtAfterOrderByIdDesc(int patientId, LocalDateTime time);
List<BloodResult> findAllByPatientIdAndCreatedAtAfterOrderByIdDesc(
            int patientId, LocalDateTime time);

    List<BloodResult> findAllBloodResultByPatientIdOrderByIdDesc(int patientId);

    @Modifying
    @Query(value = "ALTER TABLE blood_results AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
