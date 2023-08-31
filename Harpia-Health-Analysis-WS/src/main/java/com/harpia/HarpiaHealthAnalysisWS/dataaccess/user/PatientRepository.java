package com.harpia.HarpiaHealthAnalysisWS.dataaccess.user;

import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PatientRepository extends JpaRepository<Patient, Long> {
    List<Patient> findAllPatientByDoctorIdOrderByIdDesc(long doctorId);

    Patient findById(long patientId);
}
