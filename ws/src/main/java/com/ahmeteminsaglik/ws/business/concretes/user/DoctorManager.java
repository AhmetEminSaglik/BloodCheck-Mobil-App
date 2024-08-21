package com.ahmeteminsaglik.ws.business.concretes.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.DoctorService;
import com.ahmeteminsaglik.ws.dataaccess.user.DoctorRepository;
import com.ahmeteminsaglik.ws.model.users.Doctor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DoctorManager implements DoctorService {
    private static final Logger log = LoggerFactory.getLogger(PatientManager.class);

    @Autowired
    DoctorRepository repository;

    @Override
    public List<Doctor> findAll() {
        return repository.findAll();
    }
}
