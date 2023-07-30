package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user;

import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;

import java.util.List;

public interface PatientService {
    List<Patient> findAllPatientByDoctorId(long doctorId);
}
