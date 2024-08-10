package com.ahmeteminsaglik.ws.business.concretes.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.dataaccess.user.PatientRepository;
import com.ahmeteminsaglik.ws.model.users.Patient;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PatientManager implements PatientService {
    private static CustomLog log = new CustomLog(PatientManager.class);

    @Autowired
    PatientRepository repository;

    public PatientManager() {
        log.info("PatientManager > PatientRepository : " + repository);
    }

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
