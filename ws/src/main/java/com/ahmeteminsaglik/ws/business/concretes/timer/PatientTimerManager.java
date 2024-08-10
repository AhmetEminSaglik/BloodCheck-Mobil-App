package com.ahmeteminsaglik.ws.business.concretes.timer;

import com.ahmeteminsaglik.ws.business.abstracts.timer.PatientTimerService;
import com.ahmeteminsaglik.ws.dataaccess.timer.PatientTimerRepository;
import com.ahmeteminsaglik.ws.model.timer.PatientTimer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PatientTimerManager implements PatientTimerService {
    @Autowired
    PatientTimerRepository repoSitory;

    @Override
    public PatientTimer save(PatientTimer patientTimer) {
        return repoSitory.save(patientTimer);
    }

    @Override
    public PatientTimer findByPatientId(long patientId) {
        return repoSitory.findByPatientId(patientId);
    }

    @Override
    public List<PatientTimer> findAll() {
        return repoSitory.findAll();
    }
}
