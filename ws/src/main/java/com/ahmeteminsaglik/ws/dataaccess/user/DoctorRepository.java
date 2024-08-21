package com.ahmeteminsaglik.ws.dataaccess.user;

import com.ahmeteminsaglik.ws.model.users.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DoctorRepository extends JpaRepository<Doctor, Integer> {

}
