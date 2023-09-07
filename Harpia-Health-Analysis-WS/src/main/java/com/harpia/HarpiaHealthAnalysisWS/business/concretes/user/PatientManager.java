package com.harpia.HarpiaHealthAnalysisWS.business.concretes.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.PatientService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.user.PatientRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PatientManager implements PatientService {
    @Autowired
    PatientRepository repository;

    @Override
    public List<Patient> findAllPatientByDoctorId(long doctorId) {
        return repository.findAllPatientByDoctorIdOrderByIdDesc(doctorId);
    }

    @Override
    public Patient findById(long patientId) {
//        List<Long> list = repository.findDoctorIdById(patientId);
//        System.out.println("List Size : " + list.size());
//        list.forEach(e -> {
//            System.out.println("patient Id ile gelen Doctor : ");
//        });
        return repository.findById(patientId);//.get(0);
    }
}
