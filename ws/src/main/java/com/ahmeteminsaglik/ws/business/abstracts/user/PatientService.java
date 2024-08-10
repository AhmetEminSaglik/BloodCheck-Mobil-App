package com.ahmeteminsaglik.ws.business.abstracts.user;

import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.Patient;

import java.util.List;

public interface PatientService {
    List<Patient> findAllPatientByDoctorId(long doctorId);
    Patient findById(long patientId);
}
