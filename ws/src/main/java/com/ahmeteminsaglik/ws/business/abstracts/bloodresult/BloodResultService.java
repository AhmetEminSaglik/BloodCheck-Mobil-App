package com.ahmeteminsaglik.ws.business.abstracts.bloodresult;

import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.List;

public interface BloodResultService {

    BloodResult save(BloodResult BloodResult);

    List<BloodResult> saveList(List<BloodResult> list);

    List<BloodResult> findAll();

    List<BloodResult> findAllByPatientIdAndCreatedAtAfter(int patientId, LocalDateTime time);

    List<BloodResult> findAllBloodResultByPatientId(int patientId);

    List<BloodResult> findAllPatientByOrderByIdDesc();

}
