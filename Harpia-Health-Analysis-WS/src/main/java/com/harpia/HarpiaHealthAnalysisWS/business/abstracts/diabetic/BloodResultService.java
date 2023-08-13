package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic;

import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;

import java.time.LocalDateTime;
import java.util.List;

public interface BloodResultService {
    BloodResult save(BloodResult BloodResult);

    List<BloodResult> saveList(List<BloodResult> list);

    List<BloodResult> findAll();

    List<BloodResult> findAllByPatientIdAndCreatedAtAfter(int patientId, LocalDateTime time);
    List<BloodResult> findAllBloodResultByPatientId(int patientId);

}
