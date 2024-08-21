package com.ahmeteminsaglik.ws.business.abstracts.user;

import com.ahmeteminsaglik.ws.model.users.Doctor;

import java.util.List;

public interface DoctorService {
    List<Doctor> findAll();
}
