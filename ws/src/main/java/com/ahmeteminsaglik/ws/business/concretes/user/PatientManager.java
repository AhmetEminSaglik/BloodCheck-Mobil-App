package com.ahmeteminsaglik.ws.business.concretes.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.dataaccess.user.PatientRepository;
import com.ahmeteminsaglik.ws.model.users.Patient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PatientManager implements PatientService {
    private static final Logger log = LoggerFactory.getLogger(PatientManager.class);

    private final PatientRepository repository;

    @Autowired
    public PatientManager(PatientRepository repository) {
        this.repository = repository;
    }

    @Override
    public List<Patient> findAllPatientByDoctorId(long doctorId) {
        return repository.findAllPatientByDoctorIdOrderByIdDesc(doctorId);
    }

    @Override
    public Patient findById(long patientId) {
        return repository.findById(patientId);
    }

    @Override
    public List<Patient> findAll() {
        return repository.findAll();
    }
}
