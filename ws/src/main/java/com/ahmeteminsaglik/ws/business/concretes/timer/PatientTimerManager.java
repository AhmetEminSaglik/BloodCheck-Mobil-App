package com.ahmeteminsaglik.ws.business.concretes.timer;

import com.ahmeteminsaglik.ws.business.abstracts.timer.PatientTimerService;
import com.ahmeteminsaglik.ws.dataaccess.timer.PatientTimerRepository;
import com.ahmeteminsaglik.ws.model.timer.PatientTimer;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PatientTimerManager implements PatientTimerService {
    private final PatientTimerRepository repository;

    @Autowired
    public PatientTimerManager(PatientTimerRepository repository) {
        this.repository = repository;
    }

    @Override
    public PatientTimer save(PatientTimer patientTimer) {
        return repository.save(patientTimer);
    }

    @Override
    public PatientTimer findByPatientId(long patientId) {
        return repository.findByPatientId(patientId);
    }

    @Override
    public List<PatientTimer> findAll() {
        return repository.findAll();
    }

    @Override
    public PatientTimer update(PatientTimer patientTimer) {
        PatientTimer newPatientTimer = findByPatientId(patientTimer.getPatientId());
        if (newPatientTimer != null) {
            newPatientTimer.setHours(patientTimer.getHours());
            newPatientTimer.setMinutes(patientTimer.getMinutes());
        }
        newPatientTimer = save(newPatientTimer);
        return repository.save(newPatientTimer);
    }

    @Override
    @Transactional
    public void deleteAll() {
        repository.deleteAll();
        repository.resetAutoIncrement();
    }
}
