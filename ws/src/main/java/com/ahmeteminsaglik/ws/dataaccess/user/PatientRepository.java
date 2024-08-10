package com.ahmeteminsaglik.ws.dataaccess.user;

import com.ahmeteminsaglik.ws.model.users.Patient;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PatientRepository extends JpaRepository<Patient, Long> {
    List<Patient> findAllPatientByDoctorIdOrderByIdDesc(long doctorId);

    Patient findById(long patientId);
}
