package com.harpia.HarpiaHealthAnalysisWS.business.concretes.timer;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.timer.PatientTimerService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.timer.PatientTimerRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
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

  /*  @Override
    public PatientTimer update(PatientTimer newTimer) {
//        PatientTimer newPatientTimer = repoSitory.findByPatientId(newTimer.getPatientId());
//        newPatientTimer.setHours(newTimer.getHours());
//        newPatientTimer.setMinutes(newTimer.getMinutes());
        return repoSitory.save(newTimer);
    }
*/
    @Override
    public PatientTimer findByPatientId(long patientId) {
        return repoSitory.findByPatientId(patientId);
    }

    @Override
    public List<PatientTimer> findAll() {
        return repoSitory.findAll();
    }
}
