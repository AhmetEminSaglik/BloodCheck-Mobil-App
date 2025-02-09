package com.ahmeteminsaglik.ws.business.concretes.bloodresult;

import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultService;
import com.ahmeteminsaglik.ws.dataaccess.diabetic.BloodResultRepository;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BloodResultManager implements BloodResultService {
    private final BloodResultRepository repository;

    @Autowired
    public BloodResultManager(BloodResultRepository repository) {
        this.repository = repository;
    }

    @Override
    public BloodResult save(BloodResult BloodResult) {
        return repository.save(BloodResult);
    }

    @Override
    public List<BloodResult> saveList(List<BloodResult> list) {
        return repository.saveAll(list);
    }

    @Override
    public List<BloodResult> findAll() {
        return repository.findAll();
    }

    @Override
    public List<BloodResult> findAllByPatientIdAndCreatedAtAfter(int patientId, LocalDateTime time) {
        return repository.findAllByPatientIdAndCreatedAtAfterOrderByIdDesc(patientId, time);
    }

    @Override
    public List<BloodResult> findAllBloodResultByPatientId(int patientId) {
        return repository.findAllBloodResultByPatientIdOrderByIdDesc(patientId);
    }

    @Override
    public List<BloodResult> findAllPatientByOrderByIdDesc() {
        return repository.findAllPatientByOrderByIdDesc();
    }

    @Override
    @Transactional
    public void deleteAll() {
        repository.deleteAll();
        repository.resetAutoIncrement();
    }
}
