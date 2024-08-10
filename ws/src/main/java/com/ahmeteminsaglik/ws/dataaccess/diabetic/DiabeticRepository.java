package com.ahmeteminsaglik.ws.dataaccess.diabetic;

import com.ahmeteminsaglik.ws.model.diabetic.Diabetic;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DiabeticRepository extends JpaRepository<Diabetic, Long> {

}
