package com.harpia.HarpiaHealthAnalysisWS.business.concretes.diabetic;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.BloodResultService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.diabetic.BloodResultRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class BloodResultManager implements BloodResultService {
    @Autowired
    BloodResultRepository repository;

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
        return repository.findAllByPatientIdAndCreatedAtAfter(patientId, time);
    }
}
