package com.ahmeteminsaglik.ws.business.abstracts.timer;

import com.ahmeteminsaglik.ws.model.timer.PatientTimer;

import java.util.List;

public interface PatientTimerService {
    PatientTimer save(PatientTimer patientTimer);

    PatientTimer findByPatientId(long patientId);

    List<PatientTimer> findAll();

    PatientTimer update(PatientTimer patientTimer);
}
